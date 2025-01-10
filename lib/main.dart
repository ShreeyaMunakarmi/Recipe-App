import 'package:flutter/material.dart';
import 'screens/category_list_screen.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const CategoryListScreen(),
    );
  }
}
