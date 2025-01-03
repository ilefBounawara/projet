import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ElevatorListPage extends StatelessWidget {
  final WebSocketChannel channel;

  const ElevatorListPage({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int currentFloor = args['currentFloor'];
    final String directionselected = args['direction'];

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
      backgroundColor: const Color(0xFFB1C4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB1C4E8),
        elevation: 0,
        title: const Text(
          'Liste des Ascenseurs',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erreur de connexion WebSocket",
                style: GoogleFonts.ramaraja(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2.0,
                  wordSpacing: 4.0,
                  shadows: [
                    const Shadow(
                      offset: Offset(3, 3),
                      blurRadius: 6,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasData) {
            try {
              final data = snapshot.data.toString();
              if (data.isEmpty) {
                throw FormatException("Données vides reçues.");
              }

              final List<dynamic> elevators = json.decode(data);
              if (elevators.isEmpty) {
                return const Center(
                  child: Text("Aucune donnée disponible"),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  children: elevators.asMap().entries.map((entry) {
                    final index = entry.key;
                    final elevator = entry.value;

                    return ElevatorCard(
                      id: 'Ascenseur A${index + 1}',
                      title: elevator['Id'] ?? 'Inconnu',
                      status: elevator['State'] ?? 'Inconnu',
                      currentFloor: int.tryParse(
                              elevator['Floor']?.toString() ?? '0') ??
                          0,
                      directionImage: elevator['Direction'] == "0"
                          ? 'assets/bas.gif'
                          : 'assets/haut.gif',
                      isActive: elevator['State'] == 'active',
                      onTap: () {
                        showSnackBar(
                            "l'étage : $currentFloor, direction : $directionselected, Elevator : " +
                                elevator['Id']);
                        Navigator.pushNamed(
                          context,
                          '/elevatorInfo',
                          arguments: {
                            'elevator': elevator,
                            'currentFloor': currentFloor,
                            'direction': directionselected,
                          },
                        );
                      },
                    );
                  }).toList(),
                ),
              );
            } catch (e) {
              debugPrint("Erreur lors de l'analyse des données JSON: $e");
              return const Center(
                child: Text("Erreur lors de l'analyse des données"),
              );
            }
          } else {
            return Center(
              child: Text(
                "Aucune donnée reçue",
                style: GoogleFonts.ramaraja(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2.0,
                  wordSpacing: 4.0,
                  shadows: [
                    const Shadow(
                      offset: Offset(3, 3),
                      blurRadius: 6,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class ElevatorCard extends StatelessWidget {
  final String title;
  final String id;
  final String status;
  final int currentFloor;
  final String directionImage;
  final bool isActive;
  final VoidCallback onTap;

  const ElevatorCard({
    super.key,
    required this.id,
    required this.title,
    required this.status,
    required this.currentFloor,
    required this.directionImage,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/elevator.png',
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              id,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              status,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Étage actuel : $currentFloor',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Image.asset(
              directionImage,
              height: 60,
              width: 60,
            ),
          ],
        ),
      ),
    );
  }
}
