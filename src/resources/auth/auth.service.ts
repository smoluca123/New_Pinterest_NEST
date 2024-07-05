import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { IResponseType } from 'src/interfaces/interfaces.global';
import { UserLoginDto } from './dto/UserLogin.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';
import { UserRegisterDto } from './dto/UserRegister.dto';
import { handleDefaultError } from 'src/global/functions.global';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
  ) {}
  async login(credentials: UserLoginDto): Promise<IResponseType> {
    try {
      const { username, password } = credentials;
      const checkUsername = await this.prisma.user.findFirst({
        where: {
          OR: [{ username }, { email: username }],
        },
        include: {
          user_type: true,
        },
      });
      if (!checkUsername) {
        throw new NotFoundException('User not found!');
      }

      if (checkUsername.is_ban) throw new ForbiddenException('User is banned!');

      const checkPassword = bcrypt.compareSync(
        password,
        checkUsername.password,
      );
      if (!checkPassword) {
        throw new BadRequestException('Wrong password!');
      }

      /* eslint-disable @typescript-eslint/no-unused-vars */
      const {
        password: _pw,
        is_ban,
        refresh_token,
        type,
        ...userResult
      } = checkUsername;
      /* eslint-enable @typescript-eslint/no-unused-vars */

      const key = new Date().getTime();
      const accessToken = await this.jwt.signAsync({
        id: checkUsername.id,
        username: checkUsername.username,
        key,
      });
      const refreshToken = await this.jwt.signAsync(
        {
          id: checkUsername.id,
          username: checkUsername.username,
          key,
        },
        {
          expiresIn: '30d',
        },
      );

      await this.prisma.user.update({
        where: {
          id: checkUsername.id,
        },
        data: {
          refresh_token: refreshToken,
        },
      });

      return {
        statusCode: 200,
        message: 'Sign in successfully!',
        data: { ...userResult, accessToken },
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async register(credentials: UserRegisterDto): Promise<IResponseType> {
    try {
      const {
        username,
        fullName: full_name,
        age,
        email,
        password,
      } = credentials;

      const checkUser = await this.prisma.user.findFirst({
        where: {
          OR: [{ username }, { email }],
        },
      });

      if (checkUser.username)
        throw new ConflictException('Username already exists!');
      if (checkUser.email) throw new ConflictException('Email already exists!');

      const hashPassword = bcrypt.hashSync(password, 10);

      const time = new Date();
      const createdUser = await this.prisma.user.create({
        data: {
          username,
          full_name,
          age,
          email,
          password: hashPassword,
          created_at: time,
          updated_at: time,
        },
        include: {
          user_type: true,
        },
      });

      /* eslint-disable @typescript-eslint/no-unused-vars*/
      const {
        password: _pw,
        is_ban,
        refresh_token,
        type,
        ...userResult
      } = createdUser;
      /* eslint-enable @typescript-eslint/no-unused-vars*/

      const accessToken = await this.jwt.signAsync({
        id: createdUser.id,
        username: createdUser.username,
        key: new Date().getTime(),
      });
      const refreshToken = await this.jwt.signAsync(
        {
          id: createdUser.id,
          username: createdUser.username,
          key: new Date().getTime(),
        },
        { expiresIn: '30d' },
      );

      //   Update refresh_token in users table
      await this.prisma.user.update({
        where: {
          id: createdUser.id,
        },
        data: {
          refresh_token: refreshToken,
        },
      });
      return {
        message: 'Sign up successfully!',
        data: { ...userResult, accessToken },
        statusCode: 201,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }
}
