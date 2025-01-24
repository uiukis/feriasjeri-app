import 'package:feriasjeri_app/views/create_voucher_screen.dart';
import 'package:feriasjeri_app/widgets/bar_bottom_sheet.dart';
import 'package:feriasjeri_app/widgets/custom_drawer.dart';
import 'package:feriasjeri_app/widgets/custom_icon_button.dart';
import 'package:feriasjeri_app/widgets/custom_search_bar.dart';
import 'package:feriasjeri_app/widgets/voucher_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _advancedDrawerController = AdvancedDrawerController();

  Color _appBarColor = Colors.transparent;
  BorderRadiusGeometry _modalBorderRadius = const BorderRadius.vertical(
    top: Radius.circular(16),
  );
  double _zoomFactor = 1;
  String _searchQuery = "";
  bool _isSearchBarExpanded = false;

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  void _openSlidingModal() {
    showBarModalBottomSheet(
      context: context,
      builder: (context) {
        return const CreateVoucherScreen();
      },
    );
  }

  void _updateOffset(double offset) {
    double maxOffset = 25;
    double progress = (offset / maxOffset).clamp(0.0, 1.0);
    setState(() {
      _appBarColor = Color.lerp(
        Colors.transparent,
        Colors.grey.shade300,
        progress,
      )!;
      _zoomFactor = 1 + (progress * 0.1);
    });

    if (offset > 10 && _modalBorderRadius != BorderRadius.zero) {
      setState(() {
        _modalBorderRadius = BorderRadius.zero;
      });
    } else if (offset <= 10 &&
        _modalBorderRadius !=
            const BorderRadius.vertical(top: Radius.circular(16))) {
      setState(() {
        _modalBorderRadius = const BorderRadius.vertical(
          top: Radius.circular(16),
        );
      });
    }
  }

  void _onSearch(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _handleSearchBarExpand(bool isExpanded) {
    if (!isExpanded) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _isSearchBarExpanded = isExpanded;
          });
        }
      });
    } else {
      setState(() {
        _isSearchBarExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBarHeight = 80 + mediaQuery.padding.top;
    final maxModalHeightFactor =
        (mediaQuery.size.height - appBarHeight) / mediaQuery.size.height;
    return CustomDrawer(
      drawerController: _advancedDrawerController,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: _appBarColor,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: appBarHeight,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                icon: Icons.menu,
                onPressed: _handleMenuButtonPressed,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _isSearchBarExpanded ? 0.0 : 1.0,
                child: (!_isSearchBarExpanded)
                    ? const Text(
                        'Vouchers',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              CustomSearchBar(
                hintText: "Buscar vouchers...",
                onSearch: _onSearch,
                onExpand: _handleSearchBarExpand,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.6,
                child: AnimatedScale(
                  scale: _zoomFactor,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.75,
              minChildSize: 0.75,
              maxChildSize: maxModalHeightFactor,
              builder: (context, scrollController) {
                scrollController.addListener(() {
                  _updateOffset(scrollController.offset);
                });

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: _modalBorderRadius,
                  ),
                  child: VoucherList(
                    scrollController: scrollController,
                    searchQuery: _searchQuery,
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openSlidingModal,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
