import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EtageActuelPage extends StatefulWidget {
  final WebSocketChannel channel;

  const EtageActuelPage({Key? key, required this.channel}) : super(key: key);

  @override
  _EtageActuelPageState createState() => _EtageActuelPageState();
}

class _EtageActuelPageState extends State<EtageActuelPage> {
  int _currentFloor = 0; // Étage actuel
  int? _activeFloor; // Étage sélectionné

  /// Fonction pour gérer la sélection d'un étage
  void _changeFloor(int floor) {
    setState(() {
      _activeFloor = floor;
    });

    // Afficher une notification (SnackBar)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Étape sélectionnée : $floor'),
         duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C7693),
      appBar: AppBar(
        title: const Text('Sélectionnez un Étage'),
        backgroundColor: const Color(0xFFD9D9D9),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Titre principal
          Text(
            'Choisir un étage :',
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
          const SizedBox(height: 20),

          // Générer les boutons pour les étages
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _changeFloor(i); // Gérer l'étage actif
                    Navigator.pushNamed(
                      context,
                      '/direction',
                      arguments: {
                        'selectedFloor': _activeFloor
                      }, // Étape envoyée
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: _activeFloor == i
                            ? Colors.white // Couleur si sélectionné
                            : (i == _currentFloor
                                ? Colors.grey[400] // Couleur de l'étage actuel
                                : Colors.grey[400]), // Couleur inactive
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$i',
                        style: GoogleFonts.ramaraja(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 40),

          /*// Bouton pour naviguer vers la page suivante
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[400],
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              if (_activeFloor != null) {
                Navigator.pushNamed(
                  context,
                  '/direction',
                  arguments: {'selectedFloor': _activeFloor}, // Étape envoyée
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Veuillez sélectionner un étage avant de continuer.'),
                  ),
                );
              }
            },
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 24,
            ),
          ),*/
        ],
      ),
    );
  }
}
