import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  factory DatabaseHelper() => instance;
  MySqlConnection? _connection;

  DatabaseHelper._internal();

  Future<MySqlConnection> get connection async {
    if (_connection != null) return _connection!;
    _connection = await _initConnection();
    return _connection!;
  }

  Future<MySqlConnection> _initConnection() async {
    final settings = ConnectionSettings(
      host: 'localhost', // Substitua pelo host do seu banco de dados
      port: 3306,
      user: 'root', // Substitua pelo usuário do seu banco de dados
      password: 'SUA_SENHA_AQUI', // Substitua pela senha do seu banco de dados
      db: 'crescimento', // Substitua pelo nome do seu banco de dados
    );
    return await MySqlConnection.connect(settings);
  }

  Future<void> createTables() async {
    final conn = await connection;
    await conn.query('''
      CREATE TABLE IF NOT EXISTS five_ministries_results (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        apostolic INT NOT NULL,
        prophetic INT NOT NULL,
        evangelistic INT NOT NULL,
        pastoral INT NOT NULL,
        teaching INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    await conn.query('''
      CREATE TABLE IF NOT EXISTS fruit_of_the_spirit_results (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        love INT NOT NULL,
        joy INT NOT NULL,
        peace INT NOT NULL,
        patience INT NOT NULL,
        kindness INT NOT NULL,
        goodness INT NOT NULL,
        faithfulness INT NOT NULL,
        gentleness INT NOT NULL,
        self_control INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    await conn.query('''
      CREATE TABLE IF NOT EXISTS intimacy_level_results (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        mission INT NOT NULL,
        sharing INT NOT NULL,
        prayer INT NOT NULL,
        bible INT NOT NULL,
        challenges INT NOT NULL,
        support INT NOT NULL,
        relationship INT NOT NULL,
        heart INT NOT NULL,
        total_score INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    await conn.query('''
      CREATE TABLE IF NOT EXISTS spiritual_gifts_results (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        prophecy INT NOT NULL,
        discernment INT NOT NULL,
        tongues INT NOT NULL,
        interpretation INT NOT NULL,
        wisdom INT NOT NULL,
        knowledge INT NOT NULL,
        faith INT NOT NULL,
        healing INT NOT NULL,
        miracles INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    await conn.query('''
      CREATE TABLE IF NOT EXISTS spiritual_disciplines_results (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        prayer INT NOT NULL,
        bibleReading INT NOT NULL,
        fasting INT NOT NULL,
        meditation INT NOT NULL,
        worship INT NOT NULL,
        fellowship INT NOT NULL,
        service INT NOT NULL,
        silence INT NOT NULL,
        generosity INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  Future<void> insertFiveMinistriesResult(Map<String, dynamic> result) async {
    final conn = await connection;
    await conn.query('''
      INSERT INTO five_ministries_results (user_id, apostolic, prophetic, evangelistic, pastoral, teaching)
      VALUES (?, ?, ?, ?, ?, ?)
    ''', [
      result['user_id'],
      result['apostolic'],
      result['prophetic'],
      result['evangelistic'],
      result['pastoral'],
      result['teaching']
    ]);
  }

  Future<List<Map<String, dynamic>>> getFiveMinistriesResults() async {
    final conn = await connection;
    final results = await conn.query('SELECT * FROM five_ministries_results');
    return results.map((row) => row.fields).toList();
  }

  Future<void> insertFruitOfTheSpiritResult(Map<String, dynamic> result) async {
    final conn = await connection;
    await conn.query('''
      INSERT INTO fruit_of_the_spirit_results (user_id, love, joy, peace, patience, kindness, goodness, faithfulness, gentleness, self_control)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      result['user_id'],
      result['love'],
      result['joy'],
      result['peace'],
      result['patience'],
      result['kindness'],
      result['goodness'],
      result['faithfulness'],
      result['gentleness'],
      result['self_control']
    ]);
  }

  Future<List<Map<String, dynamic>>> getFruitOfTheSpiritResults() async {
    final conn = await connection;
    final results = await conn.query('SELECT * FROM fruit_of_the_spirit_results');
    return results.map((row) => row.fields).toList();
  }

  Future<void> insertIntimacyLevelResult(Map<String, dynamic> result) async {
    final conn = await connection;
    await conn.query('''
      INSERT INTO intimacy_level_results (user_id, mission, sharing, prayer, bible, challenges, support, relationship, heart, total_score)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      result['user_id'],
      result['mission'],
      result['sharing'],
      result['prayer'],
      result['bible'],
      result['challenges'],
      result['support'],
      result['relationship'],
      result['heart'],
      result['total_score']
    ]);
  }

  Future<List<Map<String, dynamic>>> getIntimacyLevelResults() async {
    final conn = await connection;
    final results = await conn.query('SELECT * FROM intimacy_level_results');
    return results.map((row) => row.fields).toList();
  }

  Future<void> insertSpiritualGiftsResult(Map<String, dynamic> result) async {
    final conn = await connection;
    await conn.query('''
      INSERT INTO spiritual_gifts_results (user_id, prophecy, discernment, tongues, interpretation, wisdom, knowledge, faith, healing, miracles)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      result['user_id'],
      result['prophecy'],
      result['discernment'],
      result['tongues'],
      result['interpretation'],
      result['wisdom'],
      result['knowledge'],
      result['faith'],
      result['healing'],
      result['miracles']
    ]);
  }

  Future<List<Map<String, dynamic>>> getSpiritualGiftsResults() async {
    final conn = await connection;
    final results = await conn.query('SELECT * FROM spiritual_gifts_results');
    return results.map((row) => row.fields).toList();
  }

  Future<void> insertSpiritualDisciplinesResult(Map<String, dynamic> result) async {
    final conn = await connection;
    await conn.query('''
      INSERT INTO spiritual_disciplines_results (user_id, prayer, bibleReading, fasting, meditation, worship, fellowship, service, silence, generosity)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      result['user_id'],
      result['prayer'],
      result['bibleReading'],
      result['fasting'],
      result['meditation'],
      result['worship'],
      result['fellowship'],
      result['service'],
      result['silence'],
      result['generosity']
    ]);
  }

  Future<List<Map<String, dynamic>>> getSpiritualDisciplinesResults() async {
    final conn = await connection;
    final results = await conn.query('SELECT * FROM spiritual_disciplines_results');
    return results.map((row) => row.fields).toList();
  }
}