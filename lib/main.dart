import 'package:flutter/material.dart';
import 'package:keepit/core/routing/router.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const Keepit());
}

class Keepit extends StatelessWidget {
  const Keepit({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, p2) => MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter().getRouter,
      ),
    );
  }
}
