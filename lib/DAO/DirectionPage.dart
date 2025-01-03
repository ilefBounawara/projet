import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DirectionPage extends StatelessWidget {
  final WebSocketChannel channel;

  const DirectionPage({Key? key, required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupération des arguments de la page précédente
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int currentFloor = args['selectedFloor']; // Étape actuel reçu

    // Fonction pour afficher un SnackBar
    void showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: GoogleFonts.ramaraja(fontSize: 18, color: Colors.white),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF6C7693),
      appBar: AppBar(
        title: const Text('Direction'),
        backgroundColor: const Color(0xFFD9D9D9),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choisissez une Direction depuis l\'étage $currentFloor :',
              style: GoogleFonts.ramaraja(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
                wordSpacing: 4.0,
                shadows: const [
                  Shadow(
                    offset: Offset(3, 3),
                    blurRadius: 6,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton "Monter" avec GIF
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    showSnackBar('l\'étage : $currentFloor, Monter');
                    Navigator.pushNamed(
                      context,
                      '/elevator_list',
                      arguments: {
                        'currentFloor': currentFloor,
                        'directionselected': 'Monter',
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        'Monter',
                        style: GoogleFonts.ramaraja(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'haut.gif',
                        height: 60,
                        width: 60,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Bouton "Descendre" avec GIF
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    showSnackBar('l\'étage : $currentFloor, Descendre');
                    Navigator.pushNamed(
                      context,
                      '/elevator_list',
                      arguments: {
                        'currentFloor': currentFloor,
                        'direction': 'Descendre',
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        'Descendre',
                        style: GoogleFonts.ramaraja(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'bas.gif',
                        height: 60,
                        width: 60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Bouton pour revenir à la page précédente
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {
                    showSnackBar('Retour à la page précédente');
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
