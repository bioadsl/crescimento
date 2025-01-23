import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:mysql1/mysql1.dart';

// Middleware CORS (definido apenas uma vez)
Middleware handleCors() {
  return (Handler innerHandler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type, Authorization',
        });
      }

      Response response = await innerHandler(request);

      return response.change(headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      });
    };
  };
}

// Configurações do banco de dados
final dbSettings = ConnectionSettings(
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: 'SUA_SENHA_AQUI',
  db: 'crescimento',
);

class ApiService {
  Future<MySqlConnection> _getConnection() async {
    return MySqlConnection.connect(dbSettings);
  }

  Response _internalServerError(String message) {
    return Response.internalServerError(
      body: jsonEncode({'error': message}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
extension UserMethods on ApiService {
  Future<Response> registerUser(Request request) async {
    MySqlConnection? conn;
    try {
      final data = jsonDecode(await request.readAsString());
      conn = await _getConnection();

      await conn.query(
        'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
        [data['name'], data['email'], data['password']], // Substituir por hash no futuro
      );

      return Response.ok(
        jsonEncode({'message': 'User registered successfully'}),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return _internalServerError(e.toString());
    } finally {
      await conn?.close();
    }
  }

  Future<Response> loginUser(Request request) async {
    MySqlConnection? conn;
    try {
      final data = jsonDecode(await request.readAsString());
      conn = await _getConnection();

      final results = await conn.query(
        'SELECT * FROM users WHERE email = ? AND password = ?',
        [data['email'], data['password']],
      );

      if (results.isNotEmpty) {
        return Response.ok(
          jsonEncode({'message': 'Login successful'}),
          headers: {'Content-Type': 'application/json'},
        );
      } else {
        return Response.forbidden(
          jsonEncode({'error': 'Invalid credentials'}),
          headers: {'Content-Type': 'application/json'},
        );
      }
    } catch (e) {
      return _internalServerError(e.toString());
    } finally {
      await conn?.close();
    }
  }
}
extension ResultsMethods on ApiService {
  Future<Response> insertResult(Request request, String table, List<String> fields) async {
    MySqlConnection? conn;
    try {
      final data = jsonDecode(await request.readAsString());
      conn = await _getConnection();

      final placeholders = List.generate(fields.length, (_) => '?').join(', ');
      final query = 'INSERT INTO $table (${fields.join(', ')}) VALUES ($placeholders)';

      await conn.query(query, fields.map((field) => data[field]).toList());

      return Response.ok(
        jsonEncode({'message': 'Result added successfully'}),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return _internalServerError(e.toString());
    } finally {
      await conn?.close();
    }
  }

Future<Response> getResults(String table) async {
  MySqlConnection? conn;
  try {
    print("Fetching results from table: $table");
    conn = await _getConnection();
    final results = await conn.query('SELECT * FROM $table');
    
    print("Fetched ${results.length} records."); // Log number of records fetched
    
    final data = results
        .map((result) => result.fields.map((key, value) => MapEntry(key, value)).cast<String, dynamic>())
        .toList();

    return Response.ok(
      jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    print("Error fetching data: $e"); // Log the error
    return _internalServerError(e.toString());
  } finally {
    await conn?.close();
  }
}


void main() async {
  final apiService = ApiService();
  final router = Router();

  // Rotas de usuários
  router.post('/users/register', apiService.registerUser);
  router.post('/users/login', apiService.loginUser);

  // Rotas de resultados genéricos
  router.post('/five_ministries', (req) => apiService.insertResult(req, 'five_ministries_results', [
        'user_id', 'apostolic', 'prophetic', 'evangelistic', 'pastoral', 'teaching'
      ]));
  router.get('/five_ministries_results', (_) => apiService.getResults('five_ministries_results'));

  router.post('/fruit_of_the_spirit', (req) => apiService.insertResult(req, 'fruit_of_the_spirit_results', [
        'user_id', 'love', 'joy', 'peace', 'patience', 'kindness', 'goodness', 'faithfulness', 'gentleness', 'self_control'
      ]));
  router.get('/fruit_of_the_spirit', (_) => apiService.getResults('fruit_of_the_spirit_results'));
  print('Received request for /fruit_of_the_spirit_results'); // Log when the route is accessed



  // Mais rotas podem ser adicionadas aqui

  // Configuração do pipeline
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      .addHandler(router.call);

  // Inicialização do servidor
  await io.serve(handler, 'localhost', 8080);
  print('Server running on http://localhost:8080');
}