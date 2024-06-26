import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class UserLoginDto {
  @ApiProperty({ default: 'usertest1' })
  @IsString()
  @IsNotEmpty()
  username: string;
  @ApiProperty({ default: '123123' })
  @IsString()
  @IsNotEmpty()
  password: string;
}
