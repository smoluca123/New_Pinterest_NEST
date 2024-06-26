import {
  Injectable,
  CanActivate,
  ExecutionContext,
  UnauthorizedException,
  ForbiddenException,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { PrismaService } from 'src/prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class JwtTokenVerifyGuard implements CanActivate {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly jwt: JwtService,
  ) {}

  canActivate(
    context: ExecutionContext,
  ): boolean | Promise<boolean> | Observable<boolean> {
    const request = context.switchToHttp().getRequest();
    if (!request.headers['accesstoken']) {
      throw new UnauthorizedException('Access token is missing');
    }
    let accessToken = request.headers['accesstoken'];

    if (accessToken.includes('Bearer')) {
      accessToken = accessToken.split('Bearer ')[1];
    }

    if (!accessToken) {
      throw new UnauthorizedException('Access token is missing');
    }

    let decodedAccessToken: any;
    try {
      decodedAccessToken = this.jwt.verify(accessToken);
      request.decodedAccessToken = decodedAccessToken;
    } catch (error) {
      throw new UnauthorizedException('Invalid access token');
    }

    return this.validateTokenKeyMatch(decodedAccessToken);
  }

  private async validateTokenKeyMatch(
    decodedAccessToken: any,
  ): Promise<boolean> {
    if (!decodedAccessToken.id || !decodedAccessToken.username)
      throw new UnauthorizedException(
        'Invalid access token or has been modified',
      );

    const user = await this.prismaService.users.findUnique({
      where: {
        id: decodedAccessToken.id,
        username: decodedAccessToken.username,
      },
    });

    if (!user || !user.refresh_token) {
      throw new UnauthorizedException('User not found or has been deleted');
    }
    if (user.is_ban) throw new ForbiddenException('User has been banned');

    let decodedRefreshToken: any;
    try {
      decodedRefreshToken = this.jwt.verify(user.refresh_token);
    } catch (error) {
      throw new UnauthorizedException('Invalid refresh token');
    }
    if (decodedAccessToken.key !== decodedRefreshToken.key) {
      throw new UnauthorizedException('Tokens have been leaked');
    }
    return true;
  }
}
