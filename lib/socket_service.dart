import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  SocketService._();

  static final SocketService instance = SocketService._();

  io.Socket? _socket;

  bool get isConnected => _socket?.connected ?? false;

  void connect({required String serverUrl}) {
    if (_socket != null) return;
    _socket = io.io(
      serverUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );
  }

  void emitDriverRideStatus({
    required String rideId,
    required String status,
    required String driverName,
  }) {
    _socket?.emit('driver_ride_status', {
      'rideId': rideId,
      'status': status,
      'driverName': driverName,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void emitDriverReady() {
    _socket?.emit('driver_ready');
  }

  void emitCustomerRideRequest({
    required String rideId,
    required String customerName,
    required String pickup,
    required String drop,
    required String rideType,
    required double fare,
    required double distanceKm,
    required int etaMinutes,
  }) {
    _socket?.emit('customer_ride_request', {
      'rideId': rideId,
      'customerName': customerName,
      'pickup': pickup,
      'drop': drop,
      'rideType': rideType,
      'fare': fare,
      'distanceKm': distanceKm,
      'etaMinutes': etaMinutes,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void emitDriverRideResponse({
    required String rideId,
    required bool accepted,
    required String driverName,
  }) {
    _socket?.emit('driver_ride_response', {
      'rideId': rideId,
      'accepted': accepted,
      'driverName': driverName,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void emitDriverRideCancel({
    required String rideId,
    required String driverName,
    required double fee,
  }) {
    _socket?.emit('driver_ride_cancel', {
      'rideId': rideId,
      'driverName': driverName,
      'fee': fee,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void emitCustomerRideCancel({
    required String rideId,
    required String customerName,
    required double fee,
  }) {
    _socket?.emit('customer_ride_cancel', {
      'rideId': rideId,
      'customerName': customerName,
      'fee': fee,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void emitRideLocationUpdate({
    required String rideId,
    required double driverX,
    required double driverY,
    required double customerX,
    required double customerY,
    required int etaMinutes,
  }) {
    _socket?.emit('ride_location_update', {
      'rideId': rideId,
      'driverX': driverX,
      'driverY': driverY,
      'customerX': customerX,
      'customerY': customerY,
      'etaMinutes': etaMinutes,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void onCustomerRideStatus(void Function(Map<String, dynamic>) handler) {
    _socket?.on('customer_ride_status', (data) {
      if (data is Map) {
        handler(Map<String, dynamic>.from(data));
      }
    });
  }

  void onDriverRideRequest(void Function(Map<String, dynamic>) handler) {
    _socket?.on('driver_ride_request', (data) {
      if (data is Map) {
        handler(Map<String, dynamic>.from(data));
      }
    });
  }

  void onRideCancelled(void Function(Map<String, dynamic>) handler) {
    _socket?.on('ride_cancelled', (data) {
      if (data is Map) {
        handler(Map<String, dynamic>.from(data));
      }
    });
  }

  void onRideLocationUpdate(void Function(Map<String, dynamic>) handler) {
    _socket?.on('ride_location_update', (data) {
      if (data is Map) {
        handler(Map<String, dynamic>.from(data));
      }
    });
  }

  void dispose() {
    _socket?.dispose();
    _socket = null;
  }
}
