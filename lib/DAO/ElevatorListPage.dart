import 'package:flutter/material.dart';

class ElevatorListPage extends StatelessWidget {
  const ElevatorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB1C4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB1C4E8),
        elevation: 0,
        title: const Text(
          'Liste d\'ascenseur',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: [
            ElevatorCard(
              title: 'Ascenseur 1',
              status: 'Occupé',
              currentFloor: 7,
              directionIcon: Icons.arrow_upward,
              isActive: true,
              onTap: () {
                Navigator.pushNamed(context, '/elevatorInfo');
              },
            ),
            ElevatorCard(
              title: 'Ascenseur 2',
              status: 'Libre',
              currentFloor: 3,
              directionIcon: Icons.arrow_downward,
              isActive: false,
              onTap: () {
                Navigator.pushNamed(context, '/elevatorInfo');
              },
            ),
            ElevatorCard(
              title: 'Ascenseur 3',
              status: 'En maintenance',
              currentFloor: 5,
              directionIcon: Icons.arrow_downward,
              isActive: true,
              onTap: () {
                Navigator.pushNamed(context, '/elevatorInfo');
              },
            ),
            ElevatorCard(
              title: 'Ascenseur 4',
              status: 'Libre',
              currentFloor: 1,
              directionIcon: Icons.arrow_upward,
              isActive: true,
              onTap: () {
                Navigator.pushNamed(context, '/elevatorInfo');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ElevatorCard extends StatefulWidget {
  final String title;
  final String status;
  final int currentFloor;
  final IconData directionIcon;
  final bool isActive;
  final VoidCallback onTap;

  const ElevatorCard({
    super.key,
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

    // Delay to show the color change briefly before navigating
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
              ? Colors.blue[200] // Color when tapped
              : (widget.isActive ? Colors.white : Colors.grey[400]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/elevator.png', // Use your elevator icon here
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