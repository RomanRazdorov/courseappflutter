import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:client_id/app/di/init_di.dart';
import 'package:client_id/app/domain/app_builder.dart';
import 'package:client_id/app/domain/app_runner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class MainAppRunner implements AppRunner {
  final String env;

  const MainAppRunner(this.env);

  @override
  Future<void> preloadData() async {
    WidgetsFlutterBinding.ensureInitialized();
    initDi(env);
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    final storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorage.webStorageDirectory
            : await getApplicationDocumentsDirectory());
    HydratedBlocOverrides.runZoned(
      () async {
        await preloadData();
        final savedThemeMode = await AdaptiveTheme.getThemeMode();
        runApp(appBuilder.buildApp(savedThemeMode));
      },
      storage: storage,
    );
  }
}
