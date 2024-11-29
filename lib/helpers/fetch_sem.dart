import 'package:euc_grading_system/classes/sem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Sem> fetchSem(int user_id) async {
  var url = "https://grade-management-sys-api-euc.onrender.com/student/semester/${user_id}";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Sem.fromJson(jsonDecode(response.body) as List);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load sem. (fetch sem)');
  }
}
