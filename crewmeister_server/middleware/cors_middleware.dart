import 'package:dart_frog/dart_frog.dart';

/// CORS middleware for Dart Frog
/// Adds CORS headers to all responses
Middleware corsMiddleware() {
  return (handler) {
    return (context) async {
      final response = await handler(context);

      return response.copyWith(
        headers: {
          ...response.headers,
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods':
              'GET, POST, PUT, DELETE, OPTIONS, HEAD',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, Accept, Authorization, X-Requested-With',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Max-Age': '86400',
        },
      );
    };
  };
}
