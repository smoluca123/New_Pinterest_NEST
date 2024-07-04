import { Module } from '@nestjs/common';
import { MediaService } from './media.service';
import { MediaController } from './media.controller';
import { SupabaseService } from 'src/supabase/supabase.service';

@Module({
  controllers: [MediaController],
  providers: [MediaService, SupabaseService],
})
export class MediaModule {}
