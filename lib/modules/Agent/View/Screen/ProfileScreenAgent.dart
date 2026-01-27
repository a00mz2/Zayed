// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/core/functions/logOut.dart';
import 'package:zayed/modules/Agent/Controller/profileControllerAgent.dart';
import 'package:zayed/view/Screen/ResetPasswordScreen.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';

class ProfileScreenAgent extends StatelessWidget {
  ProfileScreenAgent({super.key});
  final controler = Get.find<ProfileControllerAgent>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: false,
      onRefresh: () => controler.getDataProfile(),
      statusRequest: controler.statusRequest,
      statusCode: controler.statusCode,
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Stack(
            children: [
              Image.asset(
                AppImage.backgrond3,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Column(
                children: [
                  SizedBox(height: 47),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 56,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الحساب",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                color: Color(0xff0E0E0E),
                                fontSize: 17,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10000),
                          onTap: () => Get.toNamed("/Notifications"),
                          child: Image.asset(
                            AppIcons.notificationsIcon,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    height: 64,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                controler.profileData['name'],
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      color: Color(0xff0E0E0E),
                                      fontSize: 20,
                                      fontWeight: MyFontWeight.regular,
                                    ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                "وكيل معتمد",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      color: Color(0xff00896F),
                                      fontSize: 12,
                                      fontWeight: MyFontWeight.regular,
                                    ),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xdd680039), Color(0xddCE0070)],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(100000),
                            child: Obx(
                              () => Image.network(
                                (controler.profileData['avatarUrl']
                                        as String?) ??
                                    '',
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 45,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            height: 67,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppIcons.phoneIcon, width: 20, height: 20),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "رقم الهاتف",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Color(0xff5A5A5A),
                        fontSize: 12,
                        fontWeight: MyFontWeight.regular,
                      ),
                    ),
                    SizedBox(height: 3),
                    Obx(
                      () => Text(
                        "${controler.profileData['phone']} (964)",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Color(0xff0E0E0E),
                          fontSize: 14,
                          fontWeight: MyFontWeight.medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            height: 67,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppIcons.emailIcon, width: 20, height: 20),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "الحساب",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Color(0xff5A5A5A),
                        fontSize: 12,
                        fontWeight: MyFontWeight.regular,
                      ),
                    ),
                    SizedBox(height: 3),
                    Obx(
                      () => Text(
                        controler.profileData['email'] ??
                            "لا يوجد بريد الكتروني ",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Color(0xff0E0E0E),
                          fontSize: 14,
                          fontWeight: MyFontWeight.medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              controler.oldPassController.text = "";
              controler.newPassController.text = "";
              Get.to(
                ResetPasswordScreen(
                  formstate: controler.formstate,
                  newPassController: controler.newPassController,
                  oldPassController: controler.oldPassController,
                  obscureText1: controler.obscureText1,
                  obscureText2: controler.obscureText2,
                  statusRequest: controler.statusRequestButton,
                  onPressed: () => controler.changePassword(),
                  showPassword: (obscure) => controler.showPassword(obscure),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              height: 67,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppIcons.lockIcon, width: 20, height: 20),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "تغيير كلمة المرور",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Color(0xff0E0E0E),
                        fontSize: 14,
                        fontWeight: MyFontWeight.medium,
                      ),
                    ),
                  ),
                  Image.asset(AppIcons.arrowGo, width: 16, height: 16),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => logout(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              height: 67,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppIcons.logout, width: 20, height: 20),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "تسجيل خروج",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: MyFontWeight.medium,
                      ),
                    ),
                  ),
                  Obx(
                    () => statusRequestLogout.value == StatusRequest.loading
                        ? SpinKitFadingCircle(size: 30, color: Colors.red)
                        : SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
