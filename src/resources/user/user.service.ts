import {
  BadRequestException,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { handleDefaultError } from 'src/global/functions.global';
import {
  UserBanDto,
  UserInfoUpdateDto,
  UserUpdateDto,
} from './dto/UserUpdate.dto';
import {
  IDecodedAccecssTokenType,
  IResponseType,
} from 'src/interfaces/interfaces.global';
import * as bcrypt from 'bcrypt';
import { PrismaService } from 'src/prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';
import { DEFAULT_LIMIT } from 'src/global/constant.global';
import { SupabaseService } from 'src/supabase/supabase.service';
import { userDataSelect } from 'src/interfaces/prisma-types';
import { Prisma } from '@prisma/client';

@Injectable()
export class UserService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly supabase: SupabaseService,
  ) {}

  async getListUsers(
    limit: string | number,
    page: string | number,
    keyword: string,
    type: string | number,
  ): Promise<IResponseType> {
    try {
      limit = limit ? +limit : DEFAULT_LIMIT;
      page = page ? +page : 1;

      const whereQuery: Prisma.userWhereInput = {
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
      const listUsers = await this.prisma.user.findMany({
        where: whereQuery,
        select: userDataSelect,
        take: limit,
        skip: (page - 1) * limit,
      });

      const totalItems = await this.prisma.user.count({ where: whereQuery });

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
      const userInfo = await this.prisma.user.findFirst({
        where: {
          id: +id,
          username,
        },
        select: userDataSelect,
      });

      return {
        message: 'Get my infomation successfully!',
        statusCode: 200,
        data: { ...userInfo },
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async getInfomationByID(userId: number): Promise<IResponseType> {
    try {
      if (!userId) throw new BadRequestException('User ID is required!');

      const userInfo = await this.prisma.user.findUnique({
        where: {
          id: userId,
        },
        select: userDataSelect,
      });

      if (!userInfo) throw new NotFoundException('User not found!');

      return {
        message: 'Get user infomation successfully!',
        statusCode: 200,
        data: {
          ...userInfo,
        },
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
          ignoreExpiration: true,
        },
      );

      const checkUser = await this.prisma.user.findFirst({
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

      const updatedUser = await this.prisma.user.update({
        where: {
          id: checkUser.id,
        },
        data: {
          refresh_token: newRefreshToken,
        },
        select: userDataSelect,
      });
      /* eslint-enable @typescript-eslint/no-unused-vars*/

      return {
        message: 'Refresh token successfully!',
        statusCode: 200,
        data: { ...updatedUser, accessToken: newAccessToken },
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

  async banUser(userId: number, data: UserBanDto): Promise<IResponseType> {
    try {
      if (!userId) throw new BadRequestException('User ID is required!');
      const user = await this.prisma.user.findUnique({
        where: {
          id: userId,
        },
        select: userDataSelect,
      });
      if (!user) throw new NotFoundException('User not found!');

      if (data.is_ban !== user.is_ban) {
        await this.prisma.user.update({
          where: {
            id: userId,
          },
          data: {
            is_ban: data.is_ban,
          },
        });
      }
      return {
        message: 'Ban user successfully!',
        statusCode: 200,
        data: {
          ...user,
          is_ban: data.is_ban,
        },
        date: new Date(),
      };
    } catch (error) {
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
      const checkUser = await this.prisma.user.findFirst({
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
      const updatedUser = await this.prisma.user.update({
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
        select: userDataSelect,
      });

      return {
        message: 'Update info successfully!',
        statusCode: 200,
        data: { ...updatedUser, accessToken },
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
    const user = await this.prisma.user.findUnique({
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
    const updatedUser = await this.prisma.user.update({
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
      select: userDataSelect,
    });

    try {
      return {
        message: 'Update user successfully!',
        statusCode: 200,
        data: { ...updatedUser, accessToken },
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async updateUserAvatar({
    userId,
    file,
  }: {
    userId: string | number;
    file: Express.Multer.File;
  }) {
    try {
      // TODO: Implement avatar upload and deletion logic here

      if (!userId) throw new BadRequestException('User ID is required!');

      const checkUser = await this.prisma.user.findUnique({
        where: {
          id: +userId,
        },
      });
      if (!checkUser) throw new NotFoundException('User not found!');

      // TODO: Upload user avatar in the supabase storage service
      const { url } = await this.supabase.uploadFile(file);

      const updatedUser = await this.prisma.user.update({
        where: {
          id: +userId,
        },
        data: {
          avatar: url,
        },
        select: userDataSelect,
      });

      return {
        message: 'Update user avatar successfully!',
        statusCode: 200,
        data: updatedUser,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async deleteUser(userId: number): Promise<IResponseType> {
    try {
      if (!userId) throw new BadRequestException('User ID is required!');
      const user = await this.prisma.user.findUnique({
        where: {
          id: userId,
        },
      });
      if (!user || user.is_hidden)
        throw new NotFoundException('User not found!');

      await this.prisma.user.update({
        where: {
          id: userId,
        },
        data: {
          username: `${new Date().getTime()}_${user.username}`,
          email: `${new Date().getTime()}_${user.email}`,
          is_hidden: 1,
        },
      });

      return {
        message: 'Delete user successfully!',
        statusCode: 200,
        data: null,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }
}
