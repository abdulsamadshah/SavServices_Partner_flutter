import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:partner/core/Utils/color_res.dart';

import 'package:partner/logic/bloc/Dashboard/dashboard_cubit.dart';
import 'package:partner/presentation/screen/Orders/orderScreen.dart';

import '../../../core/constant/Dialog.dart';
import '../../../core/constant/appTheme.dart';
import '../../common_widget/common_widget.dart';
import '../Product/ProductMain.dart';
import 'Home.dart';
import 'NavigationBar.dart';

class DashboardScreen extends StatefulWidget {
  @override
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  final List<Widget> _pages = [
    const Home(),
     ProductMain(),
    const Orderscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DialogBox.confirmationDialog(context,
            title: 'Are you sure you want to exit?',
            leftButtonOntap: () {
              Navigator.pop(context);
            },
            rightButtonOntap: () => exit(0));
        return true;
      },
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) => Scaffold(
          drawer: Navigationbar(
            // profileState: ProfileState,
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorRes.appColor,
                    ColorRes.appColor,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    leading: Builder(
                      builder: (context) => InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: reausableIcon(
                            icon: Icons.menu, color: Colors.white, size: 30),
                      ),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(left: 0.w),
                        child: InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            radius: 28.r,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 27.r,
                              backgroundColor: Colors.white,
                              backgroundImage:
                              NetworkImage(MyAppTheme.ProfilenotFoundImg),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                        height: 10.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: _pages[state.selectedIndex],
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(8.r),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r), // Rounded corners
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: GNav(
                  gap: 8,
                  activeColor: Colors.white,
                  color: Colors.grey,
                  backgroundColor: Colors.black,
                  tabBackgroundColor: ColorRes.appColor,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  tabs: const [

                    GButton(
                      icon: Icons.home_outlined,
                      text: 'Home',
                      iconColor: Colors.white,
                    ),

                    GButton(
                      icon: Icons.category,
                      text: 'Product',
                      iconColor: Colors.white,
                    ),

                    GButton(
                      icon: Icons.category,
                      text: 'Orders',
                      iconColor: Colors.white,
                    ),
                  ],
                  selectedIndex: state.selectedIndex,
                  onTabChange: (index) {
                    context.read<DashboardCubit>().changeIndex(index);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
