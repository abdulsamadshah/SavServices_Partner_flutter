import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:partner/core/Utils/const_res.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const Color primaryColor = Color(0xFF7B61FF);
const double defaultPadding = 16.0;


class Constant {
  static BaseOptions networkOptions = BaseOptions(
    receiveTimeout: const Duration(seconds: 15),
    connectTimeout: const Duration(seconds: 15),
    baseUrl: ConstRes.aBaseUrl,
  );
  final Dio _dio = Dio();
  Constant() {
    BaseOptions options = BaseOptions(
      baseUrl: ConstRes.aBaseUrl,
    );
    _dio.options = options;
    _dio.interceptors.add(PrettyDioLogger());
  }
  Dio get sendRequest => _dio;
}
