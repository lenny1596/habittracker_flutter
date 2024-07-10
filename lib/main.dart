import 'package:flutter/material.dart';
import 'package:habittracker_flutter/database/habit_database.dart';
import 'package:habittracker_flutter/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize db
  await HabitDatabase.initialize();
  await HabitDatabase().saveLaunchDate();

  runApp(
    MultiProvider(
      providers: [
        // Habit provider
        ChangeNotifierProvider(
          create: (context) => HabitDatabase(),
        ),
        
        // Theme provider
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
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
