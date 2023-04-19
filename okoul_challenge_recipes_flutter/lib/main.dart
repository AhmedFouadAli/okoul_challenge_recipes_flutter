import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/theme_manager.dart';
import 'features/recipes/presentation/controllers/recipes_controller.dart';
import 'routing/app_router.dart';
import 'utils/app_prefs.dart';

void main() async {
  // To remove the # when running the project in the web
  usePathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();

  // Add encryption certificate to support https for Android 7 and older
  ByteData cert = await PlatformAssetBundle().load('assets/cert/isrg_x1.pem');
  try {
    SecurityContext.defaultContext
        .setTrustedCertificatesBytes(cert.buffer.asUint8List());
  } catch (e) {
    // ignore errors here, maybe it's already trusted
  }

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  final container = ProviderContainer(
    observers: [
      Logger(),
    ],
    overrides: [
      sharedPreferencesProvider.overrideWithValue(
        AppPreferences(
          sharedPreferences: sharedPreferences,
        ),
      ),
    ],
  );
  container.read(asyncNotifierProvider.notifier).fetchRecipes();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(GoRoterProvider),
      debugShowCheckedModeBanner: false,
      title: 'RecipeX',
      theme: ref.watch(getAppThemeProvider),
    );
  }
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue,
      Object? oldValue, ProviderContainer container) {
    // log('Riverpod managment -->: ${provider.name} value: $oldValue new: $newValue');
  }
}
