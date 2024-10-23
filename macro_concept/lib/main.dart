import 'package:json/json.dart';
void main() {

 var userJson = {
   'age': 5,
   'name': 'Roger',
   'username': 'roger1337'
 };

 var user = User.fromJson(userJson);
 print(user);
 print(user.toJson());

}
@JsonCodable()
class User {
 final int? age;
 final String name;
 final String username;
}