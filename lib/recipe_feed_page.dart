import 'package:flutter/material.dart';
import 'API_connection.dart'; // Assuming this is where the ApiService is defined
import 'recipe_details_page.dart'; // Assuming this is your details page

class RecipeFeedPage extends StatefulWidget {
  const RecipeFeedPage({super.key});

  @override
  _RecipeFeedPageState createState() => _RecipeFeedPageState();
}

class _RecipeFeedPageState extends State<RecipeFeedPage> {
  // Initialize both lists
  List<Map<String, String>> _recipes = [];
  List<Map<String, String>> _filteredRecipes = [];
  bool _isLoading = true;
  String _errorMessage = '';

  // Create a FocusNode for the search bar
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fetchRecipes(); // Call the API when the page loads
  }

  // Function to fetch recipes from the API and update state
  Future<void> _fetchRecipes() async {
    try {
      List<dynamic> apiRecipes =
          await ApiService().fetchRecipes(); // Fetch from API

      // Map the fetched recipes to the desired format
      List<Map<String, String>> recipes = apiRecipes.map((recipe) {
        return {
          'title': (recipe['title'] ?? 'No Title').toString(),
          'imageUrl': (recipe['image'] ?? '').toString(),
        };
      }).toList();

      setState(() {
        _recipes = recipes;
        _filteredRecipes = recipes; // Initialize filtered recipes
        _isLoading = false; // Fetching is done
      });
    } catch (e) {
      ('Error fetching recipes: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load recipes';
      });
    }
  }

  // Function to filter recipes based on search input
  void _filterRecipes(String query) {
    setState(() {
      _filteredRecipes = _recipes
          .where((recipe) => (recipe['title'] ?? '')
              .toLowerCase()
              .contains(query.toLowerCase()))
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
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Dismiss the keyboard on outside taps
        },
        child: Column(
          children: <Widget>[
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                focusNode: _searchFocusNode,
                onChanged: _filterRecipes,
                decoration: InputDecoration(
                  hintText: 'Search for a recipe...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
            child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : _filteredRecipes.isNotEmpty
              ? GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two cards per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1, // Adjust as needed
            ),
            itemCount: _filteredRecipes.length,
            itemBuilder: (context, index) {
              final recipe = _filteredRecipes[index];
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
            )

                : const Center(child: Text('No recipes found')),
            ),
          ],
        ),
      ),
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
      onTap: onPressed, // Navigate to recipe detail page
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15.0), // Rounded corners for the card
        ),
        elevation: 10, // Adds shadow for elevation effect
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the left
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ), // Rounded corners for the image at the top only
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double
                    .infinity, // Ensures the image takes full width of the card
                height: 120, // Adjust height as needed
                errorBuilder: (context, error, stackTrace) {
                  // Handle image loading errors
                  return Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.purple,
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 2, // Limit title to two lines
                overflow:
                    TextOverflow.ellipsis, // Add ellipsis if text overflows
              ),
            ),
          ],
        ),
      ),
    );
  }
}
