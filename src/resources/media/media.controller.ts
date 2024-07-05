import {
  Body,
  Controller,
  Get,
  MaxFileSizeValidator,
  Param,
  ParseFilePipe,
  Post,
  Query,
  Request,
  UploadedFiles,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { MediaService } from './media.service';
import {
  IRequestWithDecodedAccessToken,
  IResponseType,
} from 'src/interfaces/interfaces.global';
import { AuthGuard } from '@nestjs/passport';
import { RolesGuard } from 'src/guards/roles.guard';
import {
  ApiBearerAuth,
  ApiBody,
  ApiConsumes,
  ApiHeader,
  ApiOperation,
  ApiParam,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { MediaUploadDto } from './dto/MediaUpload.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { JwtTokenVerifyGuard } from 'src/guards/jwt-token-verify.guard';
import * as multer from 'multer';
import { FileIsImageValidationPipe } from 'src/pipes/ImageTypeValidator.pipe';
import { ApiQueryLimitAndPage } from 'src/decorators/global.decorators';

@Controller('media')
@ApiBearerAuth()
@ApiTags('Media Managements')
@UseGuards(AuthGuard('jwt'), RolesGuard)
export class MediaController {
  constructor(private readonly mediaService: MediaService) {}

  @Get('get-media-list')
  @ApiOperation({
    summary: 'Media List API',
    description: 'Get list of media',
  })
  @ApiQueryLimitAndPage()
  @ApiQuery({ name: 'keyword', required: false })
  getMediaList(
    @Query('limit') limit: string | number,
    @Query('page') page: string | number,
    @Query('keyword') keyword: string,
  ): Promise<IResponseType> {
    return this.mediaService.getMediaList(+limit, +page, keyword);
  }

  @Get('get-media-detail/:id')
  @ApiOperation({
    summary: 'Media Detail API',
    description: 'Get detail of media',
  })
  @ApiParam({ name: 'id', required: true })
  getMediaDetail(
    @Param('id') mediaId: number | string,
  ): Promise<IResponseType> {
    return this.mediaService.getMediaDetail(+mediaId);
  }

  @Post('upload')
  @UseGuards(JwtTokenVerifyGuard)
  @ApiOperation({
    summary: 'Media Upload API',
    description: 'Upload media to server',
  })
  @ApiHeader({
    name: 'accessToken',
    description: 'Access Token',
    required: true,
  })
  @ApiConsumes('multipart/form-data')
  @ApiBody({ type: MediaUploadDto })
  @UseInterceptors(
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
  )
  async mediaUpload(
    @UploadedFiles(
      FileIsImageValidationPipe,
      new ParseFilePipe({
        validators: [
          new MaxFileSizeValidator({
            maxSize: 1024 * 1024 * 50,
            message: 'File size is too large, max 50MB',
          }),
        ],
      }),
    )
    files: Array<Express.Multer.File>,
    @Request() request: IRequestWithDecodedAccessToken,
    @Body() mediaData: MediaUploadDto,
  ): Promise<IResponseType> {
    const { decodedAccessToken } = request;
    return this.mediaService.mediaUploadSupabase(
      files,
      decodedAccessToken,
      mediaData,
    );
  }
}
