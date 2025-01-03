import 'package:flutter/material.dart';
import 'package:smart_ascenseur/DAO/CreditCardPaymentPage.dart'; // Vérifiez le chemin d'import
import 'package:smart_ascenseur/DAO/CashPaymentFormPage.dart'; // Vérifiez le chemin d'import

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final String userName = "Foulen Ben Foulen"; // Nom statique
  int _selectedIndex = 1; // Onglet sélectionné par défaut

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFFECECF9),
        centerTitle: true,
        elevation: 0,
        title: Text(
          userName,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onPressed: () {
              // Action du bouton
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD7E3F9), Color(0xFFD0D0FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Paiement',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: 'SansitaSwashed',
                ),
              ),
              const SizedBox(height: 30),
              PaymentOption(
                imagePath: 'credit_card.png',
                text: 'Carte de crédit',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreditCardPaymentPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              PaymentOption(
                imagePath: 'pay.png',
                text: 'Espèce',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CashPaymentFormPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              PaymentOption(
                imagePath: 'qr-code.png',
                text: 'QR Code',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreditCardPaymentPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: const Color(0xFF6C63FF),
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            _buildNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isSelected: _selectedIndex == 0,
            ),
            _buildNavItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Payer',
              isSelected: _selectedIndex == 1,
            ),
            _buildNavItem(
              icon: Icons.notifications_none,
              label: 'Notification',
              isSelected: _selectedIndex == 2,
            ),
            _buildNavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isSelected: _selectedIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: isSelected
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFFB39DDB)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            )
          : Icon(icon),
      label: label,
    );
  }
}

class PaymentOption extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const PaymentOption({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(imagePath, height: 40, width: 40),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
