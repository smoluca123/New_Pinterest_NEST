import {
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { handleDefaultError } from 'src/global/functions.global';
import { UserInfoUpdateDto, UserUpdateDto } from './dto/UserUpdate.dto';
import {
  IDecodedAccecssTokenType,
  IResponseType,
} from 'src/interfaces/interfaces.global';
import * as bcrypt from 'bcrypt';
import { PrismaService } from 'src/prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class UserService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
  ) {}

  async getListUsers(
    limit: string | number,
    page: string | number,
    keyword: string,
    type: string | number,
  ): Promise<IResponseType> {
    try {
      limit = limit ? +limit : 3;
      page = page ? +page : 1;

      const whereQuery = {
        AND: [
          {
            OR: [
              { username: { contains: keyword } },
              { email: { contains: keyword } },
            ],
          },
          {
            type: type ? +type : undefined,
          },
        ],
      };
      const listUsers = await this.prisma.users.findMany({
        where: whereQuery,
        select: {
          id: true,
          username: true,
          email: true,
          full_name: true,
          age: true,
          user_type: true,
          is_ban: true,
          created_at: true,
          updated_at: true,
        },
        take: limit,
        skip: (page - 1) * limit,
      });

      const totalItems = await this.prisma.users.count({ where: whereQuery });

      return {
        message: 'Get list users successfully!',
        statusCode: 200,
        data: {
          currentPage: page,
          totalPage: Math.ceil(totalItems / limit),
          totalItems,
          items: listUsers,
        },
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async getInfomation(
    decodedAccessToken: IDecodedAccecssTokenType,
  ): Promise<IResponseType> {
    try {
      const { id, username } = decodedAccessToken;
      const userInfo = await this.prisma.users.findFirst({
        where: {
          id: +id,
          username,
        },
      });

      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      const { type, is_ban, password, refresh_token, ...userResult } = userInfo;

      return {
        message: 'Get my infomation successfully!',
        statusCode: 200,
        data: { ...userResult },
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async refreshToken(accessToken: string): Promise<IResponseType> {
    try {
      const { id, username, key } = this.jwt.verify<IDecodedAccecssTokenType>(
        accessToken,
        {
          ignoreExpiration: false,
        },
      );

      const checkUser = await this.prisma.users.findFirst({
        where: {
          id: +id,
          username,
        },
      });
      if (!checkUser) throw new NotFoundException('User not found!');

      const { key: refreshTokenKey } =
        this.jwt.verify<IDecodedAccecssTokenType>(checkUser.refresh_token);
      if (refreshTokenKey !== key)
        throw new UnauthorizedException('Tokens have been leaked');

      const newKey = new Date().getTime();
      const newAccessToken = this.jwt.sign({
        id: checkUser.id,
        username: checkUser.username,
        key: newKey,
      });
      const newRefreshToken = this.jwt.sign(
        {
          id: checkUser.id,
          username: checkUser.username,
          key: newKey,
        },
        { expiresIn: '30d' },
      );

      const {
        /* eslint-disable @typescript-eslint/no-unused-vars*/
        type,
        password: _pw,
        refresh_token,
        is_ban,
        ...userResult
      } = await this.prisma.users.update({
        where: {
          id: checkUser.id,
        },
        data: {
          refresh_token: newRefreshToken,
        },
      });
      /* eslint-enable @typescript-eslint/no-unused-vars*/

      return {
        message: 'Refresh token successfully!',
        statusCode: 200,
        data: { ...userResult, accessToken: newAccessToken },
        date: new Date(),
      };
    } catch (error) {
      if (
        error.name === 'TokenExpiredError' ||
        error.name === 'JsonWebTokenError'
      ) {
        throw new UnauthorizedException('Access token is expired or invalid');
      }
      handleDefaultError(error);
    }
  }

  async updateInfo(
    decodedAccessToken: IDecodedAccecssTokenType,
    userInfo: UserInfoUpdateDto,
  ): Promise<IResponseType> {
    try {
      const { id } = decodedAccessToken;
      const { username, email, fullName: full_name, age, password } = userInfo;
      const checkUser = await this.prisma.users.findFirst({
        where: {
          id: +id,
        },
      });

      if (!checkUser) throw new NotFoundException('User not found!');
      const key = new Date().getTime();
      const accessToken = await this.jwt.signAsync({
        id: checkUser.id,
        username: username || checkUser.username,
        key,
      });
      const refreshToken = await this.jwt.signAsync(
        {
          id: checkUser.id,
          username: username || checkUser.username,
          key,
        },
        {
          expiresIn: '30d',
        },
      );

      const hashPassword = password && bcrypt.hashSync(password, 10);
      const updatedUser = await this.prisma.users.update({
        data: {
          username: username || undefined,
          email: email || undefined,
          full_name: full_name || undefined,
          age: age || undefined,
          password: hashPassword || undefined,
          refresh_token: refreshToken,
          updated_at: new Date(),
        },
        where: {
          id: checkUser.id,
        },
      });
      /* eslint-disable @typescript-eslint/no-unused-vars*/
      const {
        is_ban,
        type,
        refresh_token,
        password: _pw,
        ...userResult
      } = updatedUser;
      /* eslint-enable @typescript-eslint/no-unused-vars*/

      return {
        message: 'Update info successfully!',
        statusCode: 200,
        data: { ...userResult, accessToken },
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async updateUser(
    id: number,
    userInfo: UserUpdateDto,
  ): Promise<IResponseType> {
    const {
      username,
      email,
      fullName: full_name,
      age,
      password,
      is_ban,
      type,
    } = userInfo;
    const user = await this.prisma.users.findUnique({
      where: {
        id,
      },
    });

    if (type) {
      const checkType = await this.prisma.user_type.findFirst({
        where: {
          id: +type,
        },
      });
      if (!checkType) throw new NotFoundException('User type not found!');
    }

    if (!user) throw new NotFoundException('User not found!');

    const hashPassword = password && bcrypt.hashSync(password, 10);
    const key = new Date().getTime();
    const accessToken = await this.jwt.signAsync({
      id: user.id,
      username: username || user.username,
      key,
    });
    const refreshToken = await this.jwt.signAsync(
      {
        id: user.id,
        username: username || user.username,
        key,
      },
      {
        expiresIn: '30d',
      },
    );
    const updatedUser = await this.prisma.users.update({
      where: {
        id,
      },
      data: {
        username: username || undefined,
        email: email || undefined,
        full_name: full_name || undefined,
        age: age || undefined,
        password: hashPassword || undefined,
        is_ban: is_ban ?? undefined,
        type: type || undefined,
        refresh_token: refreshToken,
        updated_at: new Date(),
      },
      include: {
        user_type: true,
      },
    });

    /* eslint-disable @typescript-eslint/no-unused-vars*/
    const {
      password: _pw,
      refresh_token,
      type: _type,
      ...userResult
    } = updatedUser;
    /* eslint-enable @typescript-eslint/no-unused-vars*/

    try {
      return {
        message: 'Update user successfully!',
        statusCode: 200,
        data: { ...userResult, accessToken },
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }
}
