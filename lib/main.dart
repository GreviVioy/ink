import 'package:flutter/material.dart';
import 'package:ink/resources/data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => PageNavigatorProvider()),
    ChangeNotifierProvider(create: (context) => DataProvider())
  ], child: const MaterialApp(home: MainApp())));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainState createState() => MainState();
}

class MainState extends State<MainApp> {
  late PageNavigatorProvider pgp;

  @override
  Widget build(BuildContext context) {
    pgp = Provider.of<PageNavigatorProvider>(context);
    return pgp.page[pgp.index];
  }
}
