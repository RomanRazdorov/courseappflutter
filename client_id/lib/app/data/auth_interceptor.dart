import 'package:client_id/app/di/init_di.dart';
import 'package:client_id/app/domain/app_api.dart';
import 'package:client_id/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = locator.get<AuthCubit>().state.whenOrNull(
          authorized: (userEntity) => userEntity.accessToken,
        );
    if (accessToken == null) {
      super.onRequest(options, handler);
    }
    final headers = options.headers;
    headers["Authorization"] = "Bearer $accessToken";
    super.onRequest(options.copyWith(headers: headers), handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await locator.get<AuthCubit>().refreshToken().then((token) async {
          if (token == null) {
            super.onError(err, handler);
          } else {
            err.requestOptions.headers["Authorization"] = "Bearer $token";
            final request =
                await locator.get<AppApi>().fetch(err.requestOptions);
            return handler.resolve(request);
          }
        });
      } on DioError catch (error) {
        super.onError(error, handler);
      }
    } else {
      super.onError(err, handler);
    }
  }
}
