import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FiveMinistriesScreen extends StatefulWidget {
  const FiveMinistriesScreen({super.key});

  @override
  State<FiveMinistriesScreen> createState() => _FiveMinistriesScreenState();
}

class _FiveMinistriesScreenState extends State<FiveMinistriesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentSection = 0;

  final Map<String, int> _apostolic = {};
  final Map<String, int> _prophetic = {};
  final Map<String, int> _evangelistic = {};
  final Map<String, int> _pastoral = {};
  final Map<String, int> _teaching = {};

  final List<Map<String, dynamic>> _sections = [
    {
      'title': 'Ministério Apostólico',
      'icon': Icons.public,
      'color': Colors.blue,
      'description': 'Avalie seu chamado apostólico',
      'map': '_apostolic',
      'questions': [
        'Gosto de começar novos projetos ou empreendimentos que promovam o Reino de Deus.',
        'Tenho facilidade para liderar e inspirar pessoas a seguirem uma visão.',
        'Sinto um chamado para alcançar lugares ou pessoas que ainda não ouviram o evangelho.',
        'Tenho interesse em estruturar igrejas ou ministérios de maneira organizada e funcional.',
        'Consigo identificar talentos nas pessoas e ajudá-las a desenvolverem suas habilidades espirituais.',
      ],
    },
    {
      'title': 'Ministério Profético',
      'icon': Icons.remove_red_eye,
      'color': Colors.purple,
      'description': 'Avalie seu chamado profético',
      'map': '_prophetic',
      'questions': [
        'Tenho uma forte sensibilidade espiritual e consigo discernir o que Deus está falando.',
        'Frequentemente sinto o desejo de corrigir injustiças ou de confrontar situações contrárias à Palavra de Deus.',
        'Tenho facilidade em encorajar outros a ouvirem a Deus e buscarem Sua direção.',
        'Sinto que minha vida é direcionada pela oração e pela busca constante da vontade de Deus.',
        'Às vezes percebo ou sinto coisas espirituais antes de acontecerem.',
      ],
    },
    {
      'title': 'Ministério Evangelístico',
      'icon': Icons.share,
      'color': Colors.orange,
      'description': 'Avalie seu chamado evangelístico',
      'map': '_evangelistic',
      'questions': [
        'Tenho paixão por compartilhar o evangelho com pessoas que ainda não conhecem Jesus.',
        'Gosto de estar em contato com pessoas de diferentes contextos e culturas para falar de Cristo.',
        'Sinto que sou chamado a trazer novas pessoas para a igreja e para o Reino de Deus.',
        'Tenho facilidade para iniciar conversas sobre Jesus com desconhecidos.',
        'Fico motivado ao ver vidas transformadas pelo evangelho.',
      ],
    },
    {
      'title': 'Ministério Pastoral',
      'icon': Icons.favorite,
      'color': Colors.green,
      'description': 'Avalie seu chamado pastoral',
      'map': '_pastoral',
      'questions': [
        'Tenho um grande amor pelas pessoas e desejo ajudá-las a crescer em sua fé.',
        'Tenho facilidade para aconselhar e orientar pessoas em momentos difíceis.',
        'Sinto um chamado para cuidar do bem-estar espiritual, emocional e físico de outros.',
        'Preocupo-me com a unidade e harmonia dentro da igreja ou do grupo que participo.',
        'Sou paciente e compreensivo ao lidar com as falhas e dificuldades das pessoas.',
      ],
    },
    {
      'title': 'Ministério de Ensino',
      'icon': Icons.school,
      'color': Colors.red,
      'description': 'Avalie seu chamado para ensinar',
      'map': '_teaching',
      'questions': [
        'Tenho facilidade para explicar conceitos bíblicos de maneira clara e compreensível.',
        'Gosto de estudar profundamente a Bíblia e compartilhar o que aprendo.',
        'Tenho paixão por ajudar outros a crescerem em conhecimento e sabedoria espiritual.',
        'Sinto alegria em preparar e ministrar estudos ou pregações.',
        'Fico motivado quando vejo outros aplicando o que aprenderam através de meus ensinamentos.',
      ],
    },
  ];

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final Map<String, dynamic> result = {
      'user_id': 1,
      'apostolic': _calculateTotal(_apostolic),
      'prophetic': _calculateTotal(_prophetic),
      'evangelistic': _calculateTotal(_evangelistic),
      'pastoral': _calculateTotal(_pastoral),
      'teaching': _calculateTotal(_teaching),
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/five_ministries'),
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

  int _calculateTotal(Map<String, int> map) {
    return map.values.fold(0, (sum, value) => sum + value);
  }

  void _showResultDialog(Map<String, dynamic> results) {
    final Map<String, int> scores = {
      'Apostólico': results['apostolic'],
      'Profético': results['prophetic'],
      'Evangelístico': results['evangelistic'],
      'Pastoral': results['pastoral'],
      'Ensino': results['teaching'],
    };

    final String predominantMinistry = scores.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    final Map<String, String> descriptions = {
      'Apostólico': 'Ministério Apostólico: Você tem um chamado para iniciar novos projetos e liderar pessoas.',
      'Profético': 'Ministério Profético: Você tem uma forte sensibilidade espiritual e um desejo de corrigir injustiças.',
      'Evangelístico': 'Ministério Evangelístico: Você tem paixão por compartilhar o evangelho com novas pessoas.',
      'Pastoral': 'Ministério Pastoral: Você tem um grande amor pelas pessoas e deseja ajudá-las a crescer em sua fé.',
      'Ensino': 'Ministério de Ensino: Você tem facilidade para explicar conceitos bíblicos e ajudar outros a crescerem em conhecimento.',
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resultado'),
        content: Text(descriptions[predominantMinistry]!),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
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
        title: const Text('5 Ministérios'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (page) => setState(() => _currentSection = page),
          itemCount: _sections.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildInstructionsPage();
            }
            return _buildSectionPage(_sections[index - 1]);
          },
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildInstructionsPage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person_search,
            size: 64,
            color: Colors.blue,
          ),
          const SizedBox(height: 24),
          const Text(
            'INSTRUÇÕES',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Responda cada pergunta com sinceridade, escolhendo a opção que melhor descreve você:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Text(
            '1 = Não me descreve\n5 = Descreve perfeitamente',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
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
            ),
            child: const Text('Começar Avaliação'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionPage(Map<String, dynamic> section) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(section),
          const SizedBox(height: 24),
          ...section['questions'].asMap().entries.map((entry) {
            return _buildQuestionCard(
              entry.value,
              _getMapForSection(section['map']),
              'q${entry.key + 1}',
              section['color'],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(Map<String, dynamic> section) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              section['icon'],
              size: 32,
              color: section['color'],
            ),
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
                  const SizedBox(height: 4),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
    if (_currentSection == 0) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentSection > 0)
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
          else
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

  Map<String, int> _getMapForSection(String mapName) {
    switch (mapName) {
      case '_apostolic':
        return _apostolic;
      case '_prophetic':
        return _prophetic;
      case '_evangelistic':
        return _evangelistic;
      case '_pastoral':
        return _pastoral;
      case '_teaching':
        return _teaching;
      default:
        return {};
    }
  }
}