import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food.dart';

class ApiUtil {
  static const String baseUrl = 'https://lecook.pirus.app/api';

  /// Fetch all foods
  static Future<Map<String, dynamic>> fetchAllFoods() async {
    final url = '$baseUrl/foods?populate=*';
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to fetch all foods. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchAllFoods: $e');
      rethrow;
    }
  }

  /// Fetch category details by category ID
  static Future<Map<String, dynamic>> fetchCategoryDetails(int categoryId) async {
    final url =
        '$baseUrl/categories/$categoryId?populate[foods][fields][0]=foodName'
        '&populate[foods][fields][1]=foodType&populate[foods][fields][2]=isGlutenFree'
        '&populate[foods][fields][3]=foodPhoto&fields[0]=categoryName&fields[1]=isFavourite';
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      } else {
        throw Exception(
            'Failed to fetch category details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchCategoryDetails: $e');
      rethrow;
    }
  }

  /// Fetch food details by food ID
  static Future<Food> fetchFoodDetails(int foodId) async {
    final url =
        '$baseUrl/foods/$foodId?populate[category][fields][0]=categoryName'
        '&populate[foodPhoto][populate][data][attributes][fields][0]=url'
        '&fields[0]=foodName&fields[1]=foodType&fields[2]=isGlutenFree&fields[3]=steps&fields[4]=ingredients';
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return Food.fromJson(data);
      } else {
        throw Exception(
            'Failed to fetch food details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchFoodDetails: $e');
      rethrow;
    }
  }

  /// Fetch all categories
  static Future<Map<String, dynamic>> fetchCategories(int page) async {
    final url =
        '$baseUrl/categories?populate[foods][fields][0]=foodName'
        '&populate[foods][fields][1]=foodType&populate[foods][fields][2]=isGlutenFree'
        '&fields[0]=categoryName&fields[1]=isFavourite'
        '&pagination[pageSize]=10&pagination[page]=$page&publicationState=live&locale[0]=en';
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to fetch categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchCategories: $e');
      rethrow;
    }
  }
}
