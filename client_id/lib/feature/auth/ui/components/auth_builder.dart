import 'package:client_id/app/domain/error_entity.dart/error_entity.dart';
import 'package:client_id/app/ui/components/app_snack_bar.dart';
import 'package:client_id/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBuilder extends StatelessWidget {
  @override
  const AuthBuilder({
    Key? key,
    required this.isNotAuthorized,
    required this.isWaiting,
    required this.isAuthorized,
  }) : super(key: key);

  final WidgetBuilder isNotAuthorized;
  final WidgetBuilder isWaiting;
  final ValueWidgetBuilder isAuthorized;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.when(
            notAuthorized: () => isNotAuthorized(context),
            waiting: () => isWaiting(context),
            authorized: (userEntity) => isAuthorized(context, userEntity, this),
            error: (error) => isNotAuthorized(context));
      },
      listenWhen: ((previous, current) =>
          previous.mapOrNull(
            error: (value) => value,
          ) !=
          current.mapOrNull(
            error: (value) => value,
          )),
      listener: (context, state) {
        state.whenOrNull(
          error: (error) => AppSnackBar.showSnackBarWithError(
              context, ErrorEntity.fromException(error)),
        );
      },
    );
  }
}
