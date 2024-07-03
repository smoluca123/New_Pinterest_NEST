import { Injectable } from '@nestjs/common';
import { handleDefaultError } from 'src/global/functions.global';
import {
  IDecodedAccecssTokenType,
  IResponseType,
} from 'src/interfaces/interfaces.global';
import { MediaUploadDto } from './dto/MediaUpload.dto';
import * as filestack from 'filestack-js';
import { File } from 'filestack-js/build/main/lib/api/upload';
import { PrismaService } from 'src/prisma/prisma.service';
import slugify from 'slugify';

@Injectable()
export class MediaService {
  constructor(private prisma: PrismaService) {}

  async mediaUpload(
    files: Array<Express.Multer.File>,
    decodedAccessToken: IDecodedAccecssTokenType,
    mediaData: MediaUploadDto,
  ): Promise<IResponseType> {
    try {
      const { id: userId, username } = decodedAccessToken;
      const mediaType = files.length > 1 ? 'Group' : 'Ungroup';

      const client = filestack.init(process.env.FILESTACK_API_KEY);
      const uploadPromises = files.map<Promise<File>>((file) => {
        return client.upload(
          file.buffer,
          {
            onProgress: (progress) => {
              console.log(progress);
            },
            tags: {
              username: username,
            },
          },
          { filename: file.originalname, path: 'pinterest_v2/medias' },
        );
      });
      const uploadResults = await Promise.all(uploadPromises);

      //   Add Media to Database
      const createdMedia = await this.prisma.media.create({
        data: {
          name: mediaData.name,
          slug:
            mediaData.slug ||
            slugify(mediaData.name + '-' + new Date().getTime()),
          description: mediaData.description,
          type: mediaType,
          creator_id: +userId,
          created_at: new Date(),
          updated_at: new Date(),
        },
      });
      const imagesData = uploadResults.map((uploadResult) => {
        return {
          url: uploadResult.url,
          img_name: uploadResult.filename,
          media_id: createdMedia.id,
          created_at: new Date(),
        };
      });

      //   Add Images to Database
      await this.prisma.image.createMany({
        data: [...imagesData],
        skipDuplicates: true,
      });

      const mediaResult = await this.prisma.media.findUnique({
        where: {
          id: createdMedia.id,
        },
        include: {
          users: {
            select: {
              id: true,
              username: true,
              full_name: true,
              age: true,
              user_type: true,
              created_at: true,
              updated_at: true,
              is_ban: true,
            },
          },
          image: {
            select: {
              id: true,
              img_name: true,
              url: true,
              created_at: true,
            },
          },
        },
      });

      /* eslint-disable @typescript-eslint/no-unused-vars */
      const {
        creator_id,
        users: creator,
        is_hidden,
        ...restMediaResult
      } = mediaResult;
      /* eslint-enable @typescript-eslint/no-unused-vars */

      return {
        message: 'Success',
        data: { ...restMediaResult, creator },
        statusCode: 201,
        date: new Date(),
      };
    } catch (error) {
      console.log(error);
      handleDefaultError(error);
    }
  }
}
