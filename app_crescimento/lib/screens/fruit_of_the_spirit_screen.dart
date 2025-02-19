import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FruitOfTheSpiritScreen extends StatefulWidget {
  const FruitOfTheSpiritScreen({super.key});

  @override
  State<FruitOfTheSpiritScreen> createState() => _FruitOfTheSpiritScreenState();
}

class _FruitOfTheSpiritScreenState extends State<FruitOfTheSpiritScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentSection = 0;

  final Map<String, int> _love = {};
  final Map<String, int> _joy = {};
  final Map<String, int> _peace = {};
  final Map<String, int> _patience = {};
  final Map<String, int> _kindness = {};
  final Map<String, int> _goodness = {};
  final Map<String, int> _faithfulness = {};
  final Map<String, int> _gentleness = {};
  final Map<String, int> _selfControl = {};

  final List<Map<String, dynamic>> _sections = [
    {
      'title': 'Amor',
      'icon': Icons.favorite,
      'color': Colors.red,
      'description': 'Avalie como você expressa o amor',
      'map': '_love',
      'questions': [
        'Tenho facilidade em demonstrar carinho e respeito pelas pessoas, independentemente de como me tratam.',
        'Busco ajudar os outros, mesmo quando não recebo nada em troca.',
        'Consigo perdoar com facilidade aqueles que me magoam.',
        'Coloco as necessidades dos outros acima das minhas quando necessário.',
        'Sinto que sou movido(a) por um amor genuíno por Deus e pelas pessoas.',
      ],
    },
    {
      'title': 'Alegria',
      'icon': Icons.sentiment_very_satisfied,
      'color': Colors.orange,
      'description': 'Avalie sua expressão de alegria',
      'map': '_joy',
      'questions': [
        'Sinto uma alegria constante, independentemente das circunstâncias.',
        'Minha alegria vem de Deus e não das situações ao meu redor.',
        'Consigo encontrar motivos para ser grato(a) em todas as situações.',
        'Minha alegria é contagiante e inspira outras pessoas.',
        'Sinto que a alegria do Senhor é a minha força.',
      ],
    },
    {
      'title': 'Paz',
      'icon': Icons.spa,
      'color': Colors.blue,
      'description': 'Avalie sua expressão de paz',
      'map': '_peace',
      'questions': [
        'Mantenho a calma mesmo em situações de estresse ou conflito.',
        'Confio em Deus e não me preocupo excessivamente com o futuro.',
        'Sou uma pessoa que traz paz aos ambientes e relacionamentos.',
        'Consigo manter a serenidade mesmo quando as coisas não saem como planejado.',
        'Sinto uma paz interior que vem de minha relação com Deus.',
      ],
    },
    {
      'title': 'Paciência',
      'icon': Icons.hourglass_empty,
      'color': Colors.purple,
      'description': 'Avalie sua expressão de paciência',
      'map': '_patience',
      'questions': [
        'Consigo esperar com tranquilidade os tempos de Deus.',
        'Mantenho a calma ao lidar com pessoas difíceis.',
        'Aceito que nem tudo acontece no meu tempo ideal.',
        'Sou paciente com o processo de crescimento dos outros.',
        'Persisto em meus objetivos mesmo quando os resultados demoram.',
      ],
    },
    {
      'title': 'Bondade',
      'icon': Icons.volunteer_activism,
      'color': Colors.pink,
      'description': 'Avalie sua expressão de bondade',
      'map': '_kindness',
      'questions': [
        'Trato as pessoas com gentileza e consideração.',
        'Procuro ser prestativo(a) e ajudar os outros.',
        'Demonstro bondade mesmo com quem não merece.',
        'Sou sensível às necessidades das pessoas ao meu redor.',
        'Pratico atos de bondade sem esperar reconhecimento.',
      ],
    },
    {
      'title': 'Bondade',
      'icon': Icons.lightbulb,
      'color': Colors.amber,
      'description': 'Avalie sua expressão de bondade',
      'map': '_goodness',
      'questions': [
        'Busco fazer o que é certo, mesmo quando ninguém está vendo.',
        'Minhas ações refletem o caráter de Cristo.',
        'Procuro ser íntegro(a) em todas as áreas da minha vida.',
        'Tomo decisões baseadas em princípios bíblicos.',
        'Minha vida é um testemunho da bondade de Deus.',
      ],
    },
    {
      'title': 'Fidelidade',
      'icon': Icons.verified,
      'color': Colors.indigo,
      'description': 'Avalie sua expressão de fidelidade',
      'map': '_faithfulness',
      'questions': [
        'Sou uma pessoa em quem os outros podem confiar.',
        'Mantenho minhas promessas e compromissos.',
        'Permaneço fiel a Deus mesmo em tempos difíceis.',
        'Sou consistente em minhas responsabilidades.',
        'Demonstro lealdade em meus relacionamentos.',
      ],
    },
    {
      'title': 'Mansidão',
      'icon': Icons.favorite_border,
      'color': Colors.teal,
      'description': 'Avalie sua expressão de mansidão',
      'map': '_gentleness',
      'questions': [
        'Trato os outros com gentileza e respeito.',
        'Consigo controlar minha força e influência.',
        'Sou humilde ao lidar com diferentes opiniões.',
        'Respondo com mansidão mesmo quando provocado(a).',
        'Demonstro um espírito manso e tranquilo.',
      ],
    },
    {
      'title': 'Domínio Próprio',
      'icon': Icons.psychology,
      'color': Colors.brown,
      'description': 'Avalie seu domínio próprio',
      'map': '_selfControl',
      'questions': [
        'Controlo bem minhas emoções e reações.',
        'Mantenho disciplina em meus hábitos e rotinas.',
        'Resisto a tentações e impulsos negativos.',
        'Penso antes de falar ou agir.',
        'Mantenho o equilíbrio em diferentes áreas da vida.',
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final Map<String, dynamic> result = {
      'user_id': 1,
      'love': _calculateTotal(_love),
      'joy': _calculateTotal(_joy),
      'peace': _calculateTotal(_peace),
      'patience': _calculateTotal(_patience),
      'kindness': _calculateTotal(_kindness),
      'goodness': _calculateTotal(_goodness),
      'faithfulness': _calculateTotal(_faithfulness),
      'gentleness': _calculateTotal(_gentleness),
      'selfControl': _calculateTotal(_selfControl),
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/fruit_of_spirit'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(result),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        _showResultDialog(result);
      } else {
        _showErrorDialog('Falha ao enviar os resultados. Tente novamente.');
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorDialog('Erro de conexão. Verifique sua internet.');
    }
  }

  Map<String, int> _getMapForSection(String mapName) {
    switch (mapName) {
      case '_love':
        return _love;
      case '_joy':
        return _joy;
      case '_peace':
        return _peace;
      case '_patience':
        return _patience;
      case '_kindness':
        return _kindness;
      case '_goodness':
        return _goodness;
      case '_faithfulness':
        return _faithfulness;
      case '_gentleness':
        return _gentleness;
      case '_selfControl':
        return _selfControl;
      default:
        return {};
    }
  }

  int _calculateTotal(Map<String, int> map) {
    return map.values.fold(0, (sum, value) => sum + value);
  }

  void _showResultDialog(Map<String, dynamic> results) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resultados'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Amor: ${results['love']}'),
              Text('Alegria: ${results['joy']}'),
              Text('Paz: ${results['peace']}'),
              Text('Paciência: ${results['patience']}'),
              Text('Bondade: ${results['kindness']}'),
              Text('Bondade: ${results['goodness']}'),
              Text('Fidelidade: ${results['faithfulness']}'),
              Text('Mansidão: ${results['gentleness']}'),
              Text('Domínio Próprio: ${results['selfControl']}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frutos do Espírito'),
      ),
      body: Form(
        key: _formKey,
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) => setState(() => _currentSection = index),
          itemCount: _sections.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Avaliação dos Frutos do Espírito',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Responda a cada pergunta com sinceridade, escolhendo a opção que melhor descreve você.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: const Text('Começar'),
                    ),
                  ],
                ),
              );
            }

            final section = _sections[index - 1];
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(section),
                  const SizedBox(height: 16),
                  ...List.generate(
                    section['questions'].length,
                    (qIndex) => _buildQuestionCard(
                      section['questions'][qIndex],
                      _getMapForSection(section['map']),
                      'q${qIndex + 1}',
                      section['color'],
                    ),
                  ),
                  _buildNavigationBar(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(Map<String, dynamic> section) {
    return Card(
      color: section['color'].withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(section['icon'], color: section['color'], size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section['title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    section['description'],
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(
    String question,
    Map<String, int> answers,
    String questionId,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return _buildRatingButton(
                  index + 1,
                  answers,
                  questionId,
                  color,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingButton(
    int value,
    Map<String, int> answers,
    String questionId,
    Color color,
  ) {
    final isSelected = answers[questionId] == value;
    return InkWell(
      onTap: () => setState(() => answers[questionId] = value),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? color : Colors.grey.shade200,
        ),
        child: Center(
          child: Text(
            value.toString(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentSection > 1)
            ElevatedButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('Anterior'),
            ),
          if (_currentSection == _sections.length)
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Finalizar'),
            )
          else if (_currentSection > 0)
            ElevatedButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('Próximo'),
            ),
        ],
      ),
    );
  }
}