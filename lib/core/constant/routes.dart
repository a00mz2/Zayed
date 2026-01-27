// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/Binding/BindingApp.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/modules/Agent/View/MainScreenAgent.dart';
import 'package:zayed/modules/Customer/view/MainScreenCustomer.dart';
import 'package:zayed/modules/Customer/view/screen/CategoriesScreenCustomer.dart';
import 'package:zayed/modules/Customer/view/screen/HomeScreenCustomer.dart';
import 'package:zayed/modules/Customer/view/screen/StoreMainCategoriesScrrenCustomer.dart';
import 'package:zayed/modules/Customer/view/screen/StoreScreenCustomer.dart';
import 'package:zayed/modules/Customer/view/screen/StoresScreenCustomer.dart';
import 'package:zayed/modules/Merchant/view/MainScreenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/AddAllProductScrrenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/AddCategoryScrrenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/AddDataAccountScrrenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/AddProductScrrenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/AddStaffScrrenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/AddSubCategoryScrrenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/CategoryScrrenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/ProductScrrenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/StaffScrrenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/SubCategoryScrrenMerchant.dart';
import 'package:zayed/view/Screen/NotificationsScreen.dart';
import 'package:zayed/modules/Influencer/view/MainScreen.dart';
import 'package:zayed/view/Screen/Auth/EnterPhoneScreen.dart';
import 'package:zayed/view/Screen/Auth/LoginScreen.dart';
import 'package:zayed/view/Screen/Auth/RegisterScreen.dart';
import 'package:zayed/view/Screen/Auth/otpScreen.dart';
import 'package:zayed/view/Screen/GetStartedScreen.dart';
import 'package:zayed/view/Screen/SplashScreen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: '/',
    page: () => GetStartedScreen(),
    transition: Transition.fade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/Splash',
    page: () => SplashScreen(),
    transition: Transition.fade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/GetStarted',
    page: () => GetStartedScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/EnterPhone',
    page: () => EnterPhoneScreen(),
    binding: SignUpBinding(),
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/Otp',
    page: () => OtpScreen(),
    binding: SignUpBinding(),
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/Register',
    page: () => RegisterScreen(),
    binding: SignUpBinding(),
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/Login',
    page: () => LoginScreen(),
    binding: SignUpBinding(),
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: '/Notifications',
    page: () => NotificationsScreen(),
    binding: NotificationsBindings(),
    bindings: [],
    middlewares: [
      RoleMiddleware(
        allowedRoles: ['agent', 'customer', 'influencer', 'merchant'],
      ),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  //====================customer=======================
  GetPage(
    name: '/customer/Main',
    page: () => MainScreenCustomer(),
    binding: MainCustomerBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['customer']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/customer/Home',
    page: () => HomeScreenCustomer(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['customer']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/customer/Stores',
    page: () {
      final args = Get.arguments as Map<String, dynamic>;
      return StoresScreenCustomer(namePage: args['namePage']);
    },
    binding: StoresCustomerBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['customer']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/customer/Categories',
    page: () => CategoriesScreenCustomer(),
    binding: CategoriesCustomerBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['customer']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/customer/Store',
    page: () =>  StoreScreenCustomer(),
    binding: StoreCustomerBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['customer']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/customer/StoreMainCategories',
    page: () =>  StoreMainCategoriesScrrenCustomer(),
    binding: StoreMainCategoriesCustomerBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['customer']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  
// Get.toNamed("/customer/StoreMainCategories",
// arguments: {"storeId":"2222"},
// )

  //====================influencer=======================
  GetPage(
    name: '/influencer/Main',
    page: () => MainScreen(),
    binding: MainInfluencerBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['influencer']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  //====================Agent=======================
  GetPage(
    name: '/agent/Main',
    page: () => MainScreenAgent(),
    binding: MainAgentBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['agent']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  //====================merchant=======================
  GetPage(
    name: '/merchant/Main',
    page: () => MainScreenMerchant(),
    binding: MainMerchantBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['merchant']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/merchant/category',
    page: () => CategoryScrrenMerchant(),
    binding: CategoryMerchantBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['merchant']),
    ],
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/merchant/addCategory',
    page: () => AddCategoryScrrenMerchant(),
    binding: CategoryMerchantBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['merchant']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: '/merchant/SubCategory',
    page: () => SubCategoryScrrenMerchant(),
    binding: SubCategoryMerchantBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['merchant']),
    ],
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/merchant/addSubCategory',
    page: () => AddSubCategoryScrrenMerchant(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['merchant']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/merchant/product',
    page: () => ProductScrrenMerchant(),
    binding: ProductMerchantBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['merchant']),
    ],
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/merchant/addProduct',
    page: () => AddProductScrrenMerchant(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['merchant']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/merchant/addProductAll',
    page: () => AddAllProductScrrenMerchant(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['merchant']),
    ],
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/merchant/Staff',
    page: () => StaffScrrenMerchant(),
    binding: StaffMerchantBindings(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['merchant']),
    ],
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: '/merchant/addStaff',
    page: () => AddStaffScrrenMerchant(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['merchant']),
    ],
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/merchant/AddDataAccount',
    page: () => AddDataAccountScrrenMerchant(),
    middlewares: [
      RoleMiddleware(allowedRoles: ['merchant']),
    ],
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];

class RoleMiddleware extends GetMiddleware {
  final List<String> allowedRoles;

  RoleMiddleware({required this.allowedRoles});

  @override
  RouteSettings? redirect(String? route) {
    final role = myServices.sharedPreferences.getString("role");
    final token = myServices.sharedPreferences.getString("token");

    if (token == null || token.isEmpty) {
      return const RouteSettings(name: "/GetStarted");
    }

    // إذا الدور مسموح → يسمح له بالدخول
    if (allowedRoles.contains(role)) {
      return null;
    }

    // إذا غير مسموح → يرجعه لصفحة تسجيل الدخول
    return const RouteSettings(name: "/GetStarted");
  }
}
