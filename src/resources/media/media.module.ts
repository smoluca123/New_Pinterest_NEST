import { Module } from '@nestjs/common';
import { MediaService } from './media.service';
import { MediaController } from './media.controller';
import { SupabaseService } from 'src/supabase/supabase.service';
import { CommentsGateway } from './gateways/comments.gateway';

@Module({
  controllers: [MediaController],
  providers: [MediaService, SupabaseService, CommentsGateway],
})
export class MediaModule {}
