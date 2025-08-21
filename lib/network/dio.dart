import 'package:dio/dio.dart';
import 'package:ensake/services/config_services.dart';
import 'package:ensake/utils/functions.dart';
import 'package:ensake/utils/route.dart';
import 'package:ensake/utils/storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
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
    dio.interceptors.add(
      PrettyDioLogger(request: true, requestBody: true, requestHeader: true),
    );
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

    if (!options.path.contains('/login')) {
      if (token != null && token!.isNotEmpty) {
        options.headers['Authorization'] = "Bearer $token";
      }
    }
    options.headers['Ensake-Device'] = ensakeDevice ?? "";
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.message == "You are logged out") {
      // Clear stored token
      await storage.clearStorage();
      Fluttertoast.showToast(
        msg: "Session expired. Please log in again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      // Navigate back to login screen
      final context = rootNavigatorKey.currentContext;
      if (context != null) {
        GoRouter.of(context).go('/login');
      }
    }

    return handler.next(err);
  }
}
