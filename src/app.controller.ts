import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { IInfoApiType } from './interfaces/interfaces.global';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getInfoApi(): Promise<IInfoApiType> {
    return this.appService.getInfoApi();
  }
}
