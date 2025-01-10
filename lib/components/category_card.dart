import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final bool isFavourite;
  final VoidCallback onTap;

  const CategoryCard({
    required this.name,
    required this.isFavourite,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge, // Updated from bodyText1
              ),
              const SizedBox(height: 8),
              if (isFavourite)
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
