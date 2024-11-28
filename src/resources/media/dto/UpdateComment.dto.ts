import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';

export class UpdateCommentDto {
  @ApiProperty()
  @IsString()
  @IsOptional()
  content: string;
}

export class UpdateCommentAdminDto {
  @ApiProperty()
  @IsString()
  @IsOptional()
  content: string;
  @ApiProperty()
  @IsString()
  @IsOptional()
  replyTo: number;
}
