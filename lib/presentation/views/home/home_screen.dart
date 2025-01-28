import 'package:feriasjeri_app/controllers/home_controller.dart';
import 'package:feriasjeri_app/controllers/voucher_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:feriasjeri_app/presentation/views/voucher/create_voucher_screen.dart';
import 'package:feriasjeri_app/presentation/shared/components/bar_bottom_sheet.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_drawer.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_icon_button.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_search_bar.dart';
import 'package:feriasjeri_app/presentation/views/home/widgets/voucher_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Get.put(VoucherController());

    final mediaQuery = MediaQuery.of(context);
    final appBarHeight = 80 + mediaQuery.padding.top;
    final maxModalHeightFactor =
        (mediaQuery.size.height - appBarHeight) / mediaQuery.size.height;

    return CustomDrawer(
      drawerController: controller.advancedDrawerController,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: Obx(
            () => AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: controller.appBarColor.value,
              toolbarHeight: appBarHeight,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomIconButton(
                    icon: Icons.menu,
                    onPressed: controller.handleMenuButtonPressed,
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: controller.isSearchBarExpanded.value ? 0.0 : 1.0,
                    child: (!controller.isSearchBarExpanded.value)
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
                    onSearch: controller.onSearch,
                    onExpand: controller.handleSearchBarExpand,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.6,
                child: Obx(() => AnimatedScale(
                      scale: controller.zoomFactor.value,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      child: Image.asset(
                        'assets/images/background.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    )),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.75,
              minChildSize: 0.75,
              maxChildSize: maxModalHeightFactor,
              builder: (context, scrollController) {
                scrollController.addListener(() {
                  controller.updateOffset(scrollController.offset);
                });

                return Obx(() => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: controller.modalBorderRadius.value,
                      ),
                      child: VoucherList(
                        scrollController: scrollController,
                        // searchQuery: controller.searchQuery.value,
                      ),
                    ));
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showBarModalBottomSheet(
            context: context,
            builder: (context) => const CreateVoucherScreen(),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
