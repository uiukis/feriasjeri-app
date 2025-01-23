import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final Widget title;
  final Widget content;
  final double? openedHeight;
  final double? closedHeight;

  const ExpandableCard({
    super.key,
    required this.title,
    required this.content,
    this.openedHeight = 80,
    this.closedHeight = 200,
  });

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _iconRotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _iconRotation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _toggleCard() {
    setState(() {
      if (isExpanded) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isExpanded = !isExpanded;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      height: isExpanded ? widget.openedHeight : widget.closedHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _toggleCard,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.title,
                RotationTransition(
                  turns: _iconRotation,
                  child: const Icon(Icons.expand_more, size: 24),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (isExpanded)
            Expanded(
              child: SingleChildScrollView(child: widget.content),
            ),
        ],
      ),
    );
  }
}
