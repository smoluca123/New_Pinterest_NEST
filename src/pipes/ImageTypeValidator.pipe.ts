import { PipeTransform, Injectable, BadRequestException } from '@nestjs/common';
import { FileTypeValidator } from '@nestjs/common';

@Injectable()
export class FileIsImageValidationPipe implements PipeTransform {
  transform(files: Express.Multer.File[]) {
    const fileTypeValidator = new FileTypeValidator({ fileType: 'image/*' });
    const isValidImgs = files
      .map((file) => fileTypeValidator.isValid(file))
      .find((v) => !v);
    if (isValidImgs) {
      throw new BadRequestException('Only image files are allowed');
    }

    return files;
  }
}
