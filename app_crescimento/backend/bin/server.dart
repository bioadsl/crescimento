import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

// Configurações do banco de dados
final dbSettings = ConnectionSettings(
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: 'SUA_SENHA_AQUI',
  db: 'crescimento',
);

// Classe de serviço para APIs
class ApiService {
  Future<Response> registerUser(Request request) async {
    MySqlConnection? conn;
    try {
      final data = jsonDecode(await request.readAsString());
      conn = await MySqlConnection.connect(dbSettings);

      final result = await conn.query(
        'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
        [
          data['name'],
          data['email'],
          data['password'], // Deve usar hash no futuro
        ],
      );

      return Response.ok(jsonEncode({'message': 'User registered successfully'}),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to register user'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> loginUser(Request request) async {
    MySqlConnection? conn;
    try {
      final data = jsonDecode(await request.readAsString());
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query(
        'SELECT * FROM users WHERE email = ? AND password = ?',
        [data['email'], data['password']],
      );

      if (results.isNotEmpty) {
        return Response.ok(jsonEncode({'message': 'Login successful'}),
            headers: {'Content-Type': 'application/json'});
      } else {
        return Response.forbidden(jsonEncode({'error': 'Invalid credentials'}),
            headers: {'Content-Type': 'application/json'});
      }
    } on MySqlException catch (e) {
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to login'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }
}

// Middleware CORS (definido apenas uma vez)
Middleware handleCors() {
  return (Handler innerHandler) {
    return (Request request) async {
      // Resposta à preflight request (requisição OPTIONS)
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: {
          'Access-Control-Allow-Origin': '*', // Permite todas as origens
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type, Authorization',
        });
      }

      // Responde normalmente para as requisições de outros métodos
      Response response = await innerHandler(request);

      return response.change(headers: {
        'Access-Control-Allow-Origin': '*', // Permite todas as origens
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      });
    };
  };
}

void main() async {
  final apiService = ApiService();
  final router = Router();

  // Rota para o registro de usuário
  router.post('/users/register', apiService.registerUser);

  // Rota para o login de usuário
  router.post('/users/login', apiService.loginUser);

  // Adiciona o middleware de CORS antes do logRequests() e do handler
  final handler = const Pipeline()
      .addMiddleware(logRequests())   // Log das requisições
      .addMiddleware(handleCors())    // Middleware CORS
      .addHandler(router.call);            // Roteamento

  // Servindo a API
  await io.serve(handler, 'localhost', 8080);
  print('Server running on http://localhost:8080');
}