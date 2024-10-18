import 'package:flutter/material.dart';
import 'package:cheffing/recipe_feed_page.dart';
import 'package:cheffing/recipe_details_page.dart';
import 'package:cheffing/registration/sign_in_page.dart';
import 'API_connection.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cheffing',
      theme: ThemeData(
        brightness: Brightness.dark, // Dark theme to match the design
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RegistrationPage(),
        '/feed': (context) => const RecipeFeedPage(),
        '/details': (context) => const RecipeDetailPage(title: 'Recipes',),
      },
    );
  }
}

