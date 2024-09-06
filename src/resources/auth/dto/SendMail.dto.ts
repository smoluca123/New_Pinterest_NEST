import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber } from 'class-validator';

export class SendActivationMailDto {
  @ApiProperty()
  @IsNumber()
  @IsNotEmpty()
  userId: number;
  // @ApiProperty({ default: 'example.com' })
  // @IsString()
  // @IsNotEmpty()
  // domain: string;
}
