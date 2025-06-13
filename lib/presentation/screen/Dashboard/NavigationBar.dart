
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partner/Routers/app_route_constants.dart';
import 'package:partner/core/Utils/color_res.dart';
import 'package:partner/core/Utils/pref_res.dart';
import 'package:partner/core/constant/Dialog.dart';

import 'package:partner/core/constant/appTheme.dart';
import 'package:partner/core/constant/global.dart';

import 'package:partner/presentation/common_widget/common_widget.dart';

import '../../../gen/fonts.gen.dart';

class Navigationbar extends StatefulWidget {
  Navigationbar({
    super.key,
  });

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        width: 280.w,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.r),
          ),
        ),
        child: Column(
          children: [
            // Header Section
            Container(
              height: 180.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorRes.primaryYellow,
                    ColorRes.primaryYellow,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 38.r,
                            backgroundImage:
                                NetworkImage(MyAppTheme.ProfilenotFoundImg),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reausabletext(
                              "Hello SavService",
                              fontfamily: FontFamily.interBold,
                              fontsize: 20,
                              widths: 160,
                              color: ColorRes.white,
                              fontweight: FontWeight.w800,
                            ),
                            reausabletext(
                              "Savservices@gmail.com",
                              fontfamily: FontFamily.interRegular,
                              fontsize: 14,
                              widths: 160,
                              color: ColorRes.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
                height: 1,
                color: Colors.grey), // Divider for aesthetic separation

            // Menu Items Section
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                      ),
                      title: reausabletext(
                        "Home",
                        fontfamily: FontFamily.interMedium,
                        fontsize: 16,
                      ),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        // Navigate to Home
                      },
                    ),

                    const Divider(
                        height: 1,
                        color: Colors.grey), // Divider after Settings

                    ListTile(
                      leading: const Icon(
                        Icons.exit_to_app,
                      ),
                      title: reausabletext(
                        "Logout",
                        fontfamily: FontFamily.interMedium,
                        fontsize: 16,
                      ),
                      onTap: () {
                        DialogBox.confirmationDialog(context,
                            title: 'Are you sure?',
                            desc: "Do you really want to Logout?",
                            leftButtonOntap: () {
                          Navigator.pop(context);
                        }, rightButtonOntap: () {
                          Navigator.pop(context);
                          Global.storageServices.remove(PrefConst.deviceToken);
                          GoRouter.of(context)
                              .goNamed(MyAppRouteConstants.loginScreen);
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
