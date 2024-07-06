import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsOptional, IsString } from 'class-validator';

export class CreateCommentDto {
  @ApiProperty({ description: 'Comment content' })
  @IsString()
  @IsNotEmpty()
  content: string;
  @ApiProperty({ description: 'Reply to comment id', required: false })
  @IsNumber()
  @IsOptional()
  replyToCommentId?: number;
}
