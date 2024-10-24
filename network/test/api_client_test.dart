import 'package:test/test.dart';
import '../lib/api_client.dart';
import '../lib/json_parser.dart';

void main() {
  group('API client test', () {
    test('read', () async {
      final client = ApiClient.create();
      final url = 'https://api.github.com/users/khalekuzzamancse';

      try {
        final result = await client.readOrThrow(url);
        print(result);
        expect(result, isNotNull);
        expect(result, contains('login'));
      } catch (e) {
        fail('Exception thrown: $e');
      }
    });
    test(' read and convert to model', () async {
      final client = ApiClient.create();
      final url = 'https://api.github.com/users/khalekuzzamancse';

      try {
        final result = await client.readOrThrow(url);
        final parser = JsonParser.create<_User>();
        final user = parser.parseOrThrow(result, _User.fromJson);

        print('$user');

        expect(result, isNotNull);
        expect(result, contains('login'));
      } catch (e) {
        fail('Exception thrown: $e');
      }
    });
    test('read and parse using ApiClient', () async {
      final client = ApiClient.create();
      final url = 'https://api.github.com/users/khalekuzzamancse';

      try {
        final user = await client.readParseOrThrow<_User>(url, _User.fromJson);
        print('$user');

        expect(user, isNotNull);
        expect(user.login,
            contains('khalekuzzamancse')); 
      } catch (e) {
        fail('Exception thrown: $e');
      }
    });
  });
}

class _User {
  final String login;
  final int id;
  final String? name;

  _User({required this.login, required this.id, this.name});

  factory _User.fromJson(Map<String, dynamic> json) {
    return _User(login: json['login'], id: json['id'], name: json['name']);
  }

  @override
  String toString() {
    return 'User(login: $login, id: $id, name: ${name ?? "N/A"})';
  }
}
