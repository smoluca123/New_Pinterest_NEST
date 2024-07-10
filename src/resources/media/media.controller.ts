import {
  Body,
  Controller,
  Delete,
  Get,
  MaxFileSizeValidator,
  Param,
  ParseFilePipe,
  Post,
  Put,
  Query,
  Req,
  Request,
  UploadedFiles,
  UseGuards,
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
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { MediaUploadDto } from './dto/MediaUpload.dto';
import { FileIsImageValidationPipe } from 'src/pipes/ImageTypeValidator.pipe';
import { CreateCommentDto } from './dto/CreateComment.dto';
import {
  decoratorsCreateComment,
  decoratorsDeleteComment,
  decoratorsGetComments,
  decoratorsGetMediaList,
  decoratorsGetSavedMedias,
  decoratorsMediaUpload,
  decoratorsRemoveComment,
  decoratorsSaveMedia,
  decoratorsUpdateMedia,
  decoratorsUpdateMediaAdmin,
} from './media.decorators';
import { MediaUpdateAdminDto, MediaUpdateDto } from './dto/MediaUpdate.dto';

@Controller('media')
@ApiBearerAuth()
@ApiTags('Media Managements')
@UseGuards(AuthGuard('jwt'), RolesGuard)
export class MediaController {
  constructor(private readonly mediaService: MediaService) {}

  @Get('get-media-list')
  @decoratorsGetMediaList()
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

  @Get('get-comments/:id')
  @decoratorsGetComments()
  getMediaComments(
    @Query('limit') limit: string | number,
    @Query('page') page: string | number,
    @Param('id') mediaId: number | string,
    @Query('replyTo') replyTo: string | number,
  ): Promise<IResponseType> {
    return this.mediaService.getComments(+limit, +page, +mediaId, +replyTo);
  }

  @Get('get-saved-medias')
  @decoratorsGetSavedMedias()
  getSavedMedias(
    @Request() req: IRequestWithDecodedAccessToken,
    @Query('id') mediaId: number | string,
  ): Promise<IResponseType> {
    const { decodedAccessToken } = req;
    return this.mediaService.getSavedMedias(decodedAccessToken, +mediaId);
  }

  @Post('create-comment/:id')
  @decoratorsCreateComment()
  createComment(
    @Request() req: IRequestWithDecodedAccessToken,
    @Param('id') mediaId: number | string,
    @Body() commentData: CreateCommentDto,
  ): Promise<IResponseType> {
    const { decodedAccessToken } = req;
    return this.mediaService.createComment(
      decodedAccessToken,
      +mediaId,
      commentData,
    );
  }

  @Post('upload')
  @decoratorsMediaUpload()
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

  @Post('save-media/:id')
  @decoratorsSaveMedia()
  saveMedia(
    @Req() request: IRequestWithDecodedAccessToken,
    @Param('id') mediaId: number | string,
  ): Promise<IResponseType> {
    const { decodedAccessToken } = request;
    return this.mediaService.saveMedia(decodedAccessToken, +mediaId);
  }

  @Put('update-media/:id')
  @decoratorsUpdateMedia()
  updateMedia(
    @Req() request: IRequestWithDecodedAccessToken,
    @Param('id') mediaId: number | string,
    @Body() mediaData: MediaUpdateDto,
  ): Promise<IResponseType> {
    const { decodedAccessToken } = request;
    return this.mediaService.updateMedia(
      decodedAccessToken,
      +mediaId,
      mediaData,
    );
  }
  @Put('update-media-admin/:id')
  @decoratorsUpdateMediaAdmin()
  updateMediaAdmin(
    @Param('id') mediaId: number | string,
    @Body() mediaData: MediaUpdateAdminDto,
  ): Promise<IResponseType> {
    return this.mediaService.updateMediaAdmin(+mediaId, mediaData);
  }

  @Delete('remove-comment/:id')
  @decoratorsRemoveComment()
  removeComment(
    @Req() request: IRequestWithDecodedAccessToken,
    @Param('id') commentId: number | string,
  ): Promise<IResponseType> {
    const { decodedAccessToken } = request;
    return this.mediaService.removeComment(decodedAccessToken, +commentId);
  }

  @Delete('delete-comment/:id')
  @decoratorsDeleteComment()
  deleteComment(
    @Req() request: IRequestWithDecodedAccessToken,
    @Param('id') commentId: number | string,
  ): Promise<IResponseType> {
    return this.mediaService.deleteComment(+commentId);
  }
}
