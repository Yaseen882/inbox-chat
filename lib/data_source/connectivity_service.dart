import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';


class ConnectivityProvider extends ChangeNotifier {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  ConnectivityProvider() {
    _init();
  }

  Future<void> _init() async {
    _connectivityResult = await Connectivity().checkConnectivity();
    notifyListeners();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityResult = result;
      notifyListeners();
    });
  }

  bool get isConnected =>
      _connectivityResult != ConnectivityResult.none;
}
