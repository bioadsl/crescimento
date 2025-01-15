import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _fetchFiveMinistriesResults() async {
    final response = await http.get(Uri.parse('http://localhost:8080/five_ministries'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load five ministries results');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchFruitOfTheSpiritResults() async {
    final response = await http.get(Uri.parse('http://localhost:8080/fruit_of_the_spirit'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load fruit of the spirit results');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchIntimacyLevelResults() async {
    final response = await http.get(Uri.parse('http://localhost:8080/intimacy_level'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load intimacy level results');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchSpiritualGiftsResults() async {
    final response = await http.get(Uri.parse('http://localhost:8080/spiritual_gifts'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load spiritual gifts results');
    }
  }

  Future<Map<String, List<Map<String, dynamic>>>> _fetchAllResults() async {
    final fiveMinistriesResults = await _fetchFiveMinistriesResults();
    final fruitOfTheSpiritResults = await _fetchFruitOfTheSpiritResults();
    final intimacyLevelResults = await _fetchIntimacyLevelResults();
    final spiritualGiftsResults = await _fetchSpiritualGiftsResults();
    return {
      'fiveMinistries': fiveMinistriesResults,
      'fruitOfTheSpirit': fruitOfTheSpiritResults,
      'intimacyLevel': intimacyLevelResults,
      'spiritualGifts': spiritualGiftsResults,
    };
  }

  String _getIntimacyLevelMessage(int totalScore) {
    if (totalScore <= 15) {
      return "Multidão: Você está começando sua jornada.";
    } else if (totalScore <= 25) {
      return "Os 70 : Você está se comprometendo mais com Jesus.";
    } else if (totalScore <= 35) {
      return "Os 12 : Você está crescendo no discipulado e serviço.";
    } else if (totalScore <= 45) {
      return "Os 3 : Você tem um relacionamento próximo e profundo.";
    } else {
      return "O 1 : Você vive em íntima comunhão com Jesus.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
        future: _fetchAllResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum resultado encontrado'));
          } else {
            final fiveMinistriesResults = snapshot.data!['fiveMinistries']!;
            final fruitOfTheSpiritResults = snapshot.data!['fruitOfTheSpirit']!;
            final intimacyLevelResults = snapshot.data!['intimacyLevel']!;
            final spiritualGiftsResults = snapshot.data!['spiritualGifts']!;
            return ListView(
              children: [
                Text('Resultados dos 5 Ministérios', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ...fiveMinistriesResults.map((result) {
                  return ListTile(
                    title: Text('Usuário ${result['user_id']}'),
                    subtitle: Text(
                      'Apostólico: ${result['apostolic']}, '
                      'Profético: ${result['prophetic']}, '
                      'Evangelístico: ${result['evangelistic']}, '
                      'Pastoral: ${result['pastoral']}, '
                      'Ensino: ${result['teaching']}',
                    ),
                    trailing: Text(result['created_at'].toString()),
                  );
                }).toList(),
                SizedBox(height: 16),
                Text('Resultados dos Frutos do Espírito', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ...fruitOfTheSpiritResults.map((result) {
                  return ListTile(
                    title: Text('Usuário ${result['user_id']}'),
                    subtitle: Text(
                      'Amor: ${result['love']}, '
                      'Alegria: ${result['joy']}, '
                      'Paz: ${result['peace']}, '
                      'Paciência: ${result['patience']}, '
                      'Bondade: ${result['kindness']}, '
                      'Benignidade: ${result['goodness']}, '
                      'Fidelidade: ${result['faithfulness']}, '
                      'Mansidão: ${result['gentleness']}, '
                      'Domínio Próprio: ${result['self_control']}',
                    ),
                    trailing: Text(result['created_at'].toString()),
                  );
                }).toList(),
                SizedBox(height: 16),
                Text('Resultados dos Níveis de Intimidade', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ...intimacyLevelResults.map((result) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text('Usuário ${result['user_id']}'),
                        subtitle: Text(
                          'Missão: ${result['mission']}, '
                          'Compartilhamento: ${result['sharing']}, '
                          'Oração: ${result['prayer']}, '
                          'Bíblia: ${result['bible']}, '
                          'Desafios: ${result['challenges']}, '
                          'Apoio: ${result['support']}, '
                          'Relacionamento: ${result['relationship']}, '
                          'Coração: ${result['heart']}, '
                          'Pontuação Total: ${result['total_score']}',
                        ),
                        trailing: Text(result['created_at'].toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          _getIntimacyLevelMessage(result['total_score']),
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                SizedBox(height: 16),
                Text('Resultados dos Dons Espirituais', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ...spiritualGiftsResults.map((result) {
                  return ListTile(
                    title: Text('Usuário ${result['user_id']}'),
                    subtitle: Text(
                      'Profecia: ${result['prophecy']}, '
                      'Discernimento de Espíritos: ${result['discernment']}, '
                      'Variedade de Línguas: ${result['tongues']}, '
                      'Interpretação de Línguas: ${result['interpretation']}, '
                      'Sabedoria: ${result['wisdom']}, '
                      'Conhecimento: ${result['knowledge']}, '
                      'Fé: ${result['faith']}, '
                      'Cura: ${result['healing']}, '
                      'Milagres: ${result['miracles']}',
                    ),
                    trailing: Text(result['created_at'].toString()),
                  );
                }).toList(),
                SizedBox(height: 16),
                Text('Gráficos dos Resultados', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Container(
                  height: 400,
                  child: _buildCharts(fiveMinistriesResults, fruitOfTheSpiritResults, intimacyLevelResults, spiritualGiftsResults),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildCharts(List<Map<String, dynamic>> fiveMinistriesResults, List<Map<String, dynamic>> fruitOfTheSpiritResults, List<Map<String, dynamic>> intimacyLevelResults, List<Map<String, dynamic>> spiritualGiftsResults) {
    return Column(
      children: [
        _buildDonutChart(
          'Resultados dos 5 Ministérios',
          fiveMinistriesResults,
          ['apostolic', 'prophetic', 'evangelistic', 'pastoral', 'teaching'],
        ),
        _buildDonutChart(
          'Resultados dos Frutos do Espírito',
          fruitOfTheSpiritResults,
          ['love', 'joy', 'peace', 'patience', 'kindness', 'goodness', 'faithfulness', 'gentleness', 'self_control'],
        ),
        _buildDonutChart(
          'Resultados dos Níveis de Intimidade',
          intimacyLevelResults,
          ['total_score'],
        ),
        _buildDonutChart(
          'Resultados dos Dons Espirituais',
          spiritualGiftsResults,
          ['prophecy', 'discernment', 'tongues', 'interpretation', 'wisdom', 'knowledge', 'faith', 'healing', 'miracles'],
        ),
      ],
    );
  }

  Widget _buildDonutChart(String title, List<Map<String, dynamic>> data, List<String> fields) {
    List<PieChartSectionData> sections = fields.map((field) {
      double total = data.fold(0, (sum, item) => sum + item[field]);
      return PieChartSectionData(
        value: total,
        title: field,
        radius: 60,
        titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      );
    }).toList();

    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 40,
              sectionsSpace: 2,
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }
}