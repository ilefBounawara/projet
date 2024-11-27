import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ElevatorListPage extends StatelessWidget {
  final WebSocketChannel channel;

  const ElevatorListPage({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
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
        stream: channel.stream, // Flux WebSocket
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erreur de connexion WebSocket"));
          } else if (snapshot.hasData) {
            // Affichage des données reçues dans la console pour le débogage
            print("Données reçues : ${snapshot.data}");

            try {
              // Décoder les données JSON reçues
              final List elevators = json.decode(snapshot.data.toString());

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2, // Nombre de colonnes fixe
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  children: List.generate(elevators.length, (index) {
                    final elevator = elevators[index];
                    return ElevatorCard(
                      id: 'Ascensseur A1',//text
                      title: elevator['Id'] ?? 'Inconnu',
                      status: elevator['State'] ?? 'Inconnu',
                      currentFloor: int.tryParse(elevator['Floor'] ?? '0') ?? 0,
                      directionIcon: elevator['Direction'] == "0"
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      isActive: elevator['State'] == 'active',
                      onTap: () {
                        Navigator.pushNamed(context, '/elevatorInfo');
                      },
                    );
                  }),
                ),
              );
            } catch (e) {
              print("Erreur lors de l'analyse des données JSON: $e");
              return const Center(
                  child: Text("Erreur lors de l'analyse des données"));
            }
          } else {
            return const Center(child: Text("Aucune donnée reçue"));
          }
        },
      ),
    );
  }
}

class ElevatorCard extends StatefulWidget {
  final String title;
  final String id;
  final String status;
  final int currentFloor;
  final IconData directionIcon;
  final bool isActive;
  final VoidCallback onTap;

  const ElevatorCard({
    super.key,
    required this.id,
    required this.title,
    required this.status,
    required this.currentFloor,
    required this.directionIcon,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<ElevatorCard> createState() => _ElevatorCardState();
}

class _ElevatorCardState extends State<ElevatorCard> {
  bool _isTapped = false;

  void _handleTap() {
    setState(() {
      _isTapped = true;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isTapped = false;
      });
      widget.onTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: _isTapped
              ? Colors.blue[200] // Couleur lors de l'appui
              : (widget.isActive ? Colors.white : Colors.grey[400]),
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
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.status,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Étage actuel : ${widget.currentFloor}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Icon(
              widget.directionIcon,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
