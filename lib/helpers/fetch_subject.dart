import 'package:euc_grading_system/classes/subject.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Subject> fetchSubject(int user_id, int semId) async {
  var url = "https://grade-management-sys-api-euc.onrender.com/subject/grade/${user_id}/${semId}";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Subject.fromJson(jsonDecode(response.body) as List);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load subject. (fetch subject)');
  }
}
