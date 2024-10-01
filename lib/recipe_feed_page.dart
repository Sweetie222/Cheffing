import 'package:cheffing/recipe_details_page.dart';
import 'package:flutter/material.dart';

class RecipeFeedPage extends StatefulWidget {
  const RecipeFeedPage({super.key});

  @override
  _RecipeFeedPageState createState() => _RecipeFeedPageState();
}

class _RecipeFeedPageState extends State<RecipeFeedPage> {
  // List of all recipes
  final List<Map<String, String>> _recipes = [
    {
      'title': 'Flavorful Fried Rice Fiesta',
      'imageUrl': 'assets/grilled_Spaghetti.jpg',
    }
    // Add more recipes here...
  ];

  // List to store filtered recipes
  late List<Map<String, String>> _filteredRecipes;

  // Create a FocusNode for the search bar
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _filteredRecipes = _recipes; // Initialize with all recipes
  }

  // Function to filter recipes based on search input
  void _filterRecipes(String query) {
    setState(() {
      _filteredRecipes = _recipes
          .where((recipe) =>
          (recipe['title'] ?? '').toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    // Dispose the FocusNode when the widget is disposed
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Feed'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              focusNode: _searchFocusNode, // Assign the FocusNode to the TextField
              onTap: () {
                // Automatically open the keyboard when the search bar is tapped
                FocusScope.of(context).requestFocus(_searchFocusNode);
              },
              onChanged: _filterRecipes,
              decoration: InputDecoration(
                hintText: 'Search for a recipe...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,  // Two cards per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _filteredRecipes.length,  // Use _filteredRecipes instead of _recipes
        itemBuilder: (context, index) {
          final recipe = _filteredRecipes[index];  // Use _filteredRecipes here as well
          return RecipeCard(
            title: recipe['title']!,
            imageUrl: recipe['imageUrl']!,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailPage(
                    title: recipe['title']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final String title;
  final String imageUrl;

  const Cards({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecipeCard(
          title: title,
          imageUrl: imageUrl,
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Color color;
  final VoidCallback onPressed;

  const RecipeCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.color = Colors.white,
    required this.onPressed, // Accept the onPressed callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),  // Rounded corners for the card
        ),
        elevation: 4,  // Adds shadow for elevation effect
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // Align text to the left
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),  // Rounded corners for the image
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,  // Ensures the image takes full width of the card
                  height: 100,  // You can adjust the height as per your needs
                ),
              ),
              const SizedBox(height: 10),  // Space between image and text
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
