import { BadRequestException } from '@nestjs/common';
import * as filestack from 'filestack-js';
import { FSProgressEvent, File } from 'filestack-js/build/main/lib/api/upload';

export const handleDefaultError = (error: any) => {
  if ((error.statusCode && error.message) || error.response) throw error;
  // if (error.message) throw new BadRequestException(error.message);
  throw new BadRequestException(error.message || 'Unknown error!');
};

export const uploadFileStack = async (
  files: Array<Express.Multer.File>,
  options: {
    tags: filestack.UploadTags;
  },
  cb?: (progress: FSProgressEvent) => void,
): Promise<Array<File>> => {
  try {
    const client = filestack.init(process.env.FILESTACK_API_KEY);
    const uploadPromises = files.map<Promise<File>>((file) => {
      return client.upload(
        file.buffer,
        {
          onProgress: cb,
          tags: options.tags,
        },
        { filename: file.originalname, path: 'pinterest_v2/medias' },
      );
    });
    return await Promise.all(uploadPromises);
  } catch (error) {
    throw new BadRequestException(error.message || 'Unknown error!');
  }
};

export function sanitizeFileName(fileName) {
  // Loại bỏ các ký tự không hợp lệ: chỉ giữ lại chữ cái, số, dấu gạch ngang và dấu gạch dưới
  return fileName.replace(/[^a-zA-Z0-9-_\.]/g, '').replace(/[\s]/g, '_'); // Thay thế các khoảng trắng (space) bằng dấu gạch dưới (_)
}
