import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Roles } from 'src/decorators/roles.decorator';
import { IRequestWithDecodedAuthToken } from 'src/interfaces/interfaces.global';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private prisma: PrismaService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const rolesLevel = this.reflector.get<number[]>(
      Roles,
      context.getHandler(),
    );
    if (!rolesLevel) return true;

    const minRoleLevel = Math.min(...rolesLevel);

    const request = context.switchToHttp().getRequest();
    const {
      user: { id, auth_code },
    } = request as IRequestWithDecodedAuthToken;
    // const {
    //   decodedAccessToken: { id, username },
    // } = request as IRequestWithDecodedAccessToken;
    const auth = await this.prisma.auth_code.findUnique({
      where: {
        id: +id,
        auth_code,
      },
      select: {
        auth_roles: true,
      },
    });

    if (!auth || auth.auth_roles.role_level < minRoleLevel)
      throw new UnauthorizedException(
        'You are not authorized to perform this action.',
      );
    return true;
  }
}
