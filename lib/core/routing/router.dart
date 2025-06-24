import 'package:go_router/go_router.dart';
import 'package:keepit/features/wallet/presentation/screens/scanner_screen.dart';
import 'package:keepit/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:keepit/presentation/screens/home_screen.dart';

class AppRouter {
  GoRouter get getRouter => _router;

  final GoRouter _router = GoRouter(
    initialLocation: '/wallet',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        name: 'wallet',
        path: '/wallet',
        builder: (context, state) => WalletScreen(),
      ),
      GoRoute(
        name: 'newcard',
        path: '/newcard',
        builder: (context, state) => ScannerScreen(),
      ),
    ],
  );
}
