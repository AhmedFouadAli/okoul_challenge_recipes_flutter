import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'constants/theme_manager.dart';
import 'routing/app_router.dart';

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

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(GoRoterProvider),
      debugShowCheckedModeBanner: false,
      title: 'RecipeX',
      theme: getAppTheme(),
    );
  }
}
