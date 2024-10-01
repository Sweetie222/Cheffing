import 'package:flutter/material.dart';
class RecipeDetailPage extends StatelessWidget {
  final String title;

  const RecipeDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/grilled_Spaghetti.jpg'),
            const SizedBox(height: 20),
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('• Ingredient 1'),
            const Text('• Ingredient 2'),
            // Add more ingredients here
            const SizedBox(height: 20),
            const Text(
              'Instructions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
                'Step 1: Do this.\nStep 2: Do that.\nStep 3: Enjoy your meal!'),
            // Add more steps here
          ],
        ),
      ),
    );
  }
}
