import 'dart:convert';
import 'package:flutter/services.dart';

const absencesPath = 'assets/json/absences.json';
const membersPath = 'assets/json/members.json';

class API {
  Future<List<dynamic>> readJsonFile(String path) async {
    String content = await rootBundle.loadString(path);
    Map<String, dynamic> data = jsonDecode(content);
    return data['payload'];
  }

  Future<List<dynamic>> absences() async {
    return await readJsonFile(absencesPath);
  }

  Future<List<dynamic>> members() async {
    return await readJsonFile(membersPath);
  }
}
