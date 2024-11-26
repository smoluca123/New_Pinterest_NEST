import { PrismaModule } from './prisma/prisma.module';
import { JwtStrategy } from './strategy/jwt.strategy';
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';
import configuration from './config/configuration';
import { JwtModule } from '@nestjs/jwt';
import { JwtConfigService } from './jwt/jwt-config.service';
import { ThrottlerGuard, ThrottlerModule } from '@nestjs/throttler';
import { APP_GUARD } from '@nestjs/core';
import { AuthModule } from './resources/auth/auth.module';
import { MediaModule } from './resources/media/media.module';
import { UserModule } from './resources/user/user.module';
import { MulterModule } from '@nestjs/platform-express';
import { EmailModule } from './resources/email/email.module';
import { AuthGuard } from '@nestjs/passport';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      load: [configuration],
    }),
    JwtModule.registerAsync({
      global: true,
      imports: [ConfigModule],
      useClass: JwtConfigService,
    }),
    MulterModule.register({
      dest: './uploads',
    }),
    ThrottlerModule.forRoot([{ ttl: 2000, limit: 100 }]),
    PrismaModule,
    AuthModule,
    UserModule,
    MediaModule,
    EmailModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    JwtStrategy,
    {
      provide: APP_GUARD,
      useClass: ThrottlerGuard,
    },
    {
      provide: APP_GUARD,
      useClass: AuthGuard('jwt'),
    },
  ],
})
export class AppModule {}
