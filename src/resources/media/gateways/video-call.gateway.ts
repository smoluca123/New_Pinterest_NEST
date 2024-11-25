// src/voice.gateway.ts

import {
  SubscribeMessage,
  WebSocketGateway,
  OnGatewayConnection,
  OnGatewayDisconnect,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';

@WebSocketGateway({
  cors: {
    origin: '*', // Cấu hình CORS phù hợp với môi trường của bạn
    methods: ['GET', 'POST'],
  },
})
export class VoiceGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  handleConnection(client: Socket) {
    console.log(`Client connected2: ${client.id}`);
  }

  handleDisconnect(client: Socket) {
    console.log(`Client disconnected2: ${client.id}`);
    // Thông báo cho các client khác nếu cần
    this.server.emit('user-disconnected', client.id);
  }

  @SubscribeMessage('call-user')
  handleCallUser(client: Socket, payload: { offer: any; to: string }) {
    this.server.to(payload.to).emit('call-made', {
      offer: payload.offer,
      socket: client.id,
    });
  }

  @SubscribeMessage('make-answer')
  handleMakeAnswer(client: Socket, payload: { answer: any; to: string }) {
    this.server.to(payload.to).emit('answer-made', {
      answer: payload.answer,
      socket: client.id,
    });
  }

  @SubscribeMessage('ice-candidate')
  handleIceCandidate(client: Socket, payload: { candidate: any; to: string }) {
    this.server.to(payload.to).emit('ice-candidate', {
      candidate: payload.candidate,
      socket: client.id,
    });
  }
}
