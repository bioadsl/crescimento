import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
      appBar: AppBar(title: const Text('Histórico')),
      body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
        future: _fetchAllResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum resultado encontrado'));
          }

          final data = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('5 Ministérios', data['fiveMinistries']!, [
                    'apostolic', 'prophetic', 'evangelistic', 'pastoral', 'teaching'
                  ]),
                  const SizedBox(height: 16),
                  _buildSection('Frutos do Espírito', data['fruitOfTheSpirit']!, [
                    'love', 'joy', 'peace', 'patience', 'kindness', 'goodness', 
                    'faithfulness', 'gentleness', 'self_control'
                  ]),
                  const SizedBox(height: 16),
                  _buildSection('Níveis de Intimidade', data['intimacyLevel']!, [
                    'mission', 'sharing', 'prayer', 'bible', 'challenges', 'support', 
                    'relationship', 'heart', 'total_score'
                  ], showMessage: true),
                  const SizedBox(height: 16),
                  _buildSection('Dons Espirituais', data['spiritualGifts']!, [
                    'prophecy', 'discernment', 'tongues', 'interpretation', 'wisdom', 
                    'knowledge', 'faith', 'healing', 'miracles'
                  ]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> results, List<String> fields, {bool showMessage = false}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, 
              style: const TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              )
            ),
            const Divider(),
            ...results.map((result) {
              final date = DateTime.parse(result['created_at']);
              final formattedDate = '${date.day}/${date.month}/${date.year}';
              
              return Card(
                color: Colors.grey[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Avaliação de ${formattedDate}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: fields.map((field) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            '${field.replaceAll('_', ' ').toUpperCase()}: ${result[field]}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        )).toList(),
                      ),
                    ),
                    if (showMessage && result.containsKey('total_score'))
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getIntimacyLevelMessage(result['total_score']),
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}