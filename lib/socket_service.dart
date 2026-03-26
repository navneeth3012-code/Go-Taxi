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

  void onCustomerRideStatus(void Function(Map<String, dynamic>) handler) {
    _socket?.on('customer_ride_status', (data) {
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
