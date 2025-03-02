import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:mysql1/mysql1.dart';

// Configurações do banco de dados
final dbSettings = ConnectionSettings(
  host: 'localhost', //mysql.teleioscap.com.br
  port: 3306,
  user: 'root', //teleioscap
  password: 'SUA_SENHA_AQUI',  //teleios2025 
  db: 'crescimento', //teleioscap
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
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
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
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to login'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }


//  class ApiService {
//   // Métodos de registro e login...

  Future<Response> insertFiveMinistriesResult(Request request) async {
    MySqlConnection? conn;
    try {
      final data = jsonDecode(await request.readAsString());
      conn = await MySqlConnection.connect(dbSettings);

      final result = await conn.query(
        'INSERT INTO five_ministries_results (user_id, apostolic, prophetic, evangelistic, pastoral, teaching) VALUES (?, ?, ?, ?, ?, ?)',
        [
          data['user_id'],
          data['apostolic'],
          data['prophetic'],
          data['evangelistic'],
          data['pastoral'],
          data['teaching'],
        ],
      );

      return Response.ok(jsonEncode({'message': 'Result added successfully'}),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to add result'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> getFiveMinistriesResults(Request request) async {
    MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM five_ministries_results');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
                'id': result['id'],
                'user_id': result['user_id'],
                'apostolic': result['apostolic'],
                'prophetic': result['prophetic'],
                'evangelistic': result['evangelistic'],
                'pastoral': result['pastoral'],
                'teaching': result['teaching'],
                'created_at': result['created_at'].toString(),
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }
 
  Future<Response> getLatestFiveMinistries(Request request) async {
    MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM five_ministries_results ORDER BY created_at DESC LIMIT 1');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
                'id': result['id'],
                'user_id': result['user_id'],
                'apostolic': result['apostolic'],
                'prophetic': result['prophetic'],
                'evangelistic': result['evangelistic'],
                'pastoral': result['pastoral'],
                'teaching': result['teaching'],
                'created_at': result['created_at'].toString(),
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> insertFruitOfTheSpiritResult(Request request) async {
    MySqlConnection? conn;
    try {
      final data = jsonDecode(await request.readAsString());
      conn = await MySqlConnection.connect(dbSettings);

      final result = await conn.query(
        'INSERT INTO fruit_of_the_spirit_results (user_id, love, joy, peace, patience, kindness, goodness, faithfulness, gentleness, self_control) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          data['user_id'],
          data['love'],
          data['joy'],
          data['peace'],
          data['patience'],
          data['kindness'],
          data['goodness'],
          data['faithfulness'],
          data['gentleness'],
          data['self_control'],
        ],
      );

      return Response.ok(jsonEncode({'message': 'Result added successfully'}),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to add result'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> getFruitOfTheSpiritResults(Request request) async {
    MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM fruit_of_the_spirit_results');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
                'id': result['id'],
                'user_id': result['user_id'],
                'love': result['love'],
                'joy': result['joy'],
                'peace': result['peace'],
                'patience': result['patience'],
                'kindness': result['kindness'],
                'goodness': result['goodness'],
                'faithfulness': result['faithfulness'],
                'gentleness': result['gentleness'],
                'self_control': result['self_control'],
                'created_at': result['created_at'].toString(),
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> getLatestFruitOfTheSpirit(Request request) async {
    MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM fruit_of_the_spirit_results ORDER BY created_at DESC LIMIT 1');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
                'id': result['id'],
                'user_id': result['user_id'],
                'love': result['love'],
                'joy': result['joy'],
                'peace': result['peace'],
                'patience': result['patience'],
                'kindness': result['kindness'],
                'goodness': result['goodness'],
                'faithfulness': result['faithfulness'],
                'gentleness': result['gentleness'],
                'self_control': result['self_control'],
                'created_at': result['created_at'].toString(),
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> insertIntimacyLevelResult(Request request) async {
    MySqlConnection? conn;
    try {
      final data = jsonDecode(await request.readAsString());
      conn = await MySqlConnection.connect(dbSettings);

      final result = await conn.query(
        'INSERT INTO intimacy_level_results (user_id, mission, sharing, prayer, bible, challenges, support, relationship, heart, total_score) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          data['user_id'],
          data['mission'],
          data['sharing'],
          data['prayer'],
          data['bible'],
          data['challenges'],
          data['support'],
          data['relationship'],
          data['heart'],
          data['total_score'],
        ],
      );

      return Response.ok(jsonEncode({'message': 'Result added successfully'}),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to add result'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> getIntimacyLevelResults(Request request) async {
    MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM intimacy_level_results');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
                'id': result['id'],
                'user_id': result['user_id'],
                'mission': result['mission'],
                'sharing': result['sharing'],
                'prayer': result['prayer'],
                'bible': result['bible'],
                'challenges': result['challenges'],
                'support': result['support'],
                'relationship': result['relationship'],
                'heart': result['heart'],
                'total_score': result['total_score'],
                'created_at': result['created_at'].toString(),
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> getLatestIntimacyLevel(Request request) async {
    MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM intimacy_level_results ORDER BY created_at DESC LIMIT 1');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
                'id': result['id'],
                'user_id': result['user_id'],
                'mission': result['mission'],
                'sharing': result['sharing'],
                'prayer': result['prayer'],
                'bible': result['bible'],
                'challenges': result['challenges'],
                'support': result['support'],
                'relationship': result['relationship'],
                'heart': result['heart'],
                'total_score': result['total_score'],
                'created_at': result['created_at'].toString(),
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

// class ApiService {
//   // Métodos anteriores...

  Future<Response> insertSpiritualGiftsResult(Request request) async {
    MySqlConnection? conn;
    try {
      final data = jsonDecode(await request.readAsString());
      conn = await MySqlConnection.connect(dbSettings);

      final result = await conn.query(
        'INSERT INTO spiritual_gifts_results (user_id, prophecy, discernment, tongues, interpretation, wisdom, knowledge, faith, healing, miracles) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          data['user_id'],
          data['prophecy'],
          data['discernment'],
          data['tongues'],
          data['interpretation'],
          data['wisdom'],
          data['knowledge'],
          data['faith'],
          data['healing'],
          data['miracles'],
        ],
      );

      return Response.ok(jsonEncode({'message': 'Result added successfully'}),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to add result'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> getSpiritualGiftsResults(Request request) async {
    MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM spiritual_gifts_results');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
                'id': result['id'],
                'user_id': result['user_id'],
                'prophecy': result['prophecy'],
                'discernment': result['discernment'],
                'tongues': result['tongues'],
                'interpretation': result['interpretation'],
                'wisdom': result['wisdom'],
                'knowledge': result['knowledge'],
                'faith': result['faith'],
                'healing': result['healing'],
                'miracles': result['miracles'],
                'created_at': result['created_at'].toString(),
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> getLatestSpiritualGifts(Request request) async {
    MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM spiritual_gifts_results ORDER BY created_at DESC LIMIT 1');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
                'id': result['id'],
                'user_id': result['user_id'],
                'prophecy': result['prophecy'],
                'discernment': result['discernment'],
                'tongues': result['tongues'],
                'interpretation': result['interpretation'],
                'wisdom': result['wisdom'],
                'knowledge': result['knowledge'],
                'faith': result['faith'],
                'healing': result['healing'],
                'miracles': result['miracles'],
                'created_at': result['created_at'].toString(),
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> insertSpiritualDisciplinesResult(Request request) async {
    MySqlConnection? conn;
    try {
      final data = jsonDecode(await request.readAsString());
      conn = await MySqlConnection.connect(dbSettings);

      final result = await conn.query(
        'INSERT INTO spiritual_disciplines_results (user_id, prayer, bibleReading, fasting, meditation, worship, fellowship, service, silence, generosity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          data['user_id'],
          data['prayer'],
          data['bibleReading'],
          data['fasting'],
          data['meditation'],
          data['worship'],
          data['fellowship'],
          data['service'],
          data['silence'],
          data['generosity'],
        ],
      );

      return Response.ok(jsonEncode({'message': 'Result added successfully'}),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to add result'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> getSpiritualDisciplinesResults(Request request) async {
    MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM spiritual_disciplines_results');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
                'id': result['id'],
                'user_id': result['user_id'],
                'prayer': result['prayer'],
                'bibleReading': result['bibleReading'],
                'fasting': result['fasting'],
                'meditation': result['meditation'],
                'worship': result['worship'],
                'fellowship': result['fellowship'],
                'service': result['service'],
                'silence': result['silence'],
                'generosity': result['generosity'],
                'created_at': result['created_at'].toString(),
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  
 Future<Response> getLatestSpiritualDisciplines(Request request) async {
    MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM spiritual_disciplines_results ORDER BY created_at DESC LIMIT 1');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
                'id': result['id'],
                'user_id': result['user_id'],
                'prayer': result['prayer'],
                'bibleReading': result['bibleReading'],
                'fasting': result['fasting'],
                'meditation': result['meditation'],
                'worship': result['worship'],
                'fellowship': result['fellowship'],
                'service': result['service'],
                'silence': result['silence'],
                'generosity': result['generosity'],
                'created_at': result['created_at'].toString(),
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }


  Future<Response> insertPillarsResult(Request request) async {
    MySqlConnection? conn;
    try {
      final data = jsonDecode(await request.readAsString());
      conn = await MySqlConnection.connect(dbSettings);

      final result = await conn.query(
        'INSERT INTO pillars_results (user_id, missions, teaching, worship, discipleship) VALUES (?, ?, ?, ?, ?)',
        [
          data['user_id'],
          data['missions'],
          data['teaching'],
          data['worship'],
          data['discipleship'],
        ],
      );

      return Response.ok(jsonEncode({'message': 'Result added successfully'}),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to add result'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> getPillarsResults(Request request) async {
   MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM pillars_results');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
            'id': result['id'],
            'user_id': result['user_id'],
            'missions': result['missions'],
            'teaching': result['teaching'],
            'discipleship': result['discipleship'],
            'worship': result['worship'],
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
          headers: {'Content-Type': 'application/json'});
    } finally {
      await conn?.close();
    }
  }

  Future<Response> getLatestPillars(Request request) async {
   MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(dbSettings);

      final results = await conn.query('SELECT * FROM pillars_results ORDER BY created_at DESC LIMIT 1');

      final List<Map<String, dynamic>> data = results
          .map((result) => {
            'id': result['id'],
            'user_id': result['user_id'],
            'missions': result['missions'],
            'teaching': result['teaching'],
            'discipleship': result['discipleship'],
            'worship': result['worship'],
              })
          .toList();

      return Response.ok(jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
    } on MySqlException catch (e) {
      print('MySqlException: ${e.message}');
      return Response.internalServerError(
          body: jsonEncode({'error': e.message}),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Exception: $e');
      return Response.internalServerError(
          body: jsonEncode({'error': 'Failed to fetch results'}),
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

      // Adicionando os cabeçalhos CORS em todas as respostas
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

  // Rota de usuário
  router.post('/users/register', apiService.registerUser);
  router.post('/users/login', apiService.loginUser);

  // Rota para inserir resultados dos 5 ministérios
  router.post('/five_ministries', apiService.insertFiveMinistriesResult);
  router.get('/five_ministries', apiService.getFiveMinistriesResults);


  // Rota para inserir resultados dos frutos do Espírito
  router.post('/fruit_of_the_spirit', apiService.insertFruitOfTheSpiritResult);
  router.get('/fruit_of_the_spirit', apiService.getFruitOfTheSpiritResults);


  // Rota para inserir resultados dos níveis de intimidade
  router.post('/intimacy_level', apiService.insertIntimacyLevelResult);
  router.get('/intimacy_level', apiService.getIntimacyLevelResults);


  // Rota para inserir resultados dos dons espirituais
  router.post('/spiritual_gifts', apiService.insertSpiritualGiftsResult);
  router.get('/spiritual_gifts', apiService.getSpiritualGiftsResults);


  // Rota para inserir resultados das disciplinas espirituais
  router.post('/spiritual_disciplines', apiService.insertSpiritualDisciplinesResult);
  router.get('/spiritual_disciplines', apiService.getSpiritualDisciplinesResults);
 

  // Rota para inserir resultados dos pilares
  router.post('/pillars', apiService.insertPillarsResult);
  router.get('/pillars', apiService.getPillarsResults);


  // Update route paths to match Flutter app requests
  router.get('/spiritual-disciplines/latest', apiService.getLatestSpiritualDisciplines);
  router.get('/five-ministries/latest', apiService.getLatestFiveMinistries); 
  router.get('/fruit-of-spirit/latest', apiService.getLatestFruitOfTheSpirit);
  router.get('/pillars/latest', apiService.getLatestPillars);
  router.get('/intimacy-level/latest', apiService.getLatestIntimacyLevel);
  router.get('/spiritual-gifts/latest', apiService.getLatestSpiritualGifts);


  // Adiciona o middleware de CORS antes do logRequests() e do handler
  final handler = const Pipeline()
      .addMiddleware(logRequests())   // Log das requisições
      .addMiddleware(handleCors())    // Middleware CORS
      .addHandler(router.call);       // Roteamento

  // Servindo a API
  await io.serve(handler, 'http://localhost:3306', 3306);
  print('Server running on http://localhost:3306'); 
}
