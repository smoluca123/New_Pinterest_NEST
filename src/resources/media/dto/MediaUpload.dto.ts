import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString } from 'class-validator';

// type MediaType = 'Group' | 'UnGroup';

export class MediaUploadDto {
  @ApiProperty({
    type: 'array',
    items: {
      type: 'file',
      format: 'binary',
    },
    description: 'Max size : 5MB per file, Only Accept Image File',
  })
  files: Array<Express.Multer.File>;

  @ApiProperty({ description: 'Image Title' })
  @IsString()
  @IsNotEmpty()
  name: string;

  @ApiProperty({
    description: 'Slug of Image  (Can be empty)',
    required: false,
  })
  @IsOptional()
  @IsString()
  slug?: string;

  @ApiProperty({
    description: 'Image Description',
  })
  @IsString()
  @IsNotEmpty()
  description: string;

  //   @ApiProperty({
  //     description: 'Image Type',
  //     required: false,
  //   })
  //   @IsIn(['Group', 'UnGroup'])
  //   type: MediaType;
}
