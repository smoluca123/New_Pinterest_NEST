import { UseGuards, UseInterceptors, applyDecorators } from '@nestjs/common';
import {
  ApiBody,
  ApiConsumes,
  ApiHeader,
  ApiOperation,
  ApiParam,
  ApiQuery,
} from '@nestjs/swagger';
import { Roles } from 'src/decorators/roles.decorator';
import { JwtTokenVerifyGuard } from 'src/guards/jwt-token-verify.guard';
import { RolesLevel } from 'src/interfaces/interfaces.global';
import { MediaUploadDto } from './dto/MediaUpload.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import * as multer from 'multer';
import { ApiQueryLimitAndPage } from 'src/decorators/global.decorators';

export const decoratorsGetMediaList = () =>
  applyDecorators(
    ApiOperation({
      summary: 'Media List API',
      description: 'Get list of media',
    }),
    ApiQueryLimitAndPage(),
    ApiQuery({ name: 'keyword', required: false }),
  );

export const decoratorsGetMediaUploadedByUserID = () =>
  applyDecorators(
    ApiOperation({
      summary: 'Media List Uploaded By User API',
      description: 'Get list media uploaded by user',
    }),
    ApiParam({ name: 'id', required: true, description: 'User Id' }),
    ApiQueryLimitAndPage(),
    ApiQuery({ name: 'keyword', required: false }),
  );

export const decoratorsGetComments = () =>
  applyDecorators(
    ApiOperation({
      summary: 'Media Comments API',
      description: 'Get comments of media',
    }),
    ApiQueryLimitAndPage(),
    ApiParam({ name: 'id', required: true, description: 'Media Id' }),
    ApiQuery({ name: 'replyTo', required: false }),
  );

export const decoratorsGetSavedMedias = () =>
  applyDecorators(
    UseGuards(JwtTokenVerifyGuard),
    ApiHeader({
      name: 'accessToken',
      description: 'Access Token',
      required: true,
    }),
    ApiQuery({
      name: 'id',
      description: 'Media ID',
      required: false,
    }),
  );

export const decoratorsGetSavedMediasByUserID = () =>
  applyDecorators(
    Roles([RolesLevel.MANAGER]),
    ApiParam({
      name: 'userId',
      description: 'User ID',
      required: true,
    }),
    ApiQuery({
      name: 'id',
      description: 'Media ID',
      required: false,
    }),
  );

export const decoratorsCreateComment = () =>
  applyDecorators(
    UseGuards(JwtTokenVerifyGuard),
    ApiOperation({
      summary: 'Create Comment API',
      description: 'Create comment of media',
    }),
    ApiHeader({
      name: 'accessToken',
      description: 'Access Token',
      required: true,
    }),
    ApiParam({ name: 'id', required: true, description: 'Media Id' }),
  );

export const decoratorsMediaUpload = () =>
  applyDecorators(
    UseGuards(JwtTokenVerifyGuard),
    ApiOperation({
      summary: 'Media Upload API',
      description: 'Upload media to server',
    }),
    ApiHeader({
      name: 'accessToken',
      description: 'Access Token',
      required: true,
    }),
    ApiConsumes('multipart/form-data'),
    ApiBody({ type: MediaUploadDto }),
    UseInterceptors(
      FilesInterceptor('files', 10, {
        storage: multer.memoryStorage(),
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

export const decoratorsUpdateMedia = () =>
  applyDecorators(
    UseGuards(JwtTokenVerifyGuard),
    ApiHeader({
      name: 'accessToken',
      description: 'Access Token',
      required: true,
    }),
    ApiOperation({ summary: 'Update Media API', description: 'Update media' }),
    ApiParam({ name: 'id', required: true, description: 'Media ID' }),
  );

export const decoratorsUpdateMediaAdmin = () =>
  applyDecorators(
    Roles([RolesLevel.ADMIN]),
    ApiOperation({
      summary: 'Update Media API (Admin Only)',
      description: 'Update media',
    }),
    ApiParam({ name: 'id', required: true, description: 'Media ID' }),
  );

export const decoratorsSaveMedia = () =>
  applyDecorators(
    UseGuards(JwtTokenVerifyGuard),
    ApiOperation({
      summary: 'Save Media API',
      description: 'Save media to your favorite',
    }),
    ApiHeader({
      name: 'accessToken',
      description: 'Access Token',
      required: true,
    }),
    ApiParam({ name: 'id', required: true, description: 'Media Id' }),
  );

export const decoratorsRemoveComment = () =>
  applyDecorators(
    UseGuards(JwtTokenVerifyGuard),
    ApiOperation({
      summary: 'Remove Comment API',
      description: 'Remove comment of media',
    }),
    ApiHeader({
      name: 'accessToken',
      description: 'Access Token',
      required: true,
    }),
    ApiParam({ name: 'id', required: true, description: 'Comment Id' }),
  );

export const decoratorsDeleteComment = () =>
  applyDecorators(
    Roles([RolesLevel.ADMIN]),
    ApiOperation({
      summary: 'Delete Comment API (Admin Only)',
      description: 'Delete comment of media',
    }),
    ApiParam({ name: 'id', required: true, description: 'Comment Id' }),
  );

export const decoratorsRemoveMedia = () =>
  applyDecorators(
    UseGuards(JwtTokenVerifyGuard),
    ApiOperation({
      summary: 'Remove Media API',
      description: 'Remove media',
    }),
    ApiHeader({
      name: 'accessToken',
      description: 'Access Token',
      required: true,
    }),
    ApiParam({ name: 'id', required: true, description: 'Media Id' }),
  );
