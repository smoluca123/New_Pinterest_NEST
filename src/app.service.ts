import { Injectable } from '@nestjs/common';
import { IInfoApiType } from './interfaces/interfaces.global';
import { PrismaService } from './prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';
import { EmailService } from './resources/email/email.service';

@Injectable()
export class AppService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly emailService: EmailService,
  ) {}
  async getInfoApi(): Promise<IInfoApiType> {
    // const authCode = await this.prisma.auth_code.findFirst({});
    // const authorizationToken: string = this.jwt.sign(authCode, {
    //   expiresIn: '30d',
    // });

    return {
      name: 'Pinterest API',
      version: '1.0.0',
      // authorizationToken,
      author: 'Luca Dev',
      swagger: '/swagger',
      description: 'New Pinterest API',
    };
  }
}
