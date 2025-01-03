import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:smart_ascenseur/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Créez un WebSocketChannel fictif pour les tests.
    final mockChannel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:5039/ws'), // Adresse fictive pour les tests.
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(channel: mockChannel));

    // Vérifiez que notre application s'exécute correctement.
    expect(find.text('0'), findsNothing);
    expect(find.text('Sélectionnez un Etage'), findsOneWidget);

    // Simulez une interaction, si applicable.
    // (Vous pouvez ajouter des tests spécifiques ici selon votre application.)
  });
}
