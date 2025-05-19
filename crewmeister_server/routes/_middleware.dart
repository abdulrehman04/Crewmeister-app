import 'package:dart_frog/dart_frog.dart';

import '../middleware/cors_middleware.dart'; // Import your CORS middleware

/// Apply global middleware to all routes
Handler middleware(Handler handler) {
  // Apply the CORS middleware to all routes
  return handler.use(corsMiddleware());
}
