import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { IResponseType } from 'src/interfaces/interfaces.global';
import { UserLoginDto } from './dto/UserLogin.dto';
import { UserRegisterDto } from './dto/UserRegister.dto';

@Controller('auth')
@ApiTags('User Managements')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'))
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('/login')
  @ApiOperation({
    summary: 'User Login API',
    description: 'Username or email and password to login',
  })
  login(@Body() credentials: UserLoginDto): Promise<IResponseType> {
    return this.authService.login(credentials);
  }

  @Post('/register')
  @ApiOperation({
    summary: 'User Register API',
    description: 'Username or email and password to login',
  })
  register(@Body() credentials: UserRegisterDto): Promise<IResponseType> {
    return this.authService.register(credentials);
  }
}
