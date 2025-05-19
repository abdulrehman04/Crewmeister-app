import 'package:dart_frog/dart_frog.dart';

/// CORS middleware for Dart Frog
/// Adds CORS headers to all responses
Middleware corsMiddleware() {
  return (handler) {
    return (context) async {
      // Get response from the handler
      final response = await handler(context);

      // Return response with CORS headers
      return response.copyWith(
        headers: {
          ...response.headers,
          'Access-Control-Allow-Origin': '*', // Allow all origins
          'Access-Control-Allow-Methods':
              'GET, POST, PUT, DELETE, OPTIONS, HEAD', // Allowed methods
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, Accept, Authorization, X-Requested-With', // Allowed headers
          'Access-Control-Allow-Credentials': 'true', // Allow credentials
          'Access-Control-Max-Age':
              '86400', // Cache preflight requests for 24 hours
        },
      );
    };
  };
}
