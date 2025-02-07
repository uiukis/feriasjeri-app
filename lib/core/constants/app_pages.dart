import 'package:feriasjeri_app/core/bindings/home_binding.dart';
import 'package:feriasjeri_app/presentation/views/home/home_screen.dart';
import 'package:feriasjeri_app/presentation/views/login/login_screen.dart';
import 'package:feriasjeri_app/presentation/views/splash/splash_screen.dart';
import 'package:feriasjeri_app/presentation/views/voucher/create_voucher_screen.dart';
import 'package:feriasjeri_app/presentation/views/voucher/voucher_screen.dart';
import 'package:get/get.dart';
import 'package:feriasjeri_app/core/constants/app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.voucher,
      page: () => const VoucherScreen(),
    ),
    GetPage(
      name: AppRoutes.createVoucher,
      page: () => const CreateVoucherScreen(),
    ),
  ];
}
