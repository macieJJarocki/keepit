import 'package:flutter/material.dart';
import 'package:keepit/data/repositories/impl_card_repository.dart';
import 'package:keepit/data_source/local/impl_card_local_datasource.dart';
import 'package:keepit/routing/router.dart';
import 'package:keepit/ui/features/wallet/view_model/wallet_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init local db
  ImplLocalDataSource.instance;

  runApp(const Keepit());
}

class Keepit extends StatelessWidget {
  const Keepit({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ImplLocalDataSource>(
          create: (context) => ImplLocalDataSource.instance,
        ),
        Provider<ImplCardRepository>(
          create: (context) => ImplCardRepository(database: context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => WalletViewModel(context.read())..getCards(),
        ),
      ],
      child: Sizer(
        builder: (p0, p1, p2) => MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter().getRouter,
        ),
      ),
    );
  }
}
