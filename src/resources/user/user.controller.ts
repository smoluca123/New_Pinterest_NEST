import {
  Body,
  Controller,
  Get,
  Headers,
  Param,
  Put,
  Query,
  Req,
  Request,
  UseGuards,
} from '@nestjs/common';
import { UserService } from './user.service';
import { JwtTokenVerifyGuard } from 'src/guards/jwt-token-verify.guard';
import {
  ApiBearerAuth,
  ApiHeader,
  ApiOperation,
  ApiParam,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { UserInfoUpdateDto, UserUpdateDto } from './dto/UserUpdate.dto';
import {
  IRequestWithDecodedAccessToken,
  IResponseType,
  RolesLevel,
} from 'src/interfaces/interfaces.global';
import { AuthGuard } from '@nestjs/passport';
import { ApiQueryLimitAndPage } from 'src/decorators/global.decorators';
import { RolesGuard } from 'src/guards/roles.guard';
import { Roles } from 'src/decorators/roles.decorator';

@ApiTags('User Managements')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Get('/list-users')
  @ApiOperation({
    summary: 'User List API',
    description: 'Get list of users',
  })
  @ApiQueryLimitAndPage()
  @ApiQuery({
    name: 'keyword',
    description: 'Search by keyword',
    required: false,
  })
  @ApiQuery({
    name: 'type',
    description: 'Search by type',
    required: false,
  })
  getListUsers(
    @Query('limit') limit: string | number,
    @Query('page') page: string | number,
    @Query('keyword') keyword: string,
    @Query('type') type: string,
  ): Promise<IResponseType> {
    return this.userService.getListUsers(+limit, +page, keyword, type);
  }

  @Get('/infomation')
  @UseGuards(JwtTokenVerifyGuard)
  @ApiHeader({
    name: 'accessToken',
    description: 'Access Token',
    required: true,
  })
  @ApiOperation({
    summary: 'User Infomation API',
    description: 'Get current user infomation',
  })
  getInfomation(
    @Request() request: IRequestWithDecodedAccessToken,
  ): Promise<IResponseType> {
    const { decodedAccessToken } = request;
    return this.userService.getInfomation(decodedAccessToken);
  }

  @Get('/refresh-token')
  @ApiHeader({
    name: 'accessToken',
    description: 'Access Token',
    required: true,
  })
  @ApiOperation({
    summary: 'User Refresh Token API',
    description: "Refresh the current user's access token",
  })
  getRefreshToken(
    @Headers('accessToken') accessToken: string,
  ): Promise<IResponseType> {
    return this.userService.refreshToken(accessToken);
  }

  @Put('/update-info')
  @UseGuards(JwtTokenVerifyGuard)
  @ApiOperation({
    summary: 'User Update Info API',
    description:
      "Updates the current user's account information. Fields that are not to be updated should be left blank.",
  })
  @ApiHeader({
    name: 'accessToken',
    description: 'Access Token',
    required: true,
  })
  putUpdateInfo(
    @Req() request: IRequestWithDecodedAccessToken,
    @Body() userInfo: UserInfoUpdateDto,
  ): Promise<IResponseType> {
    const { decodedAccessToken } = request;
    return this.userService.updateInfo(decodedAccessToken, userInfo);
  }

  @Put('/update-user/:id')
  @Roles([RolesLevel.ADMIN])
  @ApiOperation({
    summary: 'User Update API (Admin Only)',
    description:
      'Updates user account information. Fields that are not to be updated should be left blank.',
  })
  @ApiParam({
    name: 'id',
    description: 'User ID',
  })
  putUpdateUser(
    @Param('id') userId: string,
    @Body() userInfo: UserUpdateDto,
  ): Promise<IResponseType> {
    return this.userService.updateUser(+userId, userInfo);
  }
}
