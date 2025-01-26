import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  // Função para buscar dados de 5 Ministérios
  Future<List<Map<String, dynamic>>> _fetchResults(String endpoint) async {
    final response = await http.get(Uri.parse('http://localhost:8080/$endpoint'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load $endpoint results');
    }
  }

  Future<Map<String, List<Map<String, dynamic>>>> _fetchAllResults() async {
    return {
      'fiveMinistries': await _fetchResults('five_ministries'),
      'fruitOfTheSpirit': await _fetchResults('fruit_of_the_spirit'),
      'intimacyLevel': await _fetchResults('intimacy_level'),
      'spiritualGifts': await _fetchResults('spiritual_gifts'),
    };
  }

  String _getIntimacyLevelMessage(int totalScore) {
    if (totalScore <= 15) return "Multidão: Você está começando sua jornada.";
    if (totalScore <= 25) return "Os 70: Você está se comprometendo mais com Jesus.";
    if (totalScore <= 35) return "Os 12: Você está crescendo no discipulado e serviço.";
    if (totalScore <= 45) return "Os 3: Você tem um relacionamento próximo e profundo.";
    return "O 1: Você vive em íntima comunhão com Jesus.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
        future: _fetchAllResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum resultado encontrado'));
          } else {
            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection('Resultados dos 5 Ministérios', data['fiveMinistries']!, [
                      'apostolic', 'prophetic', 'evangelistic', 'pastoral', 'teaching'
                    ]),
                    const SizedBox(height: 16),
                    _buildSection('Resultados dos Frutos do Espírito', data['fruitOfTheSpirit']!, [
                      'love', 'joy', 'peace', 'patience', 'kindness', 'goodness', 'faithfulness', 'gentleness', 'self_control'
                    ]),
                    const SizedBox(height: 16),
                    _buildSection('Resultados dos Níveis de Intimidade', data['intimacyLevel']!, [
                      'mission', 'sharing', 'prayer', 'bible', 'challenges', 'support', 'relationship', 'heart', 'total_score'
                    ], showMessage: true),
                    const SizedBox(height: 16),
                    _buildSection('Resultados dos Dons Espirituais', data['spiritualGifts']!, [
                      'prophecy', 'discernment', 'tongues', 'interpretation', 'wisdom', 'knowledge', 'faith', 'healing', 'miracles'
                    ]),
                    const SizedBox(height: 16),
                    _buildCharts(data),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> results, List<String> fields, {bool showMessage = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ...results.map((result) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('Usuário ${result['user_id']}'),
                subtitle: Text(fields.map((field) => '$field: ${result[field]}').join(', ')),
                trailing: Text(result['created_at'].toString()),
              ),
              if (showMessage && result.containsKey('total_score'))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    _getIntimacyLevelMessage(result['total_score']),
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCharts(Map<String, List<Map<String, dynamic>>> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gráficos dos Resultados', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildDonutChart('Resultados dos 5 Ministérios', data['fiveMinistries']!, [
          'apostolic', 'prophetic', 'evangelistic', 'pastoral', 'teaching'
        ]),
        _buildDonutChart('Resultados dos Frutos do Espírito', data['fruitOfTheSpirit']!, [
          'love', 'joy', 'peace', 'patience', 'kindness', 'goodness', 'faithfulness', 'gentleness', 'self_control'
        ]),
        _buildDonutChart('Resultados dos Níveis de Intimidade', data['intimacyLevel']!, [
                      'mission', 'sharing', 'prayer', 'bible', 'challenges', 'support', 'relationship', 'heart',
                    ]),
        _buildDonutChart('Resultados dos Dons Espirituais', data['spiritualGifts']!, [
          'prophecy', 'discernment', 'tongues', 'interpretation', 'wisdom', 'knowledge', 'faith', 'healing', 'miracles'
        ]),
      ],
    );
  }

  Widget _buildDonutChart(String title, List<Map<String, dynamic>> data, List<String> fields) {
    // Lista de cores para as fatias
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
      Colors.cyan,
      Colors.pink,
      Colors.teal,
    ];

    List<PieChartSectionData> sections = fields.asMap().entries.map((entry) {
      int index = entry.key;
      String field = entry.value;

      double total = data.fold(0, (sum, item) => sum + (item[field] ?? 0));

      return PieChartSectionData(
        value: total,
        title: field,
        radius: 60,
        color: colors[index % colors.length], // Atribui cores ciclicamente
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      );
    }).toList();

    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
