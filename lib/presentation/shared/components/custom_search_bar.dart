import 'package:feriasjeri_app/presentation/shared/components/custom_icon_button.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final String hintText;
  final Function(bool) onExpand;
  const CustomSearchBar({
    super.key,
    required this.onSearch,
    required this.onExpand,
    this.hintText = "Pesquisar...",
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      if (_isSearching) {
        _controller.reverse();
        _searchController.clear();
        widget.onSearch('');
      } else {
        _controller.forward();
      }
      _isSearching = !_isSearching;
      widget.onExpand(_isSearching);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double animationEndValue = screenWidth * 0.6;

    _widthAnimation = Tween<double>(begin: 0, end: animationEndValue).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    return Row(
      children: [
        AnimatedBuilder(
          animation: _widthAnimation,
          builder: (context, child) {
            return _widthAnimation.value > 0 || _isSearching
                ? Container(
                    width: _widthAnimation.value,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        if (_isSearching)
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: widget.onSearch,
                              autofocus: _isSearching,
                              decoration: InputDecoration(
                                hintText: widget.hintText,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : const SizedBox();
          },
        ),
        const SizedBox(width: 8),
        CustomIconButton(
          icon: _isSearching ? Icons.close : Icons.search,
          onPressed: _toggleSearch,
        ),
      ],
    );
  }
}
