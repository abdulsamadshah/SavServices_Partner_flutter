
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partner/core/Utils/color_res.dart';
import 'package:partner/logic/debug/Bloc_Observer.dart';
import 'storage_services.dart';


class Global {
  static late StorageServices storageServices;


  static Future init() async {




    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Bloc.observer = MyGlobalObserver();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: ColorRes.white
    ));

    storageServices = await StorageServices().init();
  }


}
