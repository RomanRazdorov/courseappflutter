import 'package:client_id/app/di/init_di.dart';
import 'package:client_id/app/domain/app_builder.dart';
import 'package:client_id/app/ui/root_screen.dart';
import 'package:client_id/feature/auth/domain/auth_repository.dart';
import 'package:client_id/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:client_id/feature/posts/domain/post_repo.dart';
import 'package:client_id/feature/posts/domain/state/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Widget buildApp() {
    return const _GlobalProviders(
        child: MaterialApp(
      home: RootScreen(),
    ));
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => locator.get<AuthCubit>(),
      ),
      BlocProvider(
        create: (context) =>
            PostCubit(locator.get<PostRepo>(), locator.get<AuthCubit>())
              ..fetchPosts(),
      )
    ], child: child);
  }
}
