import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchingInternetConnectionNotifier extends Notifier<bool> {
  @override
  build() {
    initConnectivity();
    return false;
  }

  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  void initConnectivity() async {
    log("initConnectivity");
    Connectivity connectivity = Connectivity();
    _connectivityResult = await connectivity.checkConnectivity();
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      log(result.toString());

      if (result == ConnectivityResult.none) {
        log("false");
        state = false;
      } else {
                log("True");

        state = true;
      }
    });
  }
}

final watchingInternetConnectionNotifierProvider =
    NotifierProvider<WatchingInternetConnectionNotifier, bool>(
        WatchingInternetConnectionNotifier.new);
