import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  //fetchUser();
 
}



class User {
  final String login;
  final int id;

  static Map<String, dynamic> toJson() {
    return {
      'loign': "khaleka",
      'id': 12345,
    };
  }

  User({required this.login, required this.id});

  // Manually create a factory method to map JSON to the User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'], // Map the 'login' field
      id: json['id'], // Map the 'id' field
    );
  }
}

Future<void> fetchUser() async {
  var url = Uri.parse('https://api.github.com/users/khalekuzzamancse');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    var user = User.fromJson(jsonResponse);
    print('Username: ${user.login}, ID: ${user.id}');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

