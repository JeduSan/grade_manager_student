import 'package:euc_grading_system/classes/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Login> loginStudent(String input_type, String password) async {
  // var url = 'http://localhost:3000/login';
  var url = 'https://grade-management-sys-api-euc.onrender.com/login';
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'input_type': input_type,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Login.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('These credentials does not match any of our records!');
  }
}
