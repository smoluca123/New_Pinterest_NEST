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
import {
  generateSecureVerificationCode,
  handleDefaultError,
} from 'src/global/functions.global';
import * as bcrypt from 'bcrypt';
import { ACTIVE_STATUS } from './enums';
import { EmailService } from '../email/email.service';
import { SendActivationMailDto } from './dto/SendMail.dto';
import { isPast } from 'date-fns';
import { ActivationByCodeDto } from './dto/ActivationByCode.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly emailService: EmailService,
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
      if (!checkUsername.is_active)
        throw new ForbiddenException({
          message: 'Account has not been activated',
          error: 'ACCOUNT_NOT_ACTIVATED',
          statusCode: 403,
        });

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

      if (checkUser) {
        if (checkUser.username)
          throw new ConflictException('Username already exists!');
        if (checkUser.email)
          throw new ConflictException('Email already exists!');
      }

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
          is_active: ACTIVE_STATUS.IS_ACTIVE,
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

      // const accessToken = await this.jwt.signAsync({
      //   id: createdUser.id,
      //   username: createdUser.username,
      //   key: time.getTime(),
      // });
      const refreshToken = await this.jwt.signAsync(
        {
          id: createdUser.id,
          username: createdUser.username,
          key: time.getTime(),
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

      await this.sendActivationMail({
        userId: createdUser.id,
      });

      return {
        message:
          'Sign up successfully! Check email and activate your account please!',
        data: { ...userResult },
        statusCode: 201,
        date: new Date(),
      };
    } catch (error) {
      console.log(error);
      handleDefaultError(error);
    }
  }

  async sendActivationMail(
    data: SendActivationMailDto,
  ): Promise<IResponseType> {
    try {
      const EXPIRATION_MINUTES = 10;
      const { userId } = data;
      const currentDate = new Date();

      const checkUser = await this.prisma.user.findFirst({
        where: {
          id: +userId,
        },
      });
      const checkCode = await this.prisma.active_code.findFirst({
        where: {
          user_id: +userId,
          // AND: {
          //   expires_at: {
          //     gt: currentDate,
          //   },
          // },
        },
      });

      if (!checkUser) throw new NotFoundException('User not found');
      if (checkUser.is_active)
        throw new BadRequestException('User is already active');

      const activeCode = checkCode?.code || generateSecureVerificationCode();

      if (!checkCode) {
        await this.prisma.active_code.create({
          data: {
            user_id: +userId,
            code: activeCode,
            expires_at: new Date(
              currentDate.getTime() + EXPIRATION_MINUTES * 60 * 1000,
            ),
            created_at: currentDate,
          },
        });
      } else {
        const isExpired = isPast(new Date(checkCode.expires_at));
        if (isExpired) {
          await this.prisma.active_code.update({
            data: {
              code: generateSecureVerificationCode(),
              expires_at: new Date(
                currentDate.getTime() + EXPIRATION_MINUTES * 60 * 1000,
              ),
              created_at: currentDate,
            },
            where: {
              id: checkCode.id,
            },
          });
        }
      }

      await this.emailService.sendActiveAccountEmail({
        email: checkUser.email,
        context: {
          name: checkUser.full_name,
          // confirmationLink: '#test',
          verification_code: activeCode,
        },
      });

      return {
        statusCode: 204,
        data: null,
        message:
          'Account verification email has been sent to your email : ' +
          checkUser.email,
        date: currentDate,
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async activationByCode({
    userId,
    code,
  }: ActivationByCodeDto): Promise<IResponseType> {
    try {
      const checkUser = await this.prisma.user.findFirst({
        where: {
          id: userId,
        },
        include: {
          user_type: {
            select: {
              id: true,
              type_name: true,
            },
          },
        },
      });
      const checkCode = await this.prisma.active_code.findFirst({
        where: {
          user_id: userId,
          AND: {
            code,
            // expires_at: {
            //   gt: currentDate,
            // },
          },
        },
      });

      if (!checkUser) throw new NotFoundException('User not found');
      if (checkUser.is_active)
        throw new BadRequestException('User is already active');
      if (!checkCode)
        throw new BadRequestException('Verification code is invalid');

      const isExpired = isPast(checkCode.expires_at);
      if (isExpired)
        throw new BadRequestException(
          'Verification code is expired, resend to try again',
        );

      const key = new Date().getTime();
      const accessToken = await this.jwt.signAsync({
        id: checkUser.id,
        username: checkUser.username,
        key,
      });
      const refreshToken = await this.jwt.signAsync(
        {
          id: checkUser.id,
          username: checkUser.username,
          key,
        },
        {
          expiresIn: '30d',
        },
      );
      await this.prisma.user.update({
        data: {
          is_active: 1,
          refresh_token: refreshToken,
        },
        where: {
          id: checkUser.id,
        },
      });
      await this.prisma.active_code.delete({
        where: {
          id: checkCode.id,
        },
      });

      /* eslint-disable @typescript-eslint/no-unused-vars */
      const {
        password: _pw,
        refresh_token,
        type,
        is_ban,
        ...userResult
      } = checkUser;
      /* eslint-enable @typescript-eslint/no-unused-vars */

      return {
        statusCode: 200,
        message: 'Account activated successfully',
        data: { ...userResult, accessToken },
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }
}
