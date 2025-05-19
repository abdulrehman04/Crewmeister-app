import 'dart:io';
import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final file = File('data/members.json');
  final data = jsonDecode(await file.readAsString());
  final members = data['payload'];

  return Response.json(body: members);
}
