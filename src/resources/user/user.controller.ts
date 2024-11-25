import {
  Body,
  Controller,
  Delete,
  Get,
  Headers,
  MaxFileSizeValidator,
  Param,
  ParseFilePipe,
  Post,
  Put,
  Query,
  Req,
  Request,
  UploadedFile,
  UseGuards,
} from '@nestjs/common';
import { UserService } from './user.service';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import {
  UserBanDto,
  UserInfoUpdateDto,
  UserUpdateDto,
} from './dto/UserUpdate.dto';
import {
  IRequestWithDecodedAccessToken,
  IResponseType,
} from 'src/interfaces/interfaces.global';
import { RolesGuard } from 'src/guards/roles.guard';
import {
  decoratorsBanUser,
  decoratorsDeleteUser,
  decoratorsInfomation,
  decoratorsInfomationByID,
  decoratorsListUsers,
  decoratorsRefreshToken,
  decoratorsUpdateInfo,
  decoratorsUpdateInfoByID,
  decoratorsUpdateUserAvatar,
} from './user.decorators';
import { FileIsImageValidationPipe } from 'src/pipes/ImageTypeValidator.pipe';

@ApiTags('User Managements')
@ApiBearerAuth()
@UseGuards(RolesGuard)
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Get('/list-users')
  @decoratorsListUsers()
  getListUsers(
    @Query('limit') limit: string | number,
    @Query('page') page: string | number,
    @Query('keyword') keyword: string,
    @Query('type') type: string,
  ): Promise<IResponseType> {
    return this.userService.getListUsers(+limit, +page, keyword, type);
  }

  @Get('/infomation')
  @decoratorsInfomation()
  getInfomation(
    @Request() request: IRequestWithDecodedAccessToken,
  ): Promise<IResponseType> {
    const { decodedAccessToken } = request;
    return this.userService.getInfomation(decodedAccessToken);
  }

  @Get('/infomation/:id')
  @decoratorsInfomationByID()
  getInfomationByID(
    @Param('id') userId: string | number,
  ): Promise<IResponseType> {
    return this.userService.getInfomationByID(+userId);
  }

  @Get('/refresh-token')
  @decoratorsRefreshToken()
  getRefreshToken(
    @Headers('accessToken') accessToken: string,
  ): Promise<IResponseType> {
    return this.userService.refreshToken(accessToken);
  }

  @Post('/ban-user/:id')
  @decoratorsBanUser()
  postBanUser(
    @Param('id') userId: string | number,
    @Body() data: UserBanDto,
  ): Promise<IResponseType> {
    return this.userService.banUser(+userId, data);
  }

  @Put('/update-info')
  @decoratorsUpdateInfo()
  putUpdateInfo(
    @Req() request: IRequestWithDecodedAccessToken,
    @Body() userInfo: UserInfoUpdateDto,
  ): Promise<IResponseType> {
    const { decodedAccessToken } = request;
    return this.userService.updateInfo(decodedAccessToken, userInfo);
  }

  @Put('/update-info/:id')
  @decoratorsUpdateInfoByID()
  putUpdateUser(
    @Param('id') userId: string,
    @Body() userInfo: UserUpdateDto,
  ): Promise<IResponseType> {
    return this.userService.updateUser(+userId, userInfo);
  }

  @Post('/update-user-avatar/:id')
  @decoratorsUpdateUserAvatar()
  postUpdateUserAvatar(
    @Param('id') userId: string | number,
    @UploadedFile(
      FileIsImageValidationPipe,
      new ParseFilePipe({
        validators: [
          new MaxFileSizeValidator({
            maxSize: 1024 * 1024 * 50,
            message: 'File size is too large, max 50MB',
          }),
        ],
      }),
    )
    file: Express.Multer.File,
  ): Promise<IResponseType> {
    return this.userService.updateUserAvatar({ userId, file });
  }

  @Delete('/delete-user/:id')
  @decoratorsDeleteUser()
  deleteUser(@Param('id') userId: string | number): Promise<IResponseType> {
    return this.userService.deleteUser(+userId);
  }
}
