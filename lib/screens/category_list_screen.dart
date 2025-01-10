// import 'package:flutter/material.dart';
// import '../models/category.dart';
// import '../util/api_util.dart';
// import 'food_list_screen.dart';
// import 'filter_options.dart';
//
// class CategoryListScreen extends StatefulWidget {
//   const CategoryListScreen({super.key});
//
//   @override
//   State<CategoryListScreen> createState() => _CategoryListScreenState();
// }
//
// class _CategoryListScreenState extends State<CategoryListScreen> {
//   List<Category> categories = [];
//   bool isLoading = true;
//   String errorMessage = '';
//   int _currentTabIndex = 0; // Track selected tab for navigation
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCategories();
//   }
//
//   Future<void> fetchCategories() async {
//     try {
//       final response = await ApiUtil.fetchCategories(1);
//       setState(() {
//         categories = (response['data'] as List).map((e) => Category.fromJson(e)).toList();
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching categories: $e");
//       setState(() {
//         isLoading = false;
//         errorMessage = "Failed to load categories. Please try again later.";
//       });
//     }
//   }
//
//   void navigateToFavorites() {
//     // Retrieve all foods marked as favorite within all categories
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FoodListScreen(
//           categoryId: -1, // Pass a dummy ID since we want to fetch all favorites
//           categoryName: 'Favorites',
//           showFavoritesOnly: true, // Ensure only favorites are displayed
//         ),
//       ),
//     );
//   }
//
//   void showFilterModal() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return FilterOptions(
//           onApply: (String filterType) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => FoodListScreen(
//                   categoryId: categories.first.id, // Use the first category for demonstration
//                   categoryName: 'Filtered Foods',
//                   showFavoritesOnly: false,
//                   filterType: filterType,
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Categories')),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//           ? Center(child: Text(errorMessage))
//           : GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//         ),
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           final category = categories[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FoodListScreen(
//                     categoryId: category.id,
//                     categoryName: category.name,
//                     showFavoritesOnly: false,
//                   ),
//                 ),
//               );
//             },
//             child: Card(
//               child: Center(
//                 child: Text(
//                   category.name,
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentTabIndex,
//         selectedItemColor: Colors.teal,
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             _currentTabIndex = index;
//           });
//           if (index == 1) {
//             navigateToFavorites(); // Navigate to Favorites
//           } else if (index == 2) {
//             showFilterModal(); // Show filter modal
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: 'All',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favorites',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.filter_alt),
//             label: 'Filter',
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../util/api_util.dart';
import 'food_list_screen.dart';
import '../screens/filter_options.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  List<Category> categories = [];
  bool isLoading = true;
  String errorMessage = '';
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await ApiUtil.fetchCategories(1);
      setState(() {
        categories = (response['data'] as List)
            .map((e) => Category.fromJson(e))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching categories: $e");
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load categories. Please try again later.";
      });
    }
  }

  void showFilterModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterOptions(
          onApply: (String filterType) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodListScreen(
                  categoryId: categories.first.id,
                  categoryName: 'Filtered Foods',
                  showFavoritesOnly: false,
                  filterType: filterType,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.teal,
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
          : categories.isEmpty
          ? const Center(
        child: Text("No categories available."),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodListScreen(
                    categoryId: category.id,
                    categoryName: category.name,
                    showFavoritesOnly: false,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.tealAccent,
                          Colors.teal,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (category.isFavorite)
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 32,
                          ),
                        Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
          if (index == 1) {
            showFilterModal();
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: 'Filter',
          ),
        ],
      ),
    );
  }
}
