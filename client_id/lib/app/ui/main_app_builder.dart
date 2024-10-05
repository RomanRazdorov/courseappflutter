import 'package:adaptive_theme/adaptive_theme.dart';
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
  Widget buildApp(savedThemeMode) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => _GlobalProviders(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          home: const RootScreen(),
        ),
      ),
      debugShowFloatingThemeButton: true,
    );
    // return _GlobalProviders(
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: RootScreen(),
    //   ),
    // );
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
