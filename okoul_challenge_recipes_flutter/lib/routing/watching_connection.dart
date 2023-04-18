import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum connectionStatus { initial, connected, notConnected }


final watchingProvider = StreamProvider<connectionStatus>((ref) {
  Connectivity connectivity = Connectivity();
   return connectivity.onConnectivityChanged.map((event) {
     return event == ConnectivityResult.none
        ? connectionStatus.notConnected
        : connectionStatus.connected;
  });
});
