import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import configuration from './config/configuration';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

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
  await app.listen(config.port);
}
bootstrap();
