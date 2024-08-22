import {
  WebSocketGateway,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
  SubscribeMessage,
} from '@nestjs/websockets';

import { Server, Socket } from 'socket.io';

import { comment } from '@prisma/client';

enum CommentEvent {
  NEW_COMMENT = 'newComment',
  SUB_MEDIA_ID = 'subMediaID',
}

@WebSocketGateway({
  cors: {
    origin: '*',
  },
})
export class CommentsGateway
  implements OnGatewayConnection, OnGatewayDisconnect
{
  @WebSocketServer()
  server: Server;

  handleConnection(client: Socket) {
    console.log('Client connected:', client.id);
  }

  handleDisconnect(client: Socket) {
    console.log('Client disconnected:', client.id);
  }

  @SubscribeMessage(CommentEvent.SUB_MEDIA_ID)
  handleSubMediaID(client: Socket, mediaId: string) {
    client.join(mediaId);
  }

  broadcastNewComment({
    comment,
    mediaId,
  }: {
    comment: comment;
    mediaId: string | number;
  }) {
    this.server.to(mediaId + '').emit(CommentEvent.NEW_COMMENT, comment);
  }
}
