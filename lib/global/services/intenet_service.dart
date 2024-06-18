import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionChangeController = StreamController<bool>.broadcast();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  InternetService() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_connectionChanged);
  }

  Stream<bool> get connectionChange => _connectionChangeController.stream;

  void _connectionChanged(ConnectivityResult result) {
    _connectionChangeController.add(result != ConnectivityResult.none);
  }

  Future<bool> get isConnected async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void dispose() {
    _connectivitySubscription.cancel();
    _connectionChangeController.close();
  }
}
