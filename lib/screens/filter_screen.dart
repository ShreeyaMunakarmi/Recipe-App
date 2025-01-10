import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final Function(String) onApplyFilters;

  const FilterScreen({required this.onApplyFilters, Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool isVegetarian = false;
  bool isNonVegetarian = false;
  bool isGlutenFree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filters")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Vegetarian Only"),
              value: isVegetarian,
              onChanged: (val) {
                setState(() {
                  isVegetarian = val;
                });
              },
            ),
            SwitchListTile(
              title: const Text("Non-Vegetarian Only"),
              value: isNonVegetarian,
              onChanged: (val) {
                setState(() {
                  isNonVegetarian = val;
                });
              },
            ),
            SwitchListTile(
              title: const Text("Gluten-Free"),
              value: isGlutenFree,
              onChanged: (val) {
                setState(() {
                  isGlutenFree = val;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String filterType = '';
                if (isVegetarian) {
                  filterType = 'vegetarian';
                } else if (isNonVegetarian) {
                  filterType = 'nonVegetarian';
                } else if (isGlutenFree) {
                  filterType = 'glutenFree';
                }

                widget.onApplyFilters(filterType);
                Navigator.pop(context);
              },
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
