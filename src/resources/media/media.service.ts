import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
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
import { CreateCommentDto } from './dto/CreateComment.dto';
import { DEFAULT_LIMIT } from 'src/global/constant.global';
import { MediaUpdateAdminDto, MediaUpdateDto } from './dto/MediaUpdate.dto';
import { CommentsGateway } from './gateways/comments.gateway';
import {
  imageDataSelect,
  mediaDataSelect,
  saveMediaDataSelect,
  userDataSelect,
} from 'src/interfaces/prisma-types';
import { Prisma } from '@prisma/client';
import {
  UpdateCommentAdminDto,
  UpdateCommentDto,
} from 'src/resources/media/dto/UpdateComment.dto';

@Injectable()
export class MediaService {
  constructor(
    private prisma: PrismaService,
    private supabase: SupabaseService,
    private readonly commentsGateway: CommentsGateway,
  ) {}

  async getMediaList(
    limit: number,
    page: number,
    keyword: string,
  ): Promise<IResponseType> {
    try {
      limit = limit ? +limit : DEFAULT_LIMIT;
      page = page ? +page : 1;

      const whereQuery: Prisma.mediaWhereInput = {
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

        select: mediaDataSelect,

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

  async getMediaUploadedByUserID(
    userId: number,
    limit: number,
    page: number,
    keyword: string,
  ): Promise<IResponseType> {
    try {
      if (!userId) throw new BadRequestException('User ID is required');
      limit = limit ? +limit : DEFAULT_LIMIT;
      page = page ? +page : 1;

      const whereQuery: Prisma.mediaWhereInput = {
        AND: [
          {
            OR: [
              { name: { contains: keyword } },
              { description: { contains: keyword } },
            ],
          },
          {
            creator_id: userId,
            is_hidden: 0,
          },
        ],
      };

      const totalItems = await this.prisma.media.count({
        where: whereQuery,
      });

      const mediaList = await this.prisma.media.findMany({
        where: whereQuery,

        select: mediaDataSelect,

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
        // include: {
        //   image: {
        //     select: {
        //       id: true,
        //       img_name: true,
        //       url: true,
        //       created_at: true,
        //     },
        //   },
        //   user: {
        //     select: {
        //       id: true,
        //       username: true,
        //       full_name: true,
        //       age: true,
        //       avatar: true,
        //       user_type: true,
        //       created_at: true,
        //       updated_at: true,
        //       is_ban: true,
        //     },
        //   },
        // },

        select: mediaDataSelect,
      });

      if (!media) throw new NotFoundException('Media not found');

      return {
        message: 'Get Media Detail Success',
        data: { ...media },
        statusCode: 200,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async getComments(
    limit: number,
    page: number,
    mediaId: number,
    replyTo: number,
  ): Promise<IResponseType> {
    try {
      if (!mediaId) throw new NotFoundException('Media ID is required');

      limit = limit ? +limit : DEFAULT_LIMIT;
      page = page ? +page : 1;

      const whereQuery: Prisma.commentWhereInput = {
        media_id: mediaId,
        AND: [
          {
            OR: [
              {
                reply_to: replyTo || null,
              },
            ],
          },
        ],
      };

      const comments = await this.prisma.comment.findMany({
        where: whereQuery,
        include: {
          user: {
            select: userDataSelect,
          },
        },
        take: limit,
        skip: (page - 1) * limit,
        orderBy: {
          created_at: 'asc',
        },
      });

      const totalItems = await this.prisma.comment.count({
        where: whereQuery,
      });

      return {
        message: 'Get Comments Success',
        data: {
          currentPage: page,
          totalPage: Math.ceil(totalItems / limit),
          totalItems,
          items: comments,
        },
        statusCode: 200,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async getSavedMedias(
    decodedAccessToken: IDecodedAccecssTokenType,
    idMedia: number,
    limit: number,
    page: number,
  ): Promise<IResponseType> {
    try {
      limit = limit ? +limit : DEFAULT_LIMIT;
      page = page ? +page : 1;

      const { id } = decodedAccessToken;

      const whereQuery: Prisma.save_mediaWhereInput = {
        user_id: +id,
        AND: [
          {
            media: {
              is_hidden: 0,
            },
            OR: [
              {
                media_id: idMedia || undefined,
              },
            ],
          },
        ],
      };

      const totalItems = await this.prisma.save_media.count({
        where: whereQuery,
      });

      const savedMedias = await this.prisma.save_media.findMany({
        where: whereQuery,
        select: saveMediaDataSelect,
        take: limit,
        skip: (page - 1) * limit,
      });

      return {
        message: 'Get Saved Medias Success',
        data: {
          currentPage: page,
          totalPage: Math.ceil(totalItems / limit),
          totalItems,
          items: savedMedias,
        },
        statusCode: 200,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async getSavedMediasByUserID(
    userId: number,
    idMedia: number,
    limit: number,
    page: number,
  ): Promise<IResponseType> {
    try {
      limit = limit ? +limit : DEFAULT_LIMIT;
      page = page ? +page : 1;

      const whereQuery: Prisma.save_mediaWhereInput = {
        user_id: userId,
        AND: [
          {
            media: {
              is_hidden: 0,
            },
            OR: [
              {
                media_id: idMedia || undefined,
              },
            ],
          },
        ],
      };

      const totalItems = await this.prisma.save_media.count({
        where: whereQuery,
      });

      const savedMedias = await this.prisma.save_media.findMany({
        where: whereQuery,
        select: saveMediaDataSelect,
        take: limit,
        skip: (page - 1) * limit,
      });

      return {
        message: 'Get Saved Medias Success',
        data: {
          currentPage: page,
          totalPage: Math.ceil(totalItems / limit),
          totalItems,
          items: savedMedias,
        },
        statusCode: 200,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async createComment(
    decodedAccessToken: IDecodedAccecssTokenType,
    mediaId: number,
    commentData: CreateCommentDto,
  ): Promise<IResponseType> {
    try {
      const MAX_LEVEL_COMMENT = 1;
      if (!mediaId) throw new NotFoundException('Media ID is required');

      const { id: userId } = decodedAccessToken;
      const { content, replyToCommentId } = commentData;

      let commentCreateData = {};
      if (replyToCommentId) {
        const replyComment = await this.prisma.comment.findUnique({
          where: {
            id: replyToCommentId,
            media_id: mediaId,
          },
        });
        if (!replyComment)
          throw new NotFoundException('Reply Comment not found');

        await this.prisma.comment.update({
          where: {
            id: replyComment.id,
          },
          data: {
            replies: {
              increment: 1,
            },
          },
        });

        commentCreateData = {
          content,
          user_id: +userId,
          media_id: mediaId,
          level:
            replyComment.level < MAX_LEVEL_COMMENT
              ? replyComment.level + 1
              : MAX_LEVEL_COMMENT, //Max level : 1
          created_at: new Date(),
          updated_at: new Date(),
          reply_to: replyToCommentId,
        };
      } else {
        commentCreateData = {
          content,
          user_id: +userId,
          media_id: mediaId,
          level: 0,
          created_at: new Date(),
          updated_at: new Date(),
        };
      }

      const comment = await this.prisma.comment.create({
        data: commentCreateData,
        include: {
          user: {
            select: userDataSelect,
          },
        },
      });

      this.commentsGateway.broadcastNewComment({
        comment,
        mediaId,
      });

      return {
        message: 'Create Comment Success',
        data: comment,
        statusCode: 201,
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
        select: mediaDataSelect,
      });

      return {
        message: 'Success',
        data: { ...mediaResult },
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
        select: mediaDataSelect,
      });

      return {
        message: 'Media Upload Success',
        data: { ...mediaResult },
        // data: {},
        statusCode: 201,
        date: new Date(),
      };
    } catch (error) {
      console.log(error);
      handleDefaultError(error);
    }
  }

  async saveMedia(
    decodedAccessToken: IDecodedAccecssTokenType,
    mediaId: number,
  ): Promise<IResponseType> {
    try {
      if (!mediaId) throw new BadRequestException('Media ID is required');

      const { id } = decodedAccessToken;

      const media = await this.prisma.media.findUnique({
        where: {
          id: mediaId,
          is_hidden: 0,
        },
      });

      if (!media) throw new NotFoundException('Media not found');

      const checkSavedMedia = await this.prisma.save_media.findFirst({
        where: {
          user_id: +id,
          media_id: mediaId,
        },
      });

      if (checkSavedMedia) {
        await this.prisma.save_media.delete({
          where: {
            id: checkSavedMedia.id,
          },
        });

        return {
          message: 'Unsave Media Success',
          data: null,
          statusCode: 204,
          date: new Date(),
        };
      }

      const createdSave = await this.prisma.save_media.create({
        data: {
          media_id: mediaId,
          user_id: +id,
          created_at: new Date(),
        },
        select: saveMediaDataSelect,
      });

      return {
        message: 'Save Media Success',
        data: createdSave,
        statusCode: 201,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async updateMedia(
    decodedAccessToken: IDecodedAccecssTokenType,
    mediaId: number,
    updatedMediaData: MediaUpdateDto,
  ): Promise<IResponseType> {
    try {
      if (!mediaId) throw new NotFoundException('Media ID is required');

      const { id } = decodedAccessToken;
      const { slug, description, name } = updatedMediaData;

      const media = await this.prisma.media.findUnique({
        where: {
          id: mediaId,
          is_hidden: 0,
        },
      });

      if (!media) throw new NotFoundException('Media not found');

      if (media.creator_id !== +id)
        throw new ForbiddenException('You cannot update this media');

      const updatedMedia = await this.prisma.media.update({
        where: {
          id: mediaId,
        },
        data: {
          name: name || undefined,
          slug: slug || undefined,
          description: description || undefined,
          updated_at: new Date(),
        },
        select: mediaDataSelect,
      });
      return {
        message: 'Media Update Success',
        data: updatedMedia,
        statusCode: 200,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async updateMediaAdmin(
    mediaId: number,
    updatedMediaData: MediaUpdateAdminDto,
  ): Promise<IResponseType> {
    try {
      if (!mediaId) throw new NotFoundException('Media ID is required');
      const { slug, description, name, isHidden } = updatedMediaData;

      const media = await this.prisma.media.findUnique({
        where: {
          id: mediaId,
        },
      });

      if (!media) throw new NotFoundException('Media not found');

      const updatedMedia = await this.prisma.media.update({
        where: {
          id: mediaId,
        },
        data: {
          name: name || undefined,
          slug: slug || undefined,
          description: description || undefined,
          is_hidden: isHidden ?? undefined,
          updated_at: new Date(),
        },
        include: {
          user: {
            select: userDataSelect,
          },
          image: {
            select: imageDataSelect,
          },
        },
      });
      return {
        message: 'Media Update Success',
        data: updatedMedia,
        statusCode: 200,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async updateComment({
    userId,
    commentId,
    commentData,
  }: {
    userId: number;
    commentId: number;
    commentData: UpdateCommentDto;
  }): Promise<IResponseType> {
    try {
      const { content } = commentData;

      const checkComment = await this.prisma.comment.findUnique({
        where: {
          id: commentId,
        },
      });

      if (!checkComment) throw new NotFoundException('Comment not found');
      if (checkComment.user_id !== userId) {
        throw new ForbiddenException('You cannot update this comment');
      }

      const updatedComment = await this.prisma.comment.update({
        where: {
          id: commentId,
        },
        data: {
          content: content || undefined,
          updated_at: new Date(),
        },
        include: {
          user: {
            select: userDataSelect,
          },
        },
      });
      return {
        message: 'Comment Update Success',
        data: updatedComment,
        statusCode: 200,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async updateCommentAdmin({
    commentId,
    commentData,
  }: {
    commentId: number;
    commentData: UpdateCommentAdminDto;
  }): Promise<IResponseType> {
    try {
      const { content, replyTo } = commentData;

      const checkComment = await this.prisma.comment.findUnique({
        where: {
          id: commentId,
        },
      });

      if (!checkComment) throw new NotFoundException('Comment not found');

      const updatedComment = await this.prisma.comment.update({
        where: {
          id: commentId,
        },
        data: {
          content: content || undefined,
          reply_to: replyTo || undefined,
          updated_at: new Date(),
        },
        include: {
          user: {
            select: userDataSelect,
          },
        },
      });
      return {
        message: 'Comment Update Success',
        data: updatedComment,
        statusCode: 200,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async removeComment(
    decodedAccessToken: IDecodedAccecssTokenType,
    commentId: number,
  ): Promise<IResponseType> {
    if (!commentId) throw new NotFoundException('Comment ID is required');

    const { id } = decodedAccessToken;

    const comment = await this.prisma.comment.findUnique({
      where: {
        id: commentId,
      },
    });

    if (!comment) throw new NotFoundException('Comment not found');
    if (comment.user_id !== +id)
      throw new ForbiddenException('You cannot remove this comment');

    if (comment.reply_to) {
      await this.prisma.comment.update({
        where: {
          id: comment.reply_to,
        },
        data: {
          replies: {
            decrement: 1,
          },
        },
      });
    }

    await this.prisma.comment.delete({
      where: {
        id: commentId,
        user_id: +id,
      },
    });

    try {
      return {
        message: 'Remove Comment Success',
        data: null,
        statusCode: 204,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async deleteComment(commentId: number): Promise<IResponseType> {
    try {
      if (!commentId) throw new NotFoundException('Comment ID is required');

      const comment = await this.prisma.comment.findUnique({
        where: {
          id: commentId,
        },
      });

      if (!comment) throw new NotFoundException('Comment not found');

      if (comment.reply_to) {
        await this.prisma.comment.update({
          where: {
            id: comment.reply_to,
          },
          data: {
            replies: {
              decrement: 1,
            },
          },
        });
      }

      await this.prisma.comment.delete({
        where: {
          id: commentId,
        },
      });

      return {
        message: 'Delete Comment Success',
        data: null,
        statusCode: 204,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }

  async removeMedia(
    decodedAccessToken: IDecodedAccecssTokenType,
    mediaId: number,
  ): Promise<IResponseType> {
    try {
      // Implement logic to remove media

      if (!mediaId) throw new NotFoundException('Media ID is required');

      const { id } = decodedAccessToken;

      const media = await this.prisma.media.findUnique({
        where: {
          id: mediaId,
        },
      });

      if (!media) throw new NotFoundException('Media not found');
      if (media.creator_id !== +id)
        throw new ForbiddenException('You cannot remove this media');

      await this.prisma.media.update({
        where: {
          id: mediaId,
        },
        data: {
          is_hidden: 1,
          name: media.name + new Date().getTime(),
          slug: media.slug + new Date().getTime(),
          updated_at: new Date(),
        },
      });

      return {
        message: 'Remove Media Success',
        data: null,
        statusCode: 204,
        date: new Date(),
      };
    } catch (error) {
      handleDefaultError(error);
    }
  }
}
