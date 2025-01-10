// import 'package:flutter/material.dart';
// import '../models/food.dart';
// import '../util/api_util.dart';
// import '../components/food_card.dart';
// import 'food_details_screen.dart';
//
// class FoodListScreen extends StatefulWidget {
//   final int categoryId;
//   final String categoryName;
//   final bool showFavoritesOnly;
//   final String? filterType;
//
//   const FoodListScreen({
//     required this.categoryId,
//     required this.categoryName,
//     required this.showFavoritesOnly,
//     this.filterType,
//     super.key,
//   });
//
//   @override
//   State<FoodListScreen> createState() => _FoodListScreenState();
// }
//
// class _FoodListScreenState extends State<FoodListScreen> {
//   List<Food> foods = [];
//   bool isLoading = true;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchFoods();
//   }
//
//   Future<void> fetchFoods() async {
//     try {
//       if (widget.showFavoritesOnly) {
//         // Fetch all foods and filter for favorites
//         final response = await ApiUtil.fetchAllFoods();
//         print("Response for All Foods: ${response}"); // Debugging response
//         setState(() {
//           foods = (response['data'] as List)
//               .map((e) => Food.fromJson(e))
//               .where((food) => food.isFavourite)
//               .toList();
//           isLoading = false;
//         });
//       } else {
//         // Fetch foods for a specific category
//         final response = await ApiUtil.fetchCategoryDetails(widget.categoryId);
//         print("Response for Category Foods: ${response}"); // Debugging response
//         setState(() {
//           foods = (response['attributes']?['foods']?['data'] as List? ?? [])
//               .map((e) => Food.fromJson(e))
//               .toList();
//
//           // Apply filter if specified
//           if (widget.filterType != null) {
//             foods = _applyFilter(widget.filterType!);
//           }
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Error fetching foods: $e");
//       setState(() {
//         isLoading = false;
//         errorMessage = "Failed to load foods. Please try again later.";
//       });
//     }
//   }
//
//   List<Food> _applyFilter(String filterType) {
//     switch (filterType) {
//       case 'glutenFree':
//         return foods.where((food) => food.isGlutenFree).toList();
//       case 'containsGluten':
//         return foods.where((food) => !food.isGlutenFree).toList();
//       case 'vegetarian':
//         return foods.where((food) => food.type.toLowerCase() == 'vegetarian').toList();
//       case 'nonVegetarian':
//         return foods.where((food) => food.type.toLowerCase() == 'non-vegetarian').toList();
//       default:
//         return foods;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.categoryName),
//         backgroundColor: Colors.teal,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//           ? Center(
//         child: Text(
//           errorMessage,
//           style: const TextStyle(color: Colors.red),
//         ),
//       )
//           : foods.isEmpty
//           ? const Center(child: Text("No foods available."))
//           : ListView.builder(
//         itemCount: foods.length,
//         itemBuilder: (context, index) {
//           final food = foods[index];
//           return FoodCard(
//             name: food.name,
//             type: food.type,
//             isGlutenFree: food.isGlutenFree,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FoodDetailsScreen(
//                     foodId: food.id,
//                     foodName: food.name,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/food.dart';
import '../util/api_util.dart';
import '../components/food_card.dart';
import 'food_details_screen.dart';

class FoodListScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final bool showFavoritesOnly;
  final String? filterType;

  const FoodListScreen({
    required this.categoryId,
    required this.categoryName,
    required this.showFavoritesOnly,
    this.filterType,
    super.key,
  });

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  List<Food> foods = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  Future<void> fetchFoods() async {
    try {
      if (widget.showFavoritesOnly) {
        final response = await ApiUtil.fetchAllFoods();
        setState(() {
          foods = (response['data'] as List)
              .map((e) => Food.fromJson(e))
              .where((food) => food.isFavourite)
              .toList();
          isLoading = false;
        });
      } else {
        final response = await ApiUtil.fetchCategoryDetails(widget.categoryId);
        setState(() {
          foods = (response['attributes']?['foods']?['data'] as List? ?? [])
              .map((e) => Food.fromJson(e))
              .toList();

          if (widget.filterType != null) {
            foods = _applyFilter(widget.filterType!);
          }
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching foods: $e");
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load foods. Please try again later.";
      });
    }
  }

  List<Food> _applyFilter(String filterType) {
    switch (filterType) {
      case 'glutenFree':
        return foods.where((food) => food.isGlutenFree).toList();
      case 'containsGluten':
        return foods.where((food) => !food.isGlutenFree).toList();
      case 'vegetarian':
        return foods.where((food) => food.type.toLowerCase() == 'vegetarian').toList();
      case 'nonVegetarian':
        return foods.where((food) => food.type.toLowerCase() == 'non-vegetarian').toList();
      default:
        return foods;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 5,
        actions: [
          if (!widget.showFavoritesOnly)
            IconButton(
              icon: const Icon(Icons.filter_alt, color: Colors.white),
              onPressed: () {
                // Navigate to filter options or open a filter dialog
              },
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
        ),
      )
          : foods.isEmpty
          ? const Center(child: Text("No foods available."))
          : GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.8,
        ),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailsScreen(
                    foodId: food.id,
                    foodName: food.name,
                  ),
                ),
              );
            },
            child: Card(
              color: Colors.teal[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (food.imageUrls.isNotEmpty)
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        'https://lecook.pirus.app${food.imageUrls[0]}',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.teal[800]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Type: ${food.type}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          food.isGlutenFree
                              ? "Gluten-Free"
                              : "Contains Gluten",
                          style: TextStyle(
                            color: food.isGlutenFree
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
