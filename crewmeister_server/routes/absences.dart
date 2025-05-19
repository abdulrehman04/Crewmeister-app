import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final file = File('data/absences.json');
  final data = jsonDecode(await file.readAsString());
  final absences = data['payload'];

  return Response.json(body: absences);
}
