import { Injectable, NotFoundException } from '@nestjs/common';
import {
  handleDefaultError,
  uploadFileStack,
} from 'src/global/functions.global';
import {
  IDecodedAccecssTokenType,
  IResponseType,
} from 'src/interfaces/interfaces.global';
import { MediaUploadDto } from './dto/MediaUpload.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import slugify from 'slugify';
import { SupabaseService } from 'src/supabase/supabase.service';

@Injectable()
export class MediaService {
  constructor(
    private prisma: PrismaService,
    private supabase: SupabaseService,
  ) {}

  async getMediaList(
    limit: number,
    page: number,
    keyword: string,
  ): Promise<IResponseType> {
    try {
      limit = limit ? +limit : 3;
      page = page ? +page : 1;

      const whereQuery = {
        AND: [
          {
            OR: [
              { name: { contains: keyword } },
              { description: { contains: keyword } },
            ],
          },
          {
            is_hidden: 0,
          },
        ],
      };

      const totalItems = await this.prisma.media.count({
        where: whereQuery,
      });

      const mediaList = await this.prisma.media.findMany({
        where: whereQuery,

        select: {
          id: true,
          name: true,
          slug: true,
          description: true,
          created_at: true,
          updated_at: true,
          type: true,
          user: {
            select: {
              id: true,
              username: true,
              full_name: true,
              age: true,
              avatar: true,
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

        take: limit,
        skip: (page - 1) * limit,
      });

      return {
        message: 'Media List',
        data: {
          currentPage: page,
          totalPage: Math.ceil(totalItems / limit),
          totalItems,
          items: mediaList,
        },
        statusCode: 200,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async getMediaDetail(mediaId: number): Promise<IResponseType> {
    try {
      if (!mediaId) throw new NotFoundException('Media ID is required');
      const media = await this.prisma.media.findUnique({
        where: {
          id: mediaId,
          is_hidden: 0,
        },
        include: {
          image: {
            select: {
              id: true,
              img_name: true,
              url: true,
              created_at: true,
            },
          },
          user: {
            select: {
              id: true,
              username: true,
              full_name: true,
              age: true,
              avatar: true,
              user_type: true,
              created_at: true,
              updated_at: true,
              is_ban: true,
            },
          },

          // comment: {
          //   select: {
          //     id: true,
          //     content: true,
          //     created_at: true,
          //     updated_at: true,
          //     user: {
          //       select: {
          //         id: true,
          //         username: true,
          //         full_name: true,
          //         age: true,
          //         avatar: true,
          //         user_type: true,
          //         created_at: true,
          //         updated_at: true,
          //         is_ban: true,
          //       },
          //     },
          //   },
          // },
        },
      });

      if (!media) throw new NotFoundException('Media not found');

      /* eslint-disable @typescript-eslint/no-unused-vars */
      const { creator_id, is_hidden, ...restMediaResult } = media;
      /* eslint-enable @typescript-eslint/no-unused-vars */

      return {
        message: 'Get Media Detail Success',
        data: { ...restMediaResult },
        statusCode: 200,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async mediaUploadFileStack(
    files: Array<Express.Multer.File>,
    decodedAccessToken: IDecodedAccecssTokenType,
    mediaData: MediaUploadDto,
  ): Promise<IResponseType> {
    try {
      const { id: userId, username } = decodedAccessToken;
      const mediaType = files.length > 1 ? 'Group' : 'Ungroup';

      const uploadResults = await uploadFileStack(files, {
        tags: { username },
      });

      // const uploadResults = await this.supabase.uploadFiles(files);

      // Add Media to Database
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
          user: {
            select: {
              id: true,
              username: true,
              full_name: true,
              age: true,
              avatar: true,
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
      const { creator_id, is_hidden, ...restMediaResult } = mediaResult;
      /* eslint-enable @typescript-eslint/no-unused-vars */

      return {
        message: 'Success',
        data: { ...restMediaResult },
        // data: {},
        statusCode: 201,
        date: new Date(),
      };
    } catch (error) {
      console.log(error);
      handleDefaultError(error);
    }
  }

  async mediaUploadSupabase(
    files: Array<Express.Multer.File>,
    decodedAccessToken: IDecodedAccecssTokenType,
    mediaData: MediaUploadDto,
  ): Promise<IResponseType> {
    try {
      const { id: userId } = decodedAccessToken;
      const mediaType = files.length > 1 ? 'Group' : 'Ungroup';

      const uploadResults = await this.supabase.uploadFiles(files);

      // Add Media to Database
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
          img_name: uploadResult.fileName,
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
          user: {
            select: {
              id: true,
              username: true,
              full_name: true,
              age: true,
              avatar: true,
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
      const { creator_id, is_hidden, ...restMediaResult } = mediaResult;
      /* eslint-enable @typescript-eslint/no-unused-vars */

      return {
        message: 'Media Upload Success',
        data: { ...restMediaResult },
        // data: {},
        statusCode: 201,
        date: new Date(),
      };
    } catch (error) {
      console.log(error);
      handleDefaultError(error);
    }
  }
}
