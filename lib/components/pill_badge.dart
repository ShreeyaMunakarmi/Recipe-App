import 'package:flutter/material.dart';

class PillBadge extends StatelessWidget {
  final String label;
  final Color color;

  const PillBadge({required this.label, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}
