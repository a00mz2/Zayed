// ignore_for_file: prefer_typing_uninitialized_variables, empty_catches

import 'package:get/get.dart';
import 'package:zayed/Controller/AuthControler.dart';
import 'package:zayed/Controller/NotificationsController.dart';
import 'package:zayed/modules/Agent/Controller/HomeControllerAgent.dart';
import 'package:zayed/modules/Agent/Controller/MainControlIerAgent.dart';
import 'package:zayed/modules/Agent/Controller/profileControllerAgent.dart';
import 'package:zayed/modules/Customer/Controller/CategoriesControllerCustomer.dart';
import 'package:zayed/modules/Customer/Controller/MainControlIerCustomer.dart';
import 'package:zayed/modules/Customer/Controller/StoreControllerCustomer.dart';
import 'package:zayed/modules/Customer/Controller/StoreMainCategoriesControllerCustomer.dart';
import 'package:zayed/modules/Customer/Controller/StoresControllerCustomer.dart';
import 'package:zayed/modules/Influencer/controller/HomeControllerInfluencer.dart';
import 'package:zayed/modules/Influencer/controller/MainControlIerInfluencer.dart';
import 'package:zayed/modules/Influencer/controller/WalletControllerInfluencer.dart';
import 'package:zayed/modules/Merchant/controller/AllProductControllerMerchant.dart';
import 'package:zayed/modules/Merchant/controller/CategoryControllerMerchant.dart';
import 'package:zayed/modules/Merchant/controller/HomeControllerMerchant.dart';
import 'package:zayed/modules/Merchant/controller/InvoiceControllerMerchant.dart';
import 'package:zayed/modules/Merchant/controller/MainControllerMerchant.dart';
import 'package:zayed/modules/Merchant/controller/ProductControllerMerchant.dart';
import 'package:zayed/modules/Merchant/controller/ProfileControllerMerchant.dart';
import 'package:zayed/modules/Merchant/controller/StaffControllerMerchant.dart';
import 'package:zayed/modules/Merchant/controller/SubCategoryControllerMerchant.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}

class MainInfluencerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MainControlIerInfluencer());
    Get.put(HomeControllerInfluencer());
    Get.put(WalletControllerInfluencer());
  }
}

class MainAgentBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MainControllerAgent());
    Get.put(HomeControllerAgent());
    Get.put(ProfileControllerAgent());
    // Get.put(HomeControllerInfluencer());
    // Get.put(WalletControllerInfluencer());
  }
}

//==============Merchant======================
class MainMerchantBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MainControllerMerchant());
    Get.put(HomeControllerMerchant());
    Get.put(ProfileControllerMerchant());
    Get.put(AllProductControllerMerchant());
    Get.put(InvoiceControllerMerchant());
  }
}

class CategoryMerchantBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Get.put(CategoryControllerMerchant()));
  }
}

class SubCategoryMerchantBindings extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>;
    Get.put(
      SubCategoryControllerMerchant(
        categoryId: args['categoryId'],
        categoryName: args['categoryName'],
      ),
    );
  }
}

class ProductMerchantBindings extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>;
    Get.put(
      ProductControllerMerchant(
        categoryId: args['categoryId'],
        subCategoryId: args['subCategoryId'],
        subCategoryName: args['subCategoryName'],
      ),
    );
  }
}

class StaffMerchantBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StaffControllerMerchant());
  }
}

//==============Customer======================

class MainCustomerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MainControlIerCustomer());
  }
}

class StoresCustomerBindings extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>;

    Get.put(StoresControllerCustomer(model: args['model']));
  }
}

class CategoriesCustomerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoriesControllerCustomer());
  }
}

class StoreCustomerBindings extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>;
    Get.put(StoreControllerCustomer(storeId: args["id"]));
  }
}

class StoreMainCategoriesCustomerBindings extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>;
    Get.put(StoreMainCategoriesControllerCustomer(storeId: args["storeId"]));
  }
}

//============================================
class NotificationsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsController());
  }
}
