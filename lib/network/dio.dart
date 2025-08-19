import 'package:dio/dio.dart';
import 'package:ensake/services/config_services.dart';
import 'package:ensake/utils/functions.dart';
import 'package:ensake/utils/storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  late Dio dio;

  Api() {
    dio = Dio(
      BaseOptions(
        baseUrl: ConfigServices.get('BASE_URL'),
        receiveTimeout: Duration(seconds: 60),
        connectTimeout: Duration(seconds: 60),
        sendTimeout: Duration(seconds: 60),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );
    dio.interceptors.add(PrettyDioLogger(request: true, requestBody: true));
    dio.interceptors.addAll({AppInterceptors(dio: dio)});
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  String? token;
  String? ensakeDevice;
  final storage = StorageImpl();

  AppInterceptors({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    ensakeDevice = await getEnsakeDevice();
    token = await storage.getToken();
    if (token != null && token != "") {
      options.headers.addAll({'Authorization': "Bearer $token"});
    }
    options.headers.addAll(({'Ensake-Device': ensakeDevice ?? ""}));
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
