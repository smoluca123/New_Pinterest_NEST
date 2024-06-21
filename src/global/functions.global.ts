import { BadRequestException } from '@nestjs/common';

export const handleDefaultError = (error: any) => {
  if (error.statusCode || error.message) throw error;
  throw new BadRequestException('Unknown error!');
};
