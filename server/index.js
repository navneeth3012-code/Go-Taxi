const http = require('http');
const { Server } = require('socket.io');

const server = http.createServer();
const rides = new Map();

function getPendingRides() {
  return Array.from(rides.values()).filter((ride) => ride.status === 'requested');
}

const io = new Server(server, {
  cors: {
    origin: '*',
  },
});

io.on('connection', (socket) => {
  console.log('Client connected:', socket.id);
  const pendingRides = getPendingRides();
  if (pendingRides.length > 0) {
    pendingRides.forEach((ride) => {
      socket.emit('driver_ride_request', ride);
    });
  }

  socket.on('customer_ride_request', (payload) => {
    console.log('Customer ride request:', payload);
    if (!payload || !payload.rideId) return;
    rides.set(payload.rideId, {
      ...payload,
      status: 'requested',
    });
    io.emit('driver_ride_request', payload);
  });

  socket.on('driver_ready', () => {
    const ridesToSend = getPendingRides();
    ridesToSend.forEach((ride) => {
      socket.emit('driver_ride_request', ride);
    });
  });

  socket.on('driver_ride_response', (payload) => {
    console.log('Driver ride response:', payload);
    if (!payload || !payload.rideId) return;
    const ride = rides.get(payload.rideId) || {};
    const accepted = Boolean(payload.accepted);
    const status = accepted ? 'accepted' : 'rejected';
    rides.set(payload.rideId, {
      ...ride,
      status,
      driverName: payload.driverName || ride.driverName,
    });
    io.emit('customer_ride_status', {
      rideId: payload.rideId,
      status,
      driverName: payload.driverName || 'Driver',
      customerName: ride.customerName || 'Customer',
      timestamp: new Date().toISOString(),
    });
  });

  socket.on('driver_ride_cancel', (payload) => {
    console.log('Driver cancelled ride:', payload);
    if (!payload || !payload.rideId) return;
    const ride = rides.get(payload.rideId) || {};
    rides.set(payload.rideId, { ...ride, status: 'driver_cancelled' });
    io.emit('ride_cancelled', {
      rideId: payload.rideId,
      cancelledBy: 'driver',
      fee: payload.fee || 0,
      driverName: payload.driverName || ride.driverName || 'Driver',
      customerName: ride.customerName || 'Customer',
      message: 'Your ride has cancelled and you can retry now.',
      timestamp: new Date().toISOString(),
    });
  });

  socket.on('customer_ride_cancel', (payload) => {
    console.log('Customer cancelled ride:', payload);
    if (!payload || !payload.rideId) return;
    const ride = rides.get(payload.rideId) || {};
    rides.set(payload.rideId, { ...ride, status: 'customer_cancelled' });
    io.emit('ride_cancelled', {
      rideId: payload.rideId,
      cancelledBy: 'customer',
      fee: payload.fee || 0,
      driverName: ride.driverName || 'Driver',
      customerName: payload.customerName || ride.customerName || 'Customer',
      message: 'Customer has cancelled the ride and you received the cancellation fee.',
      timestamp: new Date().toISOString(),
    });
  });

  socket.on('ride_location_update', (payload) => {
    if (!payload || !payload.rideId) return;
    io.emit('ride_location_update', payload);
  });

  socket.on('disconnect', () => {
    console.log('Client disconnected:', socket.id);
  });
});

const PORT = process.env.PORT || 4000;
server.listen(PORT, () => {
  console.log(`Socket server running on port ${PORT}`);
});
