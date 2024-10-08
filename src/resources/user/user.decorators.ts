import { UseGuards, UseInterceptors, applyDecorators } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import {
  ApiBody,
  ApiConsumes,
  ApiHeader,
  ApiOperation,
  ApiParam,
  ApiQuery,
} from '@nestjs/swagger';

import { ApiQueryLimitAndPage } from 'src/decorators/global.decorators';
import { Roles } from 'src/decorators/roles.decorator';
import { JwtTokenVerifyGuard } from 'src/guards/jwt-token-verify.guard';
import { RolesLevel } from 'src/interfaces/interfaces.global';
import { UserAvatarUpdateDto } from 'src/resources/user/dto/UserUpdate.dto';

export const decoratorsListUsers = () =>
  applyDecorators(
    ApiOperation({
      summary: 'User List API',
      description: 'Get list of users',
    }),
    ApiQueryLimitAndPage(),
    ApiQuery({
      name: 'keyword',
      description: 'Search by keyword',
      required: false,
    }),
    ApiQuery({
      name: 'type',
      description: 'Search by type',
      required: false,
    }),
  );

export const decoratorsInfomation = () =>
  applyDecorators(
    UseGuards(JwtTokenVerifyGuard),
    ApiHeader({
      name: 'accessToken',
      description: 'Access Token',
      required: true,
    }),
    ApiOperation({
      summary: 'User Infomation API',
      description: 'Get current user infomation',
    }),
  );

export const decoratorsInfomationByID = () =>
  applyDecorators(
    ApiOperation({
      summary: 'User Infomation API',
      description: 'Get current user infomation',
    }),
    ApiParam({
      name: 'id',
      description: 'User ID',
    }),
  );

export const decoratorsRefreshToken = () =>
  applyDecorators(
    ApiHeader({
      name: 'accessToken',
      description: 'Access Token',
      required: true,
    }),
    ApiOperation({
      summary: 'User Refresh Token API',
      description: "Refresh the current user's access token",
    }),
  );

export const decoratorsBanUser = () =>
  applyDecorators(
    Roles([RolesLevel.ADMIN]),
    ApiOperation({
      summary: 'User Ban API (Admin Only)',
      description: 'Ban user',
    }),
    ApiParam({
      name: 'id',
      description: 'User ID',
    }),
  );

export const decoratorsUpdateInfo = () =>
  applyDecorators(
    UseGuards(JwtTokenVerifyGuard),
    ApiOperation({
      summary: 'User Update Info API',
      description:
        "Updates the current user's account information. Fields that are not to be updated should be left blank.",
    }),
    ApiHeader({
      name: 'accessToken',
      description: 'Access Token',
      required: true,
    }),
  );

export const decoratorsUpdateInfoByID = () =>
  applyDecorators(
    Roles([RolesLevel.ADMIN]),
    ApiOperation({
      summary: 'User Update API (Admin Only)',
      description:
        'Updates user account information. Fields that are not to be updated should be left blank.',
    }),
    ApiParam({
      name: 'id',
      description: 'User ID',
    }),
  );

export const decoratorsUpdateUserAvatar = () =>
  applyDecorators(
    ApiOperation({
      summary: 'User Update Avatar API',
      description: 'Update user avatar',
    }),
    ApiConsumes('multipart/form-data'),
    ApiParam({ name: 'id', description: 'User ID' }),
    ApiBody({ type: UserAvatarUpdateDto }),
    UseInterceptors(
      FileInterceptor('file', {
        // storage: multer.memoryStorage(),
        limits: {
          fileSize: 1024 * 1024 * 50, //50MB
        },
        fileFilter(req, file, cb) {
          // /^.*\.(jpg|jpeg|png|gif|bmp|webp)$/i
          if (!file.mimetype.match('image/*')) {
            console.log('Cancel upload, file not support');
            // Block image upload in public/img folder
            cb(null, false);
          } else {
            cb(null, true);
          }
        },
      }),
    ),
  );

export const decoratorsDeleteUser = () =>
  applyDecorators(
    Roles([RolesLevel.ADMIN]),
    ApiParam({
      name: 'id',
      description: 'User ID',
    }),
    ApiOperation({
      summary: 'User Delete API (Admin Only)',
      description: 'Delete user',
    }),
  );
