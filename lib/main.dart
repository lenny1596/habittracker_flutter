import 'package:flutter/material.dart';
import 'package:habittracker_flutter/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'pages.dart/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const SafeArea(
        child: HomePage(),
      ),
    );
  }
}
