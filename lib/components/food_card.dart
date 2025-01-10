// import 'package:flutter/material.dart';
//
// class FoodCard extends StatelessWidget {
//   final String name;
//   final String type;
//   final bool isGlutenFree;
//   final VoidCallback onTap;
//
//   const FoodCard({
//     required this.name,
//     required this.type,
//     required this.isGlutenFree,
//     required this.onTap,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         margin: const EdgeInsets.all(8), // Adds space around the card
//         elevation: 4, // Adds shadow for depth
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12), // Rounded corners
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16), // Adds padding inside the card
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name,
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ), // Styled with theme
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 "Type: $type",
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 isGlutenFree ? 'Gluten Free' : 'Contains Gluten',
//                 style: TextStyle(
//                   color: isGlutenFree ? Colors.green : Colors.red,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final String type;
  final bool isGlutenFree;
  final String? imageUrl;
  final VoidCallback onTap;

  const FoodCard({
    required this.name,
    required this.type,
    required this.isGlutenFree,
    this.imageUrl,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium ??
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Type: $type",
                    style: Theme.of(context).textTheme.bodyMedium ??
                        const TextStyle(fontSize: 14),
                  ),
                  Text(
                    isGlutenFree ? "Gluten-Free" : "Contains Gluten",
                    style: TextStyle(
                      color: isGlutenFree ? Colors.green : Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
