import {
  Body,
  Controller,
  Post,
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
  ApiTags,
} from '@nestjs/swagger';
import { MediaUploadDto } from './dto/MediaUpload.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { JwtTokenVerifyGuard } from 'src/guards/jwt-token-verify.guard';

@Controller('media')
@ApiBearerAuth()
@ApiTags('Media Managements')
@UseGuards(AuthGuard('jwt'), RolesGuard)
export class MediaController {
  constructor(private readonly mediaService: MediaService) {}

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
  @UseInterceptors(FilesInterceptor('files', 10))
  async mediaUpload(
    @UploadedFiles() files: Array<Express.Multer.File>,
    @Request() request: IRequestWithDecodedAccessToken,
    @Body() mediaData: MediaUploadDto,
  ): Promise<IResponseType> {
    const { decodedAccessToken } = request;
    return this.mediaService.mediaUpload(files, decodedAccessToken, mediaData);
  }
}
