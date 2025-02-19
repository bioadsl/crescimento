import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PillarScreen extends StatefulWidget {
  const PillarScreen({super.key});

  @override
  State<PillarScreen> createState() => _PillarScreenState();
}

class _PillarScreenState extends State<PillarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentPage = 0;

  final Map<String, int> _missions = {};
  final Map<String, int> _teaching = {};
  final Map<String, int> _worship = {};
  final Map<String, int> _discipleship = {};

  final List<Map<String, dynamic>> _pillars = [
    {
      'title': 'Missões',
      'icon': Icons.public,
      'color': Colors.orange.shade400,
      'description': 'Avalie seu envolvimento com a obra missionária',
      'questions': [
        'Busco ativamente compartilhar o evangelho com pessoas fora da igreja.',
        'Participo de projetos missionários locais ou internacionais.',
        'Oro regularmente por missionários e projetos de evangelização.',
        'Apoio financeiramente ou com recursos as iniciativas de missões.',
        'Sinto um chamado para alcançar aqueles que não conhecem a Cristo.',
      ],
      'map': '_missions',
    },
    {
      'title': 'Ensino',
      'icon': Icons.school,
      'color': Colors.blue.shade400,
      'description': 'Avalie seu compromisso com o aprendizado e ensino',
      'questions': [
        'Tenho o hábito de ensinar ou compartilhar o que aprendo da Palavra.',
        'Participo de cursos, seminários ou treinamentos da igreja.',
        'Busco aplicar os ensinamentos bíblicos na minha vida diária.',
        'Estudo e aprofundo meu conhecimento sobre a Bíblia e a fé cristã.',
        'Ajudo outros a crescerem no conhecimento de Deus.',
      ],
      'map': '_teaching',
    },
    {
      'title': 'Adoração',
      'icon': Icons.music_note,
      'color': Colors.purple.shade400,
      'description': 'Avalie sua vida de adoração a Deus',
      'questions': [
        'Dedico momentos pessoais e coletivos para adorar a Deus.',
        'Participo regularmente dos cultos e eventos de adoração.',
        'Minha vida reflete um coração voltado para adoração contínua.',
        'Reconheço a soberania de Deus em todas as áreas da vida.',
        'A adoração é uma atitude constante, não só um momento musical.',
      ],
      'map': '_worship',
    },
    {
      'title': 'Discipulado',
      'icon': Icons.people,
      'color': Colors.green.shade400,
      'description': 'Avalie seu envolvimento com o discipulado',
      'questions': [
        'Participo de grupos de discipulado ou acompanho alguém.',
        'Busco ser discipulado(a) por alguém mais experiente na fé.',
        'Ajudo outros a crescerem através de orientação e apoio.',
        'Comprometo-me com o crescimento espiritual de outros.',
        'Entendo o discipulado como processo contínuo de aprender e ensinar.',
      ],
      'map': '_discipleship',
    },
  ];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> result = {
        'user_id': 1, // Substitua pelo ID do usuário real
        'missions': _calculateTotal(_missions),
        'teaching': _calculateTotal(_teaching),
        'worship': _calculateTotal(_worship),
        'discipleship': _calculateTotal(_discipleship),
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/pillars'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(result),
        );

        if (response.statusCode == 200) {
          if (!mounted) return;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Resultado'),
              content: const Text('Avaliação enviada com sucesso!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          if (!mounted) return;
          _showErrorDialog('Falha ao enviar os resultados. Tente novamente.');
        }
      } catch (e) {
        if (!mounted) return;
        _showErrorDialog('Erro de conexão. Verifique sua internet.');
      }
    }
  }

  int _calculateTotal(Map<String, int> map) {
    return map.values.fold(0, (sum, value) => sum + value);
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

  Map<String, int> _getMapForPillar(String mapName) {
    switch (mapName) {
      case '_missions':
        return _missions;
      case '_teaching':
        return _teaching;
      case '_worship':
        return _worship;
      case '_discipleship':
        return _discipleship;
      default:
        return {};
    }
  }

  Widget _buildQuestionCard(String question, Map<String, int> answers, String key, Color color) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                final isSelected = answers[key] == index + 1;
                return InkWell(
                  onTap: () {
                    setState(() {
                      answers[key] = index + 1;
                    });
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? color : Colors.grey.shade100,
                      border: Border.all(
                        color: isSelected ? color : Colors.grey.shade300,
                        width: 2,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilares da Igreja'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _pillars.length + 1, // +1 para a página de instruções
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildInstructionsPage();
              }

              final pillar = _pillars[index - 1];
              final answers = _getMapForPillar(pillar['map']);

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(
                              pillar['icon'],
                              size: 32,
                              color: pillar['color'],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pillar['title'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    pillar['description'],
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
                    ),
                    const SizedBox(height: 16),
                    ...pillar['questions'].asMap().entries.map((entry) {
                      return _buildQuestionCard(
                        entry.value,
                        answers,
                        'q${entry.key + 1}',
                        pillar['color'],
                      );
                    }).toList(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: _currentPage == _pillars.length
          ? _buildSubmitButton()
          : _buildNavigationButtons(),
    );
  }

  Widget _buildInstructionsPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.church,
            size: 64,
            color: Colors.blue,
          ),
          const SizedBox(height: 24),
          const Text(
            'Pilares da Igreja CAP',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            'Avalie seu envolvimento com os pilares fundamentais da nossa igreja.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Use uma escala de 1 a 5, onde:\n1 = Nunca\n5 = Sempre',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Começar',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            ElevatedButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('Anterior'),
            ),
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

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Finalizar Avaliação',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}