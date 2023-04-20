import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vega_innovattions_assignmen/vega_app.dart';

import 'core/functions/easy_loader_config.dart';
import 'features/common/presentation/blocs/bloc_observer.dart';
import 'injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocators();

  /// Enable/Disable Logs
  // Bloc.observer = SmabooBlocObserver(); // Setup global observer to monitor all blocs.

  ConfigEasyLoader.darkTheme(); // Set theme for EasyLoader indicator

  /// Setup local storage
  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(() => runApp(const VegaApp()), storage: storage);
}
