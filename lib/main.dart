import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_app/db/database.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteDatabase.initialiseDatabase();

  runApp(
    MultiProvider(providers:[
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: const MyApp(),
    ),
  );
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}