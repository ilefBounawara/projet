import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager {
  final WebSocketChannel _channel;
  late Stream<dynamic> _stream;

  WebSocketManager(String url)
      : _channel = WebSocketChannel.connect(Uri.parse(url)) {
    _stream = _channel.stream.asBroadcastStream();
  }

  Stream<dynamic> get stream => _stream;

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  void close() {
    _channel.sink.close();
  }
}
