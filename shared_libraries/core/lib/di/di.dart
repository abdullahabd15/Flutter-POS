import 'package:core/network/api_constant.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:dependencies/get_it/get_it.dart';

import '../network/dio_handler.dart';

class CoreModule {
  CoreModule() {
    _init();
  }

  void _init() {
    sl.registerLazySingleton<DioHandler>(
      () => DioHandler(baseUrl: ApiConstant.baseUrl),
    );
    sl.registerLazySingleton<Dio>(() => sl<DioHandler>().dio);
  }
}
