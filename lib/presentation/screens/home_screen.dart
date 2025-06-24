import 'package:flutter/material.dart';
import 'package:keepit/features/wallet/presentation/screens/wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.wallet), label: 'My wallet'),
        ],
        onDestinationSelected: (value) => setState(() {
          currentIndex = value;
        }),
        selectedIndex: currentIndex,
      ),
      body: [
        HomeScreen(),
        WalletScreen(),
      ][currentIndex],
    );
  }
}
