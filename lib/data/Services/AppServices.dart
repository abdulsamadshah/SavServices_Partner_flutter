
import 'package:go_router/go_router.dart';
import 'package:partner/Routers/app_route_constants.dart';
import 'package:partner/core/Utils/pref_res.dart';
import 'package:partner/core/constant/global.dart';

class AppServices {
  userAuth(context) async {
    await Future.delayed(const Duration(seconds: 2));
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => CallScreen(),
    //     ));
    if (Global.storageServices.get(PrefConst.deviceToken) !=
        null ) {
      GoRouter.of(context).goNamed(MyAppRouteConstants.dashBoardScreen);
    } else {
      GoRouter.of(context).goNamed(MyAppRouteConstants.dashBoardScreen);
      // GoRouter.of(context).goNamed(MyAppRouteConstants.loginScreen);
    }
  }
}
