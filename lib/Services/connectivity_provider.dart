import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnectivityProvider with ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  InternetConnectivityProvider() {
    _checkInternet();
  }

  void _checkInternet() async {
    final connectivity = Connectivity();
    _connectivitySubscription = connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Check if at least one connection type is available
      bool hasConnection = results.contains(ConnectivityResult.mobile) || results.contains(ConnectivityResult.wifi);
      
      if (_isConnected != hasConnection) {
        _isConnected = hasConnection;
        notifyListeners(); // Notify UI when connection changes
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
