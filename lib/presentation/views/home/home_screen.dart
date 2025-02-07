import 'package:feriasjeri_app/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_drawer.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_icon_button.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_search_bar.dart';
import 'package:feriasjeri_app/presentation/views/home/widgets/voucher_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

    final mediaQuery = MediaQuery.of(context);
    final appBarHeight = 80 + mediaQuery.padding.top;
    final maxModalHeightFactor =
        (mediaQuery.size.height - appBarHeight) / mediaQuery.size.height;

    return CustomDrawer(
      drawerController: homeController.advancedDrawerController,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: Obx(
            () => AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: homeController.appBarColor.value,
              toolbarHeight: appBarHeight,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomIconButton(
                    icon: Icons.menu,
                    onPressed: homeController.handleMenuButtonPressed,
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity:
                        homeController.isSearchBarExpanded.value ? 0.0 : 1.0,
                    child: (!homeController.isSearchBarExpanded.value)
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
                    onSearch: homeController.onSearch,
                    onExpand: homeController.handleSearchBarExpand,
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
                      scale: homeController.zoomFactor.value,
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
                  homeController.updateOffset(scrollController.offset);
                });

                return Obx(() => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: homeController.modalBorderRadius.value,
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
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text("Novo voucher"),
          onPressed: homeController.showVoucherModal,
        ),
      ),
    );
  }
}
