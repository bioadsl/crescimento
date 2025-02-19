import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/spiritual_radar_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Espiritual'),
      ),
      body: SingleChildScrollView(
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
            SpiritualRadarChart(
              title: 'Disciplinas Espirituais',
              scores: {
                'Oração': 4.5,
                'Leitura': 3.8,
                'Jejum': 3.2,
                'Meditação': 4.0,
                'Adoração': 4.7,
                'Comunhão': 3.9,
                'Serviço': 4.2,
                'Silêncio': 3.5,
                'Generosidade': 4.1,
              },
              gradientColors: const [Colors.blue, Colors.purple],
            ),
            SpiritualRadarChart(
              title: 'Cinco Ministérios',
              scores: {
                'Apostólico': 3.8,
                'Profético': 4.2,
                'Evangelístico': 3.5,
                'Pastoral': 4.7,
                'Ensino': 4.0,
              },
              gradientColors: const [Colors.orange, Colors.red],
            ),
            SpiritualRadarChart(
              title: 'Frutos do Espírito',
              scores: {
                'Amor': 4.5,
                'Alegria': 4.2,
                'Paz': 3.8,
                'Paciência': 3.5,
                'Bondade': 4.0,
                'Benignidade': 4.3,
                'Fidelidade': 4.1,
                'Mansidão': 3.7,
                'Domínio Próprio': 3.9,
              },
              gradientColors: const [Colors.green, Colors.teal],
            ),
            SpiritualRadarChart(
              title: 'Pilares',
              scores: {
                'Palavra': 4.2,
                'Oração': 3.9,
                'Comunhão': 4.1,
                'Evangelismo': 3.7,
                'Serviço': 4.0,
                'Adoração': 4.5,
              },
              gradientColors: const [Colors.deepPurple, Colors.indigo],
            ),
            SpiritualRadarChart(
              title: 'Níveis de Intimidade',
              scores: {
                'Motivação': 4.3,
                'Envolvimento': 3.8,
                'Intimidade': 4.0,
                'Provações': 3.6,
                'Relacionamento': 4.2,
                'Coração': 4.1,
                'Missão': 3.9,
                'Compartilhar': 3.7,
              },
              gradientColors: const [Colors.pink, Colors.red],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard(
                    'Média Geral',
                    '4.1',
                    Icons.trending_up,
                    Colors.blue,
                  ),
                  _buildStatCard(
                    'Área + Forte',
                    'Adoração',
                    Icons.star,
                    Colors.orange,
                  ),
                  _buildStatCard(
                    'Área - Forte',
                    'Jejum',
                    Icons.fitness_center,
                    Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Adicione aqui a navegação para a tela de avaliação
        },
        child: const Icon(Icons.add),
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