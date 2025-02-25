import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/spiritual_radar_chart.dart';
import '../models/assessment.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _apiService = ApiService();
  Map<AssessmentType, Assessment>? _cachedData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await _fetchLatestResults();
    setState(() => _isLoading = false);
  }

  Future<Map<AssessmentType, Assessment>> _fetchLatestResults() async {
    try {
      final data = await _apiService.fetchLatestAssessments();
      print('Dados recebidos: ${data.length} avaliações');
      
      data.forEach((type, assessment) {
        print('Tipo: ${assessment.typeName}');
        print('Scores: ${assessment.scores}');
        print('Data: ${assessment.createdAt}');
      });
      
      _cachedData = data;
      return data;
    } catch (e) {
      print('Erro detalhado ao buscar dados: $e');
      rethrow;
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Espiritual'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: FutureBuilder<Map<AssessmentType, Assessment>>(
          future: _fetchLatestResults(),
          builder: (context, snapshot) {
            if (_isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error.toString());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Nenhuma avaliação encontrada'),
                    ElevatedButton(
                      onPressed: _loadData,
                      child: const Text('Carregar Dados'),
                    ),
                  ],
                ),
              );
            }

            final assessments = snapshot.data!;
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Seu Progresso Espiritual',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                
                  ...AssessmentType.values.map((type) {
                    final assessment = assessments[type];
                    if (assessment == null || assessment.scores.isEmpty) {
                      print('Avaliação vazia para tipo: $type');
                      return const SizedBox.shrink();
                    }
                    
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpiritualRadarChart(
                        title: Assessment.typeNames[type] ?? type.toString(),
                        scores: assessment.scores,
                        gradientColors: _getGradientColors(type),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 16),
                  _buildStatCards(assessments),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  
  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Erro ao carregar dados: $error',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => setState(() => _cachedData = null),
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  List<Color> _getGradientColors(AssessmentType type) {
    switch (type) {
      case AssessmentType.spiritualDisciplines:
        return [Colors.blue, Colors.purple];
      case AssessmentType.fiveMinistries:
        return [Colors.orange, Colors.red];
      case AssessmentType.fruitOfSpirit:
        return [Colors.green, Colors.teal];
      case AssessmentType.pillars:
        return [Colors.deepPurple, Colors.indigo];
      case AssessmentType.intimacyLevel:
        return [Colors.pink, Colors.red];
      case AssessmentType.spiritualGifts:
        return [Colors.amber, Colors.deepOrange];
    }
  }

  Widget _buildStatCards(Map<AssessmentType, Assessment> assessments) {
    double overallAverage = 0;
    String strongestArea = '';
    double strongestScore = 0;
    String weakestArea = '';
    double weakestScore = double.infinity;
    int totalAreas = 0;

    assessments.forEach((type, assessment) {
      assessment.scores.forEach((area, score) {
        overallAverage += score;
        totalAreas++;

        if (score > strongestScore) {
          strongestScore = score;
          strongestArea = '$area (${Assessment.typeNames[type]})';
        }

        if (score < weakestScore) {
          weakestScore = score;
          weakestArea = '$area (${Assessment.typeNames[type]})';
        }
      });
    });

    overallAverage = totalAreas > 0 ? overallAverage / totalAreas : 0;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatCard(
            'Média Geral',
            overallAverage.toStringAsFixed(1),
            Icons.trending_up,
            Colors.blue,
          ),
          _buildStatCard(
            'Área + Forte',
            strongestArea,
            Icons.star,
            Colors.orange,
          ),
          _buildStatCard(
            'Área - Forte',
            weakestArea,
            Icons.fitness_center,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
