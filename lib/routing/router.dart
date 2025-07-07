import 'package:go_router/go_router.dart';
import 'package:keepit/ui/features/wallet/view/new_card_view.dart';
import 'package:keepit/ui/features/wallet/view/scanner_view.dart';
import 'package:keepit/ui/features/wallet/view/wallet_view.dart';
import 'package:keepit/presentation/screens/home_screen.dart';

class AppRouter {
  GoRouter get getRouter => _router;

  final GoRouter _router = GoRouter(
    initialLocation: '/newcard',
    routes: [
      // GoRoute(
      //   name: 'home',
      //   path: '/',
      //   builder: (context, state) => HomeScreen(),
      // ),
      GoRoute(
        name: 'wallet',
        path: '/wallet',
        builder: (context, state) => WalletScreen(),
      ),
      GoRoute(
        name: 'scanner',
        path: '/scanner',
        builder: (context, state) => ScannerScreen(),
      ),
      GoRoute(
        name: 'newcard',
        path: '/newcard',

        builder: (context, state) {
          if (state.extra != null) {
            final args = state.extra as Map<String, dynamic>;
            return NewCardScreen(
              name: args['name'],
              value: args['value'],
              description: args['description'],
              id: args['id'],
            );
          }

          return NewCardScreen();
        },
      ),
    ],
  );
}
