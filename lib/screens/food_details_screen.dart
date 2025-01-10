// import 'package:flutter/material.dart';
// import '../models/food.dart';
// import '../util/api_util.dart';
//
// class FoodDetailsScreen extends StatefulWidget {
//   final int foodId;
//   final String foodName;
//
//   const FoodDetailsScreen({
//     required this.foodId,
//     required this.foodName,
//     super.key,
//   });
//
//   @override
//   State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
// }
//
// class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
//   Food? food;
//   bool isLoading = true;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchFoodDetails();
//   }
//
//   Future<void> fetchFoodDetails() async {
//     try {
//       final response = await ApiUtil.fetchFoodDetails(widget.foodId);
//       setState(() {
//         food = Food.fromJson(response);
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching food details: $e");
//       setState(() {
//         isLoading = false;
//         errorMessage = "Failed to load food details.";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.foodName,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.teal,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//           ? Center(
//         child: Text(
//           errorMessage,
//           style: const TextStyle(color: Colors.red, fontSize: 18),
//         ),
//       )
//           : food == null
//           ? const Center(
//         child: Text(
//           "No food details available",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       )
//           : SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.all(16.0),
//           children: [
//             // Food Name
//             Center(
//               child: Text(
//                 food!.name,
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.teal,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Type
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.fastfood, color: Colors.teal),
//                 const SizedBox(width: 8),
//                 Text(
//                   "Type: ${food!.type}",
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             // Gluten-Free
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   food!.isGlutenFree
//                       ? Icons.check_circle
//                       : Icons.cancel,
//                   color: food!.isGlutenFree ? Colors.green : Colors.red,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   food!.isGlutenFree ? "Gluten-Free" : "Contains Gluten",
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//
//             // Ingredients
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.teal.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Ingredients:",
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     food!.ingredients.isNotEmpty
//                         ? food!.ingredients
//                         : 'No ingredients available',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//
//             // Steps
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.teal.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Steps:",
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     food!.steps.isNotEmpty
//                         ? food!.steps
//                         : 'No steps available',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/food.dart';
import '../util/api_util.dart';

class FoodDetailsScreen extends StatefulWidget {
  final int foodId;
  final String foodName;

  const FoodDetailsScreen({
    required this.foodId,
    required this.foodName,
    super.key,
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  Food? food;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchFoodDetails();
  }

  Future<void> fetchFoodDetails() async {
    try {
      final fetchedFood = await ApiUtil.fetchFoodDetails(widget.foodId);
      setState(() {
        food = fetchedFood;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load food details.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodName),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 5,
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
          : food == null
          ? const Center(child: Text("No food details available."))
          : ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Food Image Carousel
          if (food!.imageUrls.isNotEmpty)
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: food!.imageUrls.length,
                itemBuilder: (context, index) {
                  final imageUrl = food!.imageUrls[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://lecook.pirus.app$imageUrl',
                        width: MediaQuery.of(context).size.width * 0.8,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 16),

          // Food Name
          Text(
            food!.name,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.teal[800], fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Food Type and Gluten-Free Status
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Food Type Icon and Label
              Chip(
                avatar: Icon(
                  food!.type.toLowerCase() == 'vegetarian'
                      ? Icons.grass
                      : Icons.fastfood,
                  color: Colors.white,
                ),
                label: Text(
                  food!.type,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.teal,
              ),
              const SizedBox(width: 8),

              // Gluten-Free Icon and Label
              Chip(
                avatar: Icon(
                  food!.isGlutenFree ? Icons.check_circle : Icons.cancel,
                  color: Colors.white,
                ),
                label: Text(
                  food!.isGlutenFree ? "Gluten-Free" : "Contains Gluten",
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: food!.isGlutenFree ? Colors.green : Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Ingredients Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ingredients",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  food!.ingredients,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Steps Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Steps",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  food!.steps,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
