import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  final Function(String) onApply;

  const FilterOptions({required this.onApply, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Gluten-Free'),
            onTap: () => onApply('glutenFree'),
          ),
          ListTile(
            title: const Text('Contains Gluten'),
            onTap: () => onApply('containsGluten'),
          ),
          ListTile(
            title: const Text('Vegetarian'),
            onTap: () => onApply('vegetarian'),
          ),
          ListTile(
            title: const Text('Non-Vegetarian'),
            onTap: () => onApply('nonVegetarian'),
          ),
        ],
      ),
    );
  }
}
