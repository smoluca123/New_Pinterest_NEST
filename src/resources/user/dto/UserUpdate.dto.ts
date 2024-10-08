import { ApiProperty } from '@nestjs/swagger';
import { IsIn, IsNumber, IsString } from 'class-validator';

export class UserInfoUpdateDto {
  @ApiProperty({ required: false })
  @IsString()
  username?: string;
  @ApiProperty({ required: false })
  @IsString()
  password?: string;
  @ApiProperty({ required: false })
  @IsString()
  email?: string;
  @ApiProperty({ required: false })
  @IsString()
  fullName?: string;
  @ApiProperty({ required: false })
  @IsNumber()
  age?: number;
}

export class UserUpdateDto {
  @ApiProperty({ required: false })
  @IsString()
  username?: string;
  @ApiProperty({ required: false })
  @IsString()
  password?: string;
  @ApiProperty({ required: false })
  @IsString()
  email?: string;
  @ApiProperty({ required: false })
  @IsString()
  fullName?: string;
  @ApiProperty({ required: false })
  @IsNumber()
  age?: number;
  @ApiProperty({ required: false })
  @IsNumber()
  type?: number;
  @ApiProperty({ required: false })
  @IsIn([0, 1], {
    message: 'Value must be 0 (actived) or 1 (banned)',
  })
  is_ban?: 0 | 1;
}

export class UserBanDto {
  @ApiProperty({ description: '0: Active, 1: Banned' })
  @IsIn([0, 1])
  is_ban: 0 | 1;
}

export class UserAvatarUpdateDto {
  @ApiProperty({
    type: 'file',
    description: 'Max size : 5MB per file, Only Accept Image File',
  })
  file: Express.Multer.File;
}
