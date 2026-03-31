import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'socket_service.dart';

void main() {
  runApp(const MainApp());
}

String getSocketServerUrl() {
  if (kIsWeb) {
    return 'http://localhost:4000';
  }
  return 'http://10.0.2.2:4000';
}

class RideRequest {
  const RideRequest({
    required this.rideId,
    required this.customerName,
    required this.pickup,
    required this.drop,
    required this.rideType,
    required this.fare,
    required this.distanceKm,
    required this.etaMinutes,
  });

  final String rideId;
  final String customerName;
  final String pickup;
  final String drop;
  final String rideType;
  final double fare;
  final double distanceKm;
  final int etaMinutes;

  factory RideRequest.fromMap(Map<String, dynamic> data) {
    return RideRequest(
      rideId: data['rideId']?.toString() ?? 'ride_unknown',
      customerName: data['customerName']?.toString() ?? 'Customer',
      pickup: data['pickup']?.toString() ?? 'Pickup',
      drop: data['drop']?.toString() ?? 'Drop',
      rideType: data['rideType']?.toString() ?? 'Ride',
      fare: (data['fare'] as num?)?.toDouble() ?? 0,
      distanceKm: (data['distanceKm'] as num?)?.toDouble() ?? 0,
      etaMinutes: (data['etaMinutes'] as num?)?.toInt() ?? 0,
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Go Taxi',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Book rides in seconds',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 180,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 180,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RoleSelectScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.orange, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('Select Role'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xFF203A43),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Enter Mobile Number',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'e.g. 9876543210',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.orange, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.orange, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OtpScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: const Color(0xFF203A43),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: '6-digit OTP',
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.orange, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RoleSelectScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Role'),
        backgroundColor: const Color(0xFF203A43),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Choose your role',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            _RoleButton(
              label: 'Customer',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CustomerPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _RoleButton(
              label: 'Driver',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DriverPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _RoleButton(
              label: 'Admin',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  const _RoleButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  static final String _socketServerUrl = getSocketServerUrl();
  String _lastNotification = 'No ride updates yet.';

  @override
  void initState() {
    super.initState();
    final socket = SocketService.instance;
    socket.connect(serverUrl: _socketServerUrl);
    socket.onCustomerRideStatus((data) {
      final status = data['status']?.toString() ?? 'updated';
      final driverName = data['driverName']?.toString() ?? 'Driver';
      final message = 'Ride $status by $driverName';
      setState(() => _lastNotification = message);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor:
              status == 'accepted' ? Colors.green : Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
    socket.onRideCancelled((data) {
      final cancelledBy = data['cancelledBy']?.toString() ?? 'driver';
      final fee = (data['fee'] as num?)?.toDouble() ?? 0;
      final message = cancelledBy == 'driver'
          ? 'Your ride has cancelled and you can retry now.'
          : 'Customer cancelled the ride. Fee: \u20B9${fee.toStringAsFixed(0)}';
      setState(() => _lastNotification = message);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  @override
  void dispose() {
    SocketService.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Dashboard'),
        backgroundColor: const Color(0xFF203A43),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _lastNotification,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BookNowScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({super.key});

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropController = TextEditingController();

  final List<String> _mockPlaces = const [
    'City Center Mall',
    'Central Station',
    'Airport Terminal 1',
    'Airport Terminal 2',
    'Tech Park Gate 3',
    'Riverfront Park',
    'Old Town Market',
    'Metro Hub',
    'Eastside Plaza',
    'West End Hospital',
  ];

  String _rideType = 'Bike';
  String _pickup = 'Current Location';
  String _drop = 'Select Destination';

  double _distanceKm = 5;
  double _durationMin = 15;
  double _weatherFactor = 1.0;
  double _trafficFactor = 1.0;
  double _taxRate = 0.08;

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    super.dispose();
  }

  int _headCountForRide(String rideType) {
    switch (rideType) {
      case 'Bike':
        return 1;
      case 'Auto':
        return 3;
      case 'Cab':
        return 3;
      case 'SUV':
        return 6;
    }
    return 1;
  }

  double _baseFareForRide(String rideType) {
    switch (rideType) {
      case 'Bike':
        return 20;
      case 'Auto':
        return 35;
      case 'Cab':
        return 50;
      case 'SUV':
        return 70;
    }
    return 20;
  }

  double _kmRateForRide(String rideType) {
    switch (rideType) {
      case 'Bike':
        return 6;
      case 'Auto':
        return 9;
      case 'Cab':
        return 12;
      case 'SUV':
        return 16;
    }
    return 6;
  }

  double _minRateForRide(String rideType) {
    switch (rideType) {
      case 'Bike':
        return 1.5;
      case 'Auto':
        return 2.0;
      case 'Cab':
        return 2.5;
      case 'SUV':
        return 3.0;
    }
    return 1.5;
  }

  double _fareBeforeTax() {
    final base = _baseFareForRide(_rideType);
    final distanceCharge = _distanceKm * _kmRateForRide(_rideType);
    final timeCharge = _durationMin * _minRateForRide(_rideType);
    final demandMultiplier = _weatherFactor * _trafficFactor;
    return (base + distanceCharge + timeCharge) * demandMultiplier;
  }

  double _taxAmount() {
    return _fareBeforeTax() * _taxRate;
  }

  double _totalFare() {
    return _fareBeforeTax() + _taxAmount();
  }

  List<String> _filterPlaces(String query) {
    if (query.trim().isEmpty) {
      return const [];
    }
    final lower = query.toLowerCase();
    return _mockPlaces
        .where((place) => place.toLowerCase().contains(lower))
        .toList();
  }

  Future<void> _startBookingFlow() async {
    Navigator.of(context).pop();
    final rideId = 'ride_${DateTime.now().millisecondsSinceEpoch}';
    final request = RideRequest(
      rideId: rideId,
      customerName: 'Sia Sharma',
      pickup: _pickup,
      drop: _drop,
      rideType: _rideType,
      fare: _totalFare(),
      distanceKm: _distanceKm,
      etaMinutes: _durationMin.round(),
    );
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CustomerRideFlowScreen(request: request),
      ),
    );
  }

  void _showFareBreakdown() {
    showDialog<void>(
      context: context,
      builder: (context) {
        final base = _baseFareForRide(_rideType);
        final distanceCharge = _distanceKm * _kmRateForRide(_rideType);
        final timeCharge = _durationMin * _minRateForRide(_rideType);
        final demandMultiplier = _weatherFactor * _trafficFactor;
        final subtotal = _fareBeforeTax();
        final tax = _taxAmount();
        final total = _totalFare();

        return AlertDialog(
          title: const Text('Fare Breakdown'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange),
                ),
                child: Text(
                  'Estimate: \u20B9${total.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('Base fare: \u20B9${base.toStringAsFixed(2)}'),
              Text('Distance: \u20B9${distanceCharge.toStringAsFixed(2)}'),
              Text('Time: \u20B9${timeCharge.toStringAsFixed(2)}'),
              Text('Weather x Traffic: ${demandMultiplier.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              Text('Subtotal: \u20B9${subtotal.toStringAsFixed(2)}'),
              Text('Tax: \u20B9${tax.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              Text(
                'Total: \u20B9${total.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: _startBookingFlow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Book Now'),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Now'),
        backgroundColor: const Color(0xFF203A43),
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final mapHeight = constraints.maxHeight * 0.7;
          final pickupSuggestions = _filterPlaces(_pickupController.text);
          final dropSuggestions = _filterPlaces(_dropController.text);

          return Column(
            children: [
              SizedBox(
                height: mapHeight,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueGrey.shade900,
                            Colors.blueGrey.shade700,
                            Colors.blueGrey.shade500,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.my_location,
                            size: 48,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Pickup: $_pickup',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Drop: $_drop',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Mock Map View',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      top: 16,
                      child: Column(
                        children: [
                          _LocationField(
                            controller: _pickupController,
                            hintText: 'Pickup location',
                            icon: Icons.location_on,
                            color: Colors.orange,
                            onChanged: (_) => setState(() {}),
                          ),
                          if (pickupSuggestions.isNotEmpty)
                            _SuggestionCard(
                              suggestions: pickupSuggestions,
                              onTap: (value) {
                                setState(() {
                                  _pickupController.text = value;
                                  _pickup = value;
                                });
                              },
                            ),
                          const SizedBox(height: 10),
                          _LocationField(
                            controller: _dropController,
                            hintText: 'Drop location',
                            icon: Icons.flag,
                            color: Colors.greenAccent,
                            onChanged: (_) => setState(() {}),
                          ),
                          if (dropSuggestions.isNotEmpty)
                            _SuggestionCard(
                              suggestions: dropSuggestions,
                              onTap: (value) {
                                setState(() {
                                  _dropController.text = value;
                                  _drop = value;
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Ride Type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _rideType,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Bike',
                                  child: Text('Bike'),
                                ),
                                DropdownMenuItem(
                                  value: 'Auto',
                                  child: Text('Auto'),
                                ),
                                DropdownMenuItem(
                                  value: 'Cab',
                                  child: Text('Cab'),
                                ),
                                DropdownMenuItem(
                                  value: 'SUV',
                                  child: Text('SUV'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() => _rideType = value);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.orange),
                            ),
                            child: Text(
                              'Headcount: ${_headCountForRide(_rideType)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Trip Factors',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Distance: ${_distanceKm.toStringAsFixed(1)} km'),
                      Slider(
                        value: _distanceKm,
                        min: 1,
                        max: 30,
                        divisions: 29,
                        label: _distanceKm.toStringAsFixed(1),
                        onChanged: (value) {
                          setState(() => _distanceKm = value);
                        },
                      ),
                      Text('Duration: ${_durationMin.toStringAsFixed(0)} min'),
                      Slider(
                        value: _durationMin,
                        min: 5,
                        max: 90,
                        divisions: 85,
                        label: _durationMin.toStringAsFixed(0),
                        onChanged: (value) {
                          setState(() => _durationMin = value);
                        },
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<double>(
                              initialValue: _weatherFactor,
                              decoration: InputDecoration(
                                labelText: 'Weather',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 1.0,
                                  child: Text('Clear'),
                                ),
                                DropdownMenuItem(
                                  value: 1.15,
                                  child: Text('Rain'),
                                ),
                                DropdownMenuItem(
                                  value: 1.25,
                                  child: Text('Storm'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() => _weatherFactor = value);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<double>(
                              initialValue: _trafficFactor,
                              decoration: InputDecoration(
                                labelText: 'Traffic',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 1.0,
                                  child: Text('Light'),
                                ),
                                DropdownMenuItem(
                                  value: 1.2,
                                  child: Text('Moderate'),
                                ),
                                DropdownMenuItem(
                                  value: 1.4,
                                  child: Text('Heavy'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() => _trafficFactor = value);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<double>(
                              initialValue: _taxRate,
                              decoration: InputDecoration(
                                labelText: 'Tax',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 0.05,
                                  child: Text('5%'),
                                ),
                                DropdownMenuItem(
                                  value: 0.08,
                                  child: Text('8%'),
                                ),
                                DropdownMenuItem(
                                  value: 0.12,
                                  child: Text('12%'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() => _taxRate = value);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.blueGrey),
                              ),
                              child: Text(
                                'Estimate: \u20B9${_totalFare().toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _showFareBreakdown,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: Text(
                            'View Fare - \u20B9${_totalFare().toStringAsFixed(0)}',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _startBookingFlow,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: const Text('Book Now'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LocationField extends StatelessWidget {
  const _LocationField({
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.color,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final Color color;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        prefixIcon: Icon(icon, color: color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({
    required this.suggestions,
    required this.onTap,
  });

  final List<String> suggestions;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: suggestions.length.clamp(0, 4),
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final value = suggestions[index];
          return ListTile(
            dense: true,
            title: Text(value),
            onTap: () => onTap(value),
          );
        },
      ),
    );
  }
}

class CustomerRideFlowScreen extends StatefulWidget {
  const CustomerRideFlowScreen({super.key, required this.request});

  final RideRequest request;

  @override
  State<CustomerRideFlowScreen> createState() => _CustomerRideFlowScreenState();
}

class _CustomerRideFlowScreenState extends State<CustomerRideFlowScreen> {
  static final String _socketServerUrl = getSocketServerUrl();
  static const double _customerCancelFee = 35;

  String _status = 'searching';
  String _driverName = 'Driver';
  String _statusMessage = 'Searching for the best driver...';
  Offset _customerPosition = const Offset(0.78, 0.2);
  Offset _driverPosition = const Offset(0.15, 0.82);
  int _etaMinutes = 8;
  Timer? _simTimer;
  bool _hasRemoteUpdates = false;

  @override
  void initState() {
    super.initState();
    final socket = SocketService.instance;
    socket.connect(serverUrl: _socketServerUrl);
    socket.onCustomerRideStatus(_handleRideStatus);
    socket.onRideCancelled(_handleRideCancelled);
    socket.onRideLocationUpdate(_handleLocationUpdate);
    socket.emitCustomerRideRequest(
      rideId: widget.request.rideId,
      customerName: widget.request.customerName,
      pickup: widget.request.pickup,
      drop: widget.request.drop,
      rideType: widget.request.rideType,
      fare: widget.request.fare,
      distanceKm: widget.request.distanceKm,
      etaMinutes: widget.request.etaMinutes,
    );
    _etaMinutes = widget.request.etaMinutes;
    _startLocalSimulation();
  }

  void _handleRideStatus(Map<String, dynamic> data) {
    if (data['rideId']?.toString() != widget.request.rideId) return;
    final status = data['status']?.toString() ?? 'updated';
    final driverName = data['driverName']?.toString() ?? 'Driver';
    setState(() {
      _status = status;
      _driverName = driverName;
      if (status == 'accepted') {
        _statusMessage = 'Driver accepted. $_driverName is on the way.';
      } else if (status == 'rejected') {
        _statusMessage = 'No driver accepted the ride. Please retry.';
      }
    });
    if (!mounted) return;
    if (status == 'accepted') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ride accepted by $_driverName'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (status == 'rejected') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ride rejected. Please retry.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _handleRideCancelled(Map<String, dynamic> data) {
    if (data['rideId']?.toString() != widget.request.rideId) return;
    final cancelledBy = data['cancelledBy']?.toString() ?? 'driver';
    final fee = (data['fee'] as num?)?.toDouble() ?? 0;
    final message = cancelledBy == 'driver'
        ? 'Your ride has cancelled and you can retry now.'
        : 'You cancelled the ride. Fee: \u20B9${fee.toStringAsFixed(0)}';
    setState(() {
      _status = 'cancelled';
      _statusMessage = message;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleLocationUpdate(Map<String, dynamic> data) {
    if (data['rideId']?.toString() != widget.request.rideId) return;
    final driverX = (data['driverX'] as num?)?.toDouble();
    final driverY = (data['driverY'] as num?)?.toDouble();
    final customerX = (data['customerX'] as num?)?.toDouble();
    final customerY = (data['customerY'] as num?)?.toDouble();
    if (driverX == null ||
        driverY == null ||
        customerX == null ||
        customerY == null) {
      return;
    }
    setState(() {
      _hasRemoteUpdates = true;
      _driverPosition = Offset(driverX, driverY);
      _customerPosition = Offset(customerX, customerY);
      _etaMinutes = (data['etaMinutes'] as num?)?.toInt() ?? _etaMinutes;
    });
  }

  void _startLocalSimulation() {
    _simTimer?.cancel();
    _simTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _hasRemoteUpdates) return;
      if (_status != 'accepted') return;
      setState(() {
        _driverPosition = _moveTowards(
          _driverPosition,
          _customerPosition,
          0.04,
        );
        _etaMinutes = math.max(1, _etaMinutes - 1);
      });
    });
  }

  Offset _moveTowards(Offset start, Offset target, double step) {
    final dx = target.dx - start.dx;
    final dy = target.dy - start.dy;
    final distance = math.sqrt(dx * dx + dy * dy);
    if (distance == 0) return start;
    final t = math.min(1, step / distance);
    return Offset(start.dx + dx * t, start.dy + dy * t);
  }

  Future<void> _confirmCustomerCancel() async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancel ride?'),
          content: Text(
            'Cancellation fee: \u20B9${_customerCancelFee.toStringAsFixed(0)}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Keep Ride'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Cancel Ride'),
            ),
          ],
        );
      },
    );
    if (shouldCancel != true) return;
    SocketService.instance.emitCustomerRideCancel(
      rideId: widget.request.rideId,
      customerName: widget.request.customerName,
      fee: _customerCancelFee,
    );
    setState(() {
      _status = 'cancelled';
      _statusMessage = 'Your ride has cancelled and you can retry now.';
    });
  }

  @override
  void dispose() {
    _simTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAccepted = _status == 'accepted';
    final isSearching = _status == 'searching';
    final isRejected = _status == 'rejected';
    final isCancelled = _status == 'cancelled';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Ride'),
        backgroundColor: const Color(0xFF203A43),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _StatusBanner(
                  icon: isAccepted
                      ? Icons.check_circle
                      : isRejected || isCancelled
                          ? Icons.error
                          : Icons.search,
                  color: isAccepted
                      ? Colors.green
                      : isRejected || isCancelled
                          ? Colors.redAccent
                          : Colors.orange,
                  title: isAccepted
                      ? 'Ride Confirmed'
                      : isRejected
                          ? 'Ride Rejected'
                          : isCancelled
                              ? 'Ride Cancelled'
                              : 'Searching for a driver',
                  subtitle: _statusMessage,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RideMapView(
                    driverLabel: _driverName,
                    customerLabel: widget.request.customerName,
                    driverPosition: _driverPosition,
                    customerPosition: _customerPosition,
                    etaMinutes: _etaMinutes,
                    showEta: isAccepted,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    if (isAccepted) ...[
                      Row(
                        children: [
                          Expanded(
                            child: _QuickActionButton(
                              label: 'Call Driver',
                              icon: Icons.call,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Calling $_driverName...'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _QuickActionButton(
                              label: 'Message',
                              icon: Icons.message,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Opening chat...'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: _confirmCustomerCancel,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.redAccent,
                            side: const BorderSide(color: Colors.redAccent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text('Cancel Ride'),
                        ),
                      ),
                    ],
                    if (isSearching) ...[
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text('Back'),
                        ),
                      ),
                    ],
                    if (isRejected || isCancelled) ...[
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text('Retry Booking'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({
    super.key,
    required this.pickup,
    required this.drop,
    required this.rideType,
    required this.totalFare,
  });

  final String pickup;
  final String drop;
  final String rideType;
  final double totalFare;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
        backgroundColor: const Color(0xFF203A43),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green),
              ),
              child: Column(
                children: const [
                  Icon(
                    Icons.check_circle,
                    size: 44,
                    color: Colors.green,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Booking Confirmed!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Your driver is on the way.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _ConfirmRow(label: 'Pickup', value: pickup),
            _ConfirmRow(label: 'Drop', value: drop),
            _ConfirmRow(label: 'Ride', value: rideType),
            _ConfirmRow(
              label: 'Estimated Fare',
              value: '\u20B9${totalFare.toStringAsFixed(2)}',
            ),
            const Spacer(),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  const _ConfirmRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey.shade100),
      ),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class DriverRideTrackingScreen extends StatefulWidget {
  const DriverRideTrackingScreen({
    super.key,
    required this.request,
    required this.driverName,
  });

  final RideRequest request;
  final String driverName;

  @override
  State<DriverRideTrackingScreen> createState() =>
      _DriverRideTrackingScreenState();
}

class _DriverRideTrackingScreenState extends State<DriverRideTrackingScreen> {
  static const double _driverCancelFee = 40;
  Timer? _timer;
  Offset _driverPosition = const Offset(0.18, 0.82);
  final Offset _customerPosition = const Offset(0.78, 0.2);
  int _etaMinutes = 8;
  String _statusMessage = "Heading to customer pickup.";
  bool _isCancelled = false;

  @override
  void initState() {
    super.initState();
    _etaMinutes = widget.request.etaMinutes;
    SocketService.instance.onRideCancelled(_handleRideCancelled);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _isCancelled) return;
      setState(() {
        _driverPosition = _moveTowards(
          _driverPosition,
          _customerPosition,
          0.04,
        );
        _etaMinutes = math.max(1, _etaMinutes - 1);
      });
      SocketService.instance.emitRideLocationUpdate(
        rideId: widget.request.rideId,
        driverX: _driverPosition.dx,
        driverY: _driverPosition.dy,
        customerX: _customerPosition.dx,
        customerY: _customerPosition.dy,
        etaMinutes: _etaMinutes,
      );
    });
  }

  void _handleRideCancelled(Map<String, dynamic> data) {
    if (data["rideId"]?.toString() != widget.request.rideId) return;
    final cancelledBy = data["cancelledBy"]?.toString() ?? "customer";
    final fee = (data["fee"] as num?)?.toDouble() ?? 0;
    final message = cancelledBy == "customer"
        ? "Customer cancelled. Fee earned: \u20B9${fee.toStringAsFixed(0)}"
        : "You cancelled the ride.";
    setState(() {
      _isCancelled = true;
      _statusMessage = message;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Offset _moveTowards(Offset start, Offset target, double step) {
    final dx = target.dx - start.dx;
    final dy = target.dy - start.dy;
    final distance = math.sqrt(dx * dx + dy * dy);
    if (distance == 0) return start;
    final t = math.min(1, step / distance);
    return Offset(start.dx + dx * t, start.dy + dy * t);
  }

  Future<void> _confirmDriverCancel() async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Reject ride?"),
          content: Text(
            "Cancellation fee: \u20B9${_driverCancelFee.toStringAsFixed(0)}",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Keep Ride"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text("Reject Ride"),
            ),
          ],
        );
      },
    );
    if (shouldCancel != true) return;
    SocketService.instance.emitDriverRideCancel(
      rideId: widget.request.rideId,
      driverName: widget.driverName,
      fee: _driverCancelFee,
    );
    setState(() {
      _isCancelled = true;
      _statusMessage = "You rejected the ride. Customer notified.";
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Ride"),
        backgroundColor: const Color(0xFF203A43),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _StatusBanner(
                  icon: _isCancelled ? Icons.error : Icons.directions_car,
                  color: _isCancelled ? Colors.redAccent : Colors.green,
                  title: _isCancelled ? "Ride Cancelled" : "On the Way",
                  subtitle: _statusMessage,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RideMapView(
                    driverLabel: widget.driverName,
                    customerLabel: widget.request.customerName,
                    driverPosition: _driverPosition,
                    customerPosition: _customerPosition,
                    etaMinutes: _etaMinutes,
                    showEta: !_isCancelled,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _QuickActionButton(
                            label: "Call Customer",
                            icon: Icons.call,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Calling ${widget.request.customerName}...",
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _QuickActionButton(
                            label: "Message",
                            icon: Icons.message,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Opening chat..."),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: _isCancelled ? null : _confirmDriverCancel,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.redAccent),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text("Reject Ride"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RideMapView extends StatelessWidget {
  const RideMapView({
    super.key,
    required this.driverLabel,
    required this.customerLabel,
    required this.driverPosition,
    required this.customerPosition,
    required this.etaMinutes,
    required this.showEta,
  });

  final String driverLabel;
  final String customerLabel;
  final Offset driverPosition;
  final Offset customerPosition;
  final int etaMinutes;
  final bool showEta;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final driverLeft = driverPosition.dx * (width - 40);
        final driverTop = driverPosition.dy * (height - 40);
        final customerLeft = customerPosition.dx * (width - 40);
        final customerTop = customerPosition.dy * (height - 40);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: [
                Colors.blueGrey.shade900,
                Colors.blueGrey.shade700,
                Colors.blueGrey.shade500,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    showEta ? "ETA $etaMinutes min" : "Awaiting updates",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: customerLeft,
                top: customerTop,
                child: _MapMarker(
                  label: customerLabel,
                  color: Colors.orange,
                  icon: Icons.person_pin_circle,
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                left: driverLeft,
                top: driverTop,
                child: _MapMarker(
                  label: driverLabel,
                  color: Colors.greenAccent,
                  icon: Icons.local_taxi,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MapMarker extends StatelessWidget {
  const _MapMarker({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 32),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}
class DriverPage extends StatefulWidget {
  const DriverPage({super.key});

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  static final String _socketServerUrl = getSocketServerUrl();
  bool _hasIncomingRequest = false;
  RideRequest? _incomingRequest;
  String _lastAction = 'Waiting for a ride request';
  final String _driverName = 'Arun';

  @override
  void initState() {
    super.initState();
    final socket = SocketService.instance;
    socket.connect(serverUrl: _socketServerUrl);
    socket.emitDriverReady();
    socket.onDriverRideRequest((data) {
      final request = RideRequest.fromMap(data);
      setState(() {
        _incomingRequest = request;
        _hasIncomingRequest = true;
        _lastAction = 'New ride request from ${request.customerName}.';
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incoming ride for ${request.customerName}'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
    socket.onRideCancelled((data) {
      final cancelledBy = data['cancelledBy']?.toString() ?? 'customer';
      final fee = (data['fee'] as num?)?.toDouble() ?? 0;
      final message = cancelledBy == 'customer'
          ? 'Customer cancelled. Fee earned: \u20B9${fee.toStringAsFixed(0)}'
          : 'Driver cancelled the ride.';
      setState(() => _lastAction = message);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  void _respondToRide(bool accepted) {
    final request = _incomingRequest;
    if (request == null) return;
    SocketService.instance.emitDriverRideResponse(
      rideId: request.rideId,
      accepted: accepted,
      driverName: _driverName,
    );
    setState(() {
      _hasIncomingRequest = false;
      _lastAction = accepted
          ? 'You accepted the ride. Customer notified.'
          : 'You rejected the ride. Customer notified.';
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          accepted
              ? 'Ride accepted. Customer notified in real-time.'
              : 'Ride rejected. Customer notified in real-time.',
        ),
        backgroundColor: accepted ? Colors.green : Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );

    if (accepted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DriverRideTrackingScreen(
            request: request,
            driverName: _driverName,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    SocketService.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Dashboard'),
        backgroundColor: const Color(0xFF203A43),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.orange.withValues(alpha: 0.18),
              child: const Icon(Icons.person, color: Colors.orange),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Good afternoon, Arun',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Ready for the next ride?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StatusPill(
                      label: 'Online',
                      icon: Icons.flash_on,
                      color: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _DriverStatRow(
                  stats: const [
                    _DriverStat(
                      icon: Icons.star,
                      label: 'Rating',
                      value: '4.9',
                    ),
                    _DriverStat(
                      icon: Icons.route,
                      label: 'Trips Today',
                      value: '12',
                    ),
                    _DriverStat(
                      icon: Icons.account_balance_wallet,
                      label: 'Earnings',
                      value: '\u20B9350',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const _SectionTitle(title: 'Incoming Ride Request'),
                const SizedBox(height: 10),
                                if (_hasIncomingRequest && _incomingRequest != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.orange.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.local_taxi,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ride for ${_incomingRequest?.customerName ?? 'Customer'}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${(_incomingRequest?.distanceKm ?? 0).toStringAsFixed(1)} km away - ETA ${_incomingRequest?.etaMinutes ?? 0} min',
                                    style: const TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '\u20B9${(_incomingRequest?.fare ?? 0).toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _RidePoint(
                          label: 'Pickup',
                          value: _incomingRequest?.pickup ?? 'Pickup',
                          icon: Icons.radio_button_checked,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 8),
                        _RidePoint(
                          label: 'Drop',
                          value: _incomingRequest?.drop ?? 'Drop',
                          icon: Icons.location_on,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const _RideChip(
                              icon: Icons.people,
                              label: '2 riders',
                            ),
                            const SizedBox(width: 8),
                            _RideChip(
                              icon: Icons.timer,
                              label: '${_incomingRequest?.etaMinutes ?? 0} min',
                            ),
                            const SizedBox(width: 8),
                            _RideChip(
                              icon: Icons.local_gas_station,
                              label:
                                  '${(_incomingRequest?.distanceKm ?? 0).toStringAsFixed(1)} km',
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _respondToRide(true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                child: const Text('Accept Ride'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _respondToRide(false),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.redAccent,
                                  side: const BorderSide(color: Colors.redAccent),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                child: const Text('Reject'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.notifications_active, color: Colors.green),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _lastAction,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 22),
                const _SectionTitle(title: 'Today\'s Summary'),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: const [
                      _SummaryRow(
                        label: 'Completed trips',
                        value: '12',
                      ),
                      SizedBox(height: 10),
                      _SummaryRow(
                        label: 'Online time',
                        value: '4h 20m',
                      ),
                      SizedBox(height: 10),
                      _SummaryRow(
                        label: 'Acceptance rate',
                        value: '92%',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: const Text('Go Offline'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverStat {
  const _DriverStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

class _DriverStatRow extends StatelessWidget {
  const _DriverStatRow({required this.stats});

  final List<_DriverStat> stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats
          .map(
            (stat) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  children: [
                    Icon(stat.icon, color: Colors.orange, size: 22),
                    const SizedBox(height: 6),
                    Text(
                      stat.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      stat.label,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _RidePoint extends StatelessWidget {
  const _RidePoint({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
      ],
    );
  }
}

class _RideChip extends StatelessWidget {
  const _RideChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.blueGrey),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Admin Page'),
      ),
    );
  }
}





















