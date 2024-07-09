import { ApiProperty } from '@nestjs/swagger';
import { IsIn, IsOptional, IsString } from 'class-validator';

export class MediaUpdateDto {
  @ApiProperty({ description: 'Image Title', required: false })
  @IsString()
  @IsString()
  name?: string;

  @ApiProperty({
    description: 'Slug of Image  (Can be empty)',
    required: false,
  })
  @IsOptional()
  @IsString()
  slug?: string;

  @ApiProperty({
    description: 'Image Description',
    required: false,
  })
  @IsString()
  @IsOptional()
  description: string;
}

export class MediaUpdateAdminDto {
  @ApiProperty({ description: 'Image Title', required: false })
  @IsString()
  @IsOptional()
  name?: string;

  @ApiProperty({
    description: 'Slug of Image  (Can be empty)',
    required: false,
  })
  @IsOptional()
  @IsString()
  slug?: string;

  @ApiProperty({
    description: 'Image Description',
    required: false,
  })
  @IsString()
  @IsOptional()
  description: string;
  @ApiProperty({
    description: 'Image Description',
    required: false,
  })
  @IsIn([0, 1], { message: 'isHidden must be 0 or 1' })
  @IsOptional()
  isHidden: number;
}
