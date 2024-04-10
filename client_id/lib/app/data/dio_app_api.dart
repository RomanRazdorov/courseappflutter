import 'package:client_id/app/data/auth_interceptor.dart';
import 'package:client_id/app/domain/app_api.dart';
import 'package:client_id/app/domain/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Singleton(as: AppApi)
class DioAppApi implements AppApi {
  late final Dio dio;
  DioAppApi(AppConfig appConfig) {
    final options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: const Duration(seconds: 15000),
    );
    dio = Dio(options);
    if (kDebugMode) dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<Response> getProfile() {
    try {
      return dio.get("/auth/user");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> passwordUpdate(
      {required String oldPassword, required String newPassword}) {
    return dio.put("/auth/user", queryParameters: {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    });
  }

  @override
  Future<Response> refreshToken({String? refreshToken}) {
    try {
      return dio.post("/auth/token/$refreshToken");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> signIn(
      {required String password, required String username}) {
    try {
      return dio.post("/auth/token",
          data: {"username": username, "password": password});
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> signUp(
      {required String password,
      required String username,
      required String email}) {
    try {
      return dio.put("/auth/token",
          data: {"username": username, "email": email, "password": password});
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> userUpdate({String? username, String? email}) {
    return dio.post("/auth/user", data: {
      "username": username,
      "email": email,
    });
  }

  @override
  Future<dynamic> request(String path) {
    try {
      return dio.request(path);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future fetch(RequestOptions requestOptions) {
    return dio.fetch(requestOptions);
  }

  @override
  Future fetchPosts() {
    return dio.get("/data/posts");
  }

  @override
  Future createPost(Map args) {
    return dio.post("/data/posts", data: {
      "name": args["name"],
      "content": args["content"],
    });
  }
}



  // Import from DioContainer
  // void addInterceptor(Interceptor interceptor) {
  //   if (dio.interceptors.contains(interceptor)) {
  //     dio.interceptors.remove(interceptor);
  //   }

  //   deleteInterceptor(interceptor.runtimeType);

  //   dio.interceptors.add(interceptor);
  // }

  // void deleteInterceptor(Type type) {
  //   dio.interceptors.removeWhere((element) => element.runtimeType == type);
  // }