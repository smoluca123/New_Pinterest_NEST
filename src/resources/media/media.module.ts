import { Module } from '@nestjs/common';
import { MediaService } from './media.service';
import { MediaController } from './media.controller';
import { SupabaseService } from 'src/supabase/supabase.service';
import { CommentsGateway } from './gateways/comments.gateway';
import { VoiceGateway } from 'src/resources/media/gateways/video-call.gateway';

@Module({
  controllers: [MediaController],
  providers: [MediaService, SupabaseService, CommentsGateway, VoiceGateway],
})
export class MediaModule {}
