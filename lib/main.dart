import 'package:breaking_app/app_route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BreakingBad(
    appRouter: AppRoute(),
  ));
}

class BreakingBad extends StatelessWidget {
  const BreakingBad({Key? key, required this.appRouter}) : super(key: key);

  final AppRoute appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
