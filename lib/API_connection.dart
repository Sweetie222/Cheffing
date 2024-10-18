import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiKey = '7c39dfc22f474620b4b82e9e6aa9f54f'; // Your Spoonacular API key

  Future<List<dynamic>> fetchRecipes() async {
    final response = await http.get(
      Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&number=100',
      ),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['results']; // Return the list of recipes
    } else {
      ('Failed to load recipes');
      ('Status code: ${response.statusCode}');
      ('Response body: ${response.body}');
      throw Exception('Failed to load recipes');
    }
  }
}
