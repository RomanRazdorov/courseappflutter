import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:client_id/app/ui/main_app_builder.dart';
import 'package:client_id/app/ui/main_app_runner.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const env = String.fromEnvironment("env", defaultValue: "prod");
  const runner = MainAppRunner(env);
  final builder = MainAppBuilder();
  runner.run(builder);
}
