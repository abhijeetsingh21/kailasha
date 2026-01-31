import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/core/constants/global_keys.dart';
import 'package:kailasha/core/di/injectable.dart';
import 'package:kailasha/core/preference/preference.dart';
import 'package:kailasha/core/utils/bloc/app_reset_scope.dart';
import 'package:kailasha/core/utils/bloc/bloc_observer.dart';
import 'package:kailasha/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // await dotenv.load(fileName: ".env");

  // Initialize SharedPreferences singleton
  await Preferences().init();

  await Future.delayed(const Duration(seconds: 1));
  Bloc.observer = const Observer();
  runApp(
    AppResetScope(appResetKey: GlobalKeys.appResetKey, child: const App()),
  );
}
