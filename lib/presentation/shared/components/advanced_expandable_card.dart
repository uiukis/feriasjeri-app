import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class AdvancedExpandableCard extends StatelessWidget {
  final String title;
  final String description;
  final double closedHeight;
  final double openedHeight;
  final Color backgroundColor;

  const AdvancedExpandableCard({
    super.key,
    required this.title,
    required this.description,
    this.closedHeight = 70,
    this.openedHeight = 250,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: OpenContainer(
        closedElevation: 4,
        openElevation: 8,
        transitionDuration: const Duration(milliseconds: 500),
        closedBuilder: (context, action) =>
            _buildClosedContainer(context, action),
        openBuilder: (context, action) => _buildOpenedContainer(context),
        closedColor: backgroundColor,
        openColor: backgroundColor,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        openShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildClosedContainer(BuildContext context, VoidCallback action) {
    return Container(
      height: closedHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 24),
        ],
      ),
    );
  }

  Widget _buildOpenedContainer(BuildContext context) {
    return Container(
      height: openedHeight,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ),
        ],
      ),
    );
  }
}
