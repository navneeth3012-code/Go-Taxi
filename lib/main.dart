import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
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

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Dashboard'),
        backgroundColor: const Color(0xFF203A43),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SizedBox(
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
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF3E7),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -10,
                  right: -10,
                  child: Icon(
                    Icons.toys,
                    size: 120,
                    color: Colors.orange.withValues(alpha: 0.18),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.directions_car_filled,
                        size: 40,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Searching for a driver',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Hang tight, matching you with the best ride.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookingConfirmationScreen(
          pickup: _pickup,
          drop: _drop,
          rideType: _rideType,
          totalFare: _totalFare(),
        ),
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

class DriverPage extends StatelessWidget {
  const DriverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Driver Page'),
      ),
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







