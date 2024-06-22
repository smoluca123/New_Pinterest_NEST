import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import configuration from './config/configuration';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { ValidationPipe } from '@nestjs/common';

const config = configuration();

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const configDocument = new DocumentBuilder()
    .setTitle('Pinterest API')
    .setDescription('Pinterest API')
    .setVersion('1.0')
    .addBearerAuth({ type: 'http', scheme: 'bearer', bearerFormat: 'JWT' })
    .build();
  const document = SwaggerModule.createDocument(app, configDocument);
  SwaggerModule.setup('/swagger', app, document);
  app.useGlobalPipes(new ValidationPipe());
  app.enableCors();
  await app.listen(config.port);
}
bootstrap();
