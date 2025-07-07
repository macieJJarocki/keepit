import 'package:flutter/material.dart';
import 'package:keepit/ui/features/wallet/view/wallet_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  // TODO important for NavigationBar
  // https://medium.com/@vimehraa29/flutter-go-router-the-crucial-guide-41dc615045bb
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.wallet), label: 'My wallet'),
        ],
        onDestinationSelected: (value) => setState(() {
          currentIndex = value;
        }),
      ),
      body: [
        WalletScreen(),
      ][currentIndex],
    );
  }
}
