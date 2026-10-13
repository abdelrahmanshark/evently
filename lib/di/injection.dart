import 'package:evently/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

bool _isConfigured = false;

/// Registers all annotated classes. Safe to call more than once per isolate.
@InjectableInit()
void configureDependencies() {
  if (_isConfigured) return;
  getIt.init();
  _isConfigured = true;
}
