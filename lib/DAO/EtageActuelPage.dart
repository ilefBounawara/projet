import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import nécessaire
import 'package:web_socket_channel/web_socket_channel.dart';

class EtageActuelPage extends StatefulWidget {
  final WebSocketChannel channel;

  const EtageActuelPage({super.key, required this.channel});

  @override
  _EtageActuelPageState createState() => _EtageActuelPageState();
}

class _EtageActuelPageState extends State<EtageActuelPage> {
  int _currentFloor = 0;
  int _SendCurrentFloor = 0;
  int? _activeFloor; // Variable pour suivre l'état actif lors du clic

  void _sendFloorToServer(int floor) {
    if (floor <= 0) {
      print('Erreur : Étages invalides. Valeur: $floor');
      return; // Ne pas envoyer si l'étage est invalide
    }

    try {
      // Préparer les données à envoyer
      String dataToSend = 'Floor: $floor';

      // Envoyer les données via WebSocket
      widget.channel.sink.add(dataToSend);

      // Journalisation pour débogage
      print('Données envoyées au serveur : $dataToSend');

      // Mettre à jour l'état local
      setState(() {
        _currentFloor = floor; // Stocker l'étage actuel
        _activeFloor = null; // Réinitialiser l'état actif
      });

      // Retour visuel pour confirmer l'envoi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Étape envoyée avec succès : $floor'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (error) {
      // Gestion des erreurs lors de l'envoi
      print('Erreur lors de l\'envoi des données : $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'envoi des données : $error'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C7693), // Couleur de fond (bleu-gris)
      appBar: AppBar(
        title: const Text('Sélectionnez un Etage'),
        backgroundColor: const Color(0xFFD9D9D9), // Couleur de la barre d'app
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choisier Etage :',
            style: GoogleFonts.ramaraja(
              fontSize: 30, // Taille du texte
              fontWeight: FontWeight.bold, // Style gras
              color: Colors.white, // Couleur bleu clair
              letterSpacing: 2.0, // Espacement entre lettres
              wordSpacing: 4.0, // Espacement entre mots
              shadows: [
                const Shadow(
                  offset: Offset(3, 3), // Décalage de l’ombre
                  blurRadius: 6, // Intensité du flou
                  color: Colors.black26, // Ombre plus sombre
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Liste des étages sous forme de Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i <= 2; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTapDown: (_) {
                      // Activer la couleur temporaire lors du clic
                      setState(() {
                        _activeFloor = i;
                      });
                    },
                    onTapUp: (_) {
                      // Réinitialiser la couleur temporaire après le clic
                      setState(() {
                        _SendCurrentFloor = _activeFloor!;
                      });
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: _activeFloor == i
                              ? Colors.black // Couleur temporaire lors du clic
                              : (i == _currentFloor
                                  ? Colors.black // Couleur pour l'étage actuel
                                  : Colors.grey[400]), // Couleur inactive
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$i',
                          style: GoogleFonts.ramaraja(
                            fontSize: 30, // Taille du texte
                            fontWeight: FontWeight.bold, // Style gras
                            color: Colors.white, // Couleur bleu clair
                            letterSpacing: 2.0, // Espacement entre lettres
                            wordSpacing: 4.0, // Espacement entre mots
                            shadows: [
                              const Shadow(
                                offset: Offset(3, 3), // Décalage de l’ombre
                                blurRadius: 6, // Intensité du flou
                                color: Colors.black26, // Ombre plus sombre
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 40),
          // Bouton pour naviguer vers la page de direction
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[400], // Couleur du bouton
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              _sendFloorToServer(_SendCurrentFloor);
              Navigator.pushNamed(context, '/direction');
            },
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
