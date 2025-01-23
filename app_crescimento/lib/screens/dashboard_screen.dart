import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardScreen extends StatelessWidget {
  // Funções de obtenção de dados de várias fontes (API)
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
    final response = await http.get(Uri.parse('http://localhost:8080/fruit_of_the_spirit_results'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load fruit of the spirit results');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchIntimacyLevelResults() async {
    final response = await http.get(Uri.parse('http://localhost:8080/intimacy_level_results'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load intimacy level results');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchSpiritualGiftsResults() async {
    final response = await http.get(Uri.parse('http://localhost:8080/spiritual_gifts_results'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load spiritual gifts results');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchPillarsResults() async {
    final response = await http.get(Uri.parse('http://localhost:8080/pillars_results'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load pillars results');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchSpiritualDisciplinesResults() async {
    final response = await http.get(Uri.parse('http://localhost:8080/spiritual_disciplines_results'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load spiritual disciplines results');
    }
  }

  // Função que carrega todos os resultados
  Future<Map<String, List<Map<String, dynamic>>>> _fetchAllResults() async {
    final fiveMinistriesResults = await _fetchFiveMinistriesResults();
    final fruitOfTheSpiritResults = await _fetchFruitOfTheSpiritResults();
    final intimacyLevelResults = await _fetchIntimacyLevelResults();
    final spiritualGiftsResults = await _fetchSpiritualGiftsResults();
    final pillarsResults = await _fetchPillarsResults();
    final spiritualDisciplinesResults = await _fetchSpiritualDisciplinesResults();
    return {
      'fiveMinistries': fiveMinistriesResults,
      'fruitOfTheSpirit': fruitOfTheSpiritResults,
      'intimacyLevel': intimacyLevelResults,
      'spiritualGifts': spiritualGiftsResults,
      'pillars': pillarsResults,
      'spiritualDisciplines': spiritualDisciplinesResults,
    };
  }

  // Função de mensagem de nível de intimidade
  String _getIntimacyLevelMessage(int totalScore) {
    if (totalScore <= 15) {
      return "Multidão: Você está começando sua jornada.";
    } else if (totalScore <= 25) {
      return "Os 70: Você está se comprometendo mais com Jesus.";
    } else if (totalScore <= 35) {
      return "Os 12: Você está crescendo no discipulado e serviço.";
    } else if (totalScore <= 45) {
      return "Os 3: Você tem um relacionamento próximo e profundo.";
    } else {
      return "O 1: Você vive em íntima comunhão com Jesus.";
    }
  }

  // Função para construir gráficos
  Widget _buildCharts(
    List<Map<String, dynamic>> fiveMinistriesResults,
    List<Map<String, dynamic>> fruitOfTheSpiritResults,
    List<Map<String, dynamic>> intimacyLevelResults,
    List<Map<String, dynamic>> spiritualGiftsResults,
    List<Map<String, dynamic>> pillarsResults,
    List<Map<String, dynamic>> spiritualDisciplinesResults,
  ) {
    // Exemplo de gráfico de barras usando fl_chart
    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(y: 15, colors: [Colors.blue], width: 20),
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(y: 25, colors: [Colors.red], width: 20),
          ]),
        ],
      ),
    );
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
            final pillarsResults = snapshot.data!['pillars']!;
            final spiritualDisciplinesResults = snapshot.data!['spiritualDisciplines']!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text('Gráficos dos Resultados', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  Container(
                    height: 400,
                    child: _buildCharts(fiveMinistriesResults, fruitOfTheSpiritResults, intimacyLevelResults, spiritualGiftsResults, pillarsResults, spiritualDisciplinesResults),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}