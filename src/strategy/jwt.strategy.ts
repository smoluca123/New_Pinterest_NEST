import { PrismaService } from 'src/prisma/prisma.service';

import { ConfigService } from '@nestjs/config';
import { Strategy, ExtractJwt } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable, UnauthorizedException } from '@nestjs/common';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    readonly config: ConfigService,
    readonly prisma: PrismaService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: config.get('JWT_SECRET'),
    });
  }

  async validate(payload: { id: number; auth_code: string }) {
    const auth = await this.prisma.auth_code.findFirst({
      where: {
        id: payload.id,
        auth_code: payload.auth_code,
      },
    });
    if (!auth) throw new UnauthorizedException();
    return payload;
  }
}
