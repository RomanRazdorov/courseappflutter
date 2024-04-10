import 'package:client_id/app/domain/app_builder.dart';

abstract class AppRunner {
  
  Future<void> preloadData();

  Future<void> run(AppBuilder appBuilder);
}