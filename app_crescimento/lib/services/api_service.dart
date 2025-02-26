import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/assessment.dart';

class ApiService {
  static const String baseUrl = 'http://mysql.teleioscap.com.br:3306';

  Future<Map<AssessmentType, Assessment>> fetchLatestAssessments() async {
    try {
      Map<AssessmentType, Assessment> results = {};
      final client = http.Client();

      try {
        for (var type in AssessmentType.values) {
          final endpoint = Assessment.getEndpoint(type);
          print('Tentando acessar: $baseUrl/$endpoint/latest');
          
          final response = await client.get(
            Uri.parse('$baseUrl/$endpoint/latest'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ).timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('A conexão expirou');
            },
          );

          if (response.statusCode == 200) {
            final List<dynamic> jsonArray = json.decode(response.body);
            if (jsonArray.isNotEmpty) {
              final data = jsonArray.first;
              final Map<String, double> scores = _extractScores(type, data);
              
              results[type] = Assessment(
                type: type,
                scores: scores,
                createdAt: DateTime.parse(data['created_at'] ?? DateTime.now().toIso8601String()),
                userId: data['user_id']?.toString() ?? '0',
                totalScore: data['total_score'] as int?,
              );
            }
          } else {
            print('Erro ao buscar $endpoint: ${response.statusCode}');
            print('Resposta: ${response.body}');
          }
        }
      } finally {
        client.close();
      }

      if (results.isEmpty) {
        throw Exception('Nenhum dado encontrado no banco de dados');
      }

      return results;
    } catch (e) {
      print('Erro ao buscar avaliações: $e');
      throw Exception('Falha ao carregar dados do banco de dados: $e');
    }
  }

  Map<String, double> _extractScores(AssessmentType type, Map<String, dynamic> data) {
    switch (type) {
      case AssessmentType.spiritualGifts:
        return {
          'Profecia': _toDouble(data['prophecy']),
          'Discernimento': _toDouble(data['discernment']),
          'Línguas': _toDouble(data['tongues']),
          'Interpretação': _toDouble(data['interpretation']),
          'Sabedoria': _toDouble(data['wisdom']),
          'Conhecimento': _toDouble(data['knowledge']),
          'Fé': _toDouble(data['faith']),
          'Cura': _toDouble(data['healing']),
          'Milagres': _toDouble(data['miracles']),
        };
      
      case AssessmentType.intimacyLevel:
        return {
          'Missão': _toDouble(data['mission']),
          'Compartilhar': _toDouble(data['sharing']),
          'Oração': _toDouble(data['prayer']),
          'Bíblia': _toDouble(data['bible']),
          'Desafios': _toDouble(data['challenges']),
          'Suporte': _toDouble(data['support']),
          'Relacionamento': _toDouble(data['relationship']),
          'Coração': _toDouble(data['heart']),
        };

      case AssessmentType.pillars:
        return {
          'Missões': _toDouble(data['missions']),
          'Ensino': _toDouble(data['teaching']),
          'Discipulado': _toDouble(data['discipleship']),
          'Adoração': _toDouble(data['worship']),
        };

      case AssessmentType.fruitOfSpirit:
        return {
          'Amor': _toDouble(data['love']),
          'Alegria': _toDouble(data['joy']),
          'Paz': _toDouble(data['peace']),
          'Paciência': _toDouble(data['patience']),
          'Bondade': _toDouble(data['kindness']),
          'Benignidade': _toDouble(data['goodness']),
          'Fidelidade': _toDouble(data['faithfulness']),
          'Mansidão': _toDouble(data['gentleness']),
          'Domínio Próprio': _toDouble(data['self_control']),
        };

      case AssessmentType.fiveMinistries:
        return {
          'Apostólico': _toDouble(data['apostolic']),
          'Profético': _toDouble(data['prophetic']),
          'Evangelístico': _toDouble(data['evangelistic']),
          'Pastoral': _toDouble(data['pastoral']),
          'Ensino': _toDouble(data['teaching']),
        };

      case AssessmentType.spiritualDisciplines:
        return {
          'Oração': _toDouble(data['prayer']),
          'Jejum': _toDouble(data['fasting']),
          'Estudo': _toDouble(data['study']),
          'Meditação': _toDouble(data['meditation']),
          'Submissão': _toDouble(data['submission']),
          'Simplicidade': _toDouble(data['simplicity']),
          'Solitude': _toDouble(data['solitude']),
          'Serviço': _toDouble(data['service']),
          'Confissão': _toDouble(data['confession']),
          'Adoração': _toDouble(data['worship']),
        };
    }
  }

  double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Future<void> submitAssessment(Assessment assessment) async {
    final client = http.Client();
    try {
      final endpoint = Assessment.getEndpoint(assessment.type);
      final response = await client.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(assessment.toJson()),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode != 201) {
        throw Exception('Falha ao salvar avaliação no banco de dados');
      }
    } finally {
      client.close();
    }
  }

  void printEndpoints() {
    for (var type in AssessmentType.values) {
      print('${type.toString()}: $baseUrl/${Assessment.getEndpoint(type)}/latest');
    }
  }
}
