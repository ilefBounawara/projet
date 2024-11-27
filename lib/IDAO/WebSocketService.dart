import 'dart:io';

void main() {
  // Création du serveur WebSocket
  HttpServer.bind('localhost', 5000).then((server) {
    print('WebSocket Server running on ws://localhost:5000');
    server.transform(WebSocketTransformer()).listen(handleWebSocket);
  }).catchError((e) {
    print('Error starting WebSocket server: $e');
  });
}

// Gestion des connexions WebSocket
void handleWebSocket(WebSocket client) {
  print('Client connected');
  client.listen((message) {
    print('Message received: $message');
    
    // Répondre selon le message reçu
    if (message.contains('Floor:')) {
      client.add('Server received floor data: $message');
    } else if (message.contains('Direction:')) {
      client.add('Server received direction data: $message');
    } else {
      client.add('Unknown data: $message');
    }
  }, onDone: () {
    print('Client disconnected');
  });
}
