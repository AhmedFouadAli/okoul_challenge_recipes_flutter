import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum connectionStatus { initial, connected, notConnected }

class WatchingInternetConnectionNotifier
    extends AsyncNotifier<connectionStatus> {
  @override
  FutureOr<connectionStatus> build() async {
    await initConnectivity();
    return connectionStatus.initial;
  }

  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  Future<void> initConnectivity() async {
    Connectivity connectivity = Connectivity();
    _connectivityResult = await connectivity.checkConnectivity();
    connectionStatus previousStatus =
        _connectivityResult == ConnectivityResult.none
            ? connectionStatus.notConnected
            : connectionStatus.connected; // set initial previous status
    state = AsyncValue.data(_connectivityResult != ConnectivityResult.none
        ? connectionStatus.connected
        : connectionStatus.notConnected); // set initial state
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none &&
          previousStatus == connectionStatus.connected) {
        state = const AsyncValue.data(connectionStatus.notConnected);
      } else if (result != ConnectivityResult.none &&
          previousStatus == connectionStatus.notConnected) {
        state = const AsyncValue.data(connectionStatus.connected);
      }
      previousStatus = result == ConnectivityResult.none
          ? connectionStatus.notConnected
          : connectionStatus.connected; // update previous status
    });
  }
}

final watchingInternetConnectionNotifierProvider =
    AsyncNotifierProvider<WatchingInternetConnectionNotifier, connectionStatus>(
        WatchingInternetConnectionNotifier.new);
