import 'package:mysql1/mysql1.dart';

class AuthService {
  final ConnectionSettings settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'SUA_SENHA_AQUI',
    db: 'crescimento',
  );

  Future<bool> register(String name, String email, String password) async {
    final conn = await MySqlConnection.connect(settings);
    try {
      var result = await conn.query(
        'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
        [name, email, password],
      );
      return result.affectedRows! > 0;
    } catch (e) {
      print('Erro ao registrar usuário: $e');
      return false;
    } finally {
      await conn.close();
    }
  }

  Future<bool> login(String email, String password) async {
    final conn = await MySqlConnection.connect(settings);
    try {
      var results = await conn.query(
        'SELECT * FROM users WHERE email = ? AND password = ?',
        [email, password],
      );
      return results.isNotEmpty;
    } catch (e) {
      print('Erro ao fazer login: $e');
      return false;
    } finally {
      await conn.close();
    }
  }
}