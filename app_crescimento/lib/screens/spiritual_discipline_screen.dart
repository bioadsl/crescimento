import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpiritualDisciplineScreen extends StatefulWidget {
  const SpiritualDisciplineScreen({super.key});

  @override
  State<SpiritualDisciplineScreen> createState() => _SpiritualDisciplineScreenState();
}

class _SpiritualDisciplineScreenState extends State<SpiritualDisciplineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentSection = 0;

  final Map<String, int> _prayer = {};
  final Map<String, int> _bibleReading = {};
  final Map<String, int> _fasting = {};
  final Map<String, int> _meditation = {};
  final Map<String, int> _worship = {};
  final Map<String, int> _fellowship = {};
  final Map<String, int> _service = {};
  final Map<String, int> _silence = {};
  final Map<String, int> _generosity = {};

  final List<Map<String, dynamic>> _sections = [
    {
      'title': 'Oração',
      'icon': Icons.person_pin,
      'color': Colors.blue,
      'description': 'Avalie sua vida de oração',
      'map': '_prayer',
      'questions': [
        'Eu reservo um tempo diário para orar e conversar com Deus.',
        'Durante minhas orações, busco não apenas pedir, mas também ouvir o que Deus quer me dizer.',
        'A oração é uma parte vital da minha vida espiritual, e eu não me sinto completo(a) sem ela.',
        'Eu oro em momentos de alegria e em momentos de dificuldades, confiando em Deus sempre.',
        'Sinto que minha vida de oração tem me aproximado cada vez mais de Deus.',
      ],
    },
    {
      'title': 'Leitura da Bíblia',
      'icon': Icons.book,
      'color': Colors.green,
      'description': 'Avalie seu hábito de leitura bíblica',
      'map': '_bibleReading',
      'questions': [
        'Eu leio a Bíblia regularmente e busco entendê-la em meu dia a dia.',
        'Tenho o hábito de meditar nas Escrituras e refletir sobre como elas se aplicam à minha vida.',
        'A leitura da Bíblia é algo que me alimenta espiritualmente e me fortalece.',
        'Busco conhecer melhor a Palavra de Deus para crescer em sabedoria e discernimento.',
        'Sinto que a Bíblia é um guia constante na minha vida, iluminando meus passos.',
      ],
    },
    {
      'title': 'Jejum',
      'icon': Icons.timer,
      'color': Colors.orange,
      'description': 'Avalie sua prática de jejum',
      'map': '_fasting',
      'questions': [
        'Eu pratico o jejum como uma forma de buscar mais intimidade com Deus.',
        'Durante o jejum, eu me concentro em orar e refletir sobre minha relação com Deus.',
        'O jejum é uma disciplina que me ajuda a colocar Deus em primeiro lugar.',
        'Sinto que o jejum me traz crescimento espiritual e me ajuda a depender mais de Deus.',
        'Eu tenho aprendido a ser mais sensível à voz de Deus durante os períodos de jejum.',
      ],
    },
    {
      'title': 'Meditação',
      'icon': Icons.self_improvement,
      'color': Colors.purple,
      'description': 'Avalie sua prática de meditação',
      'map': '_meditation',
      'questions': [
        'Eu reservo momentos para meditar nas coisas de Deus e refletir sobre Suas verdades.',
        'A meditação me ajuda a acalmar minha mente e sentir a presença de Deus.',
        'Eu busco focar em passagens bíblicas e deixar que elas penetrem no meu coração.',
        'A meditação me ajuda a aplicar as Escrituras em minha vida de forma prática.',
        'Eu encontro paz e clareza espiritual quando pratico a meditação.',
      ],
    },
    {
      'title': 'Adoração',
      'icon': Icons.music_note,
      'color': Colors.red,
      'description': 'Avalie sua vida de adoração',
      'map': '_worship',
      'questions': [
        'Eu busco adorar a Deus não apenas em cultos, mas também em minha vida diária.',
        'Eu sinto que a adoração é uma forma de entregar meu coração e minha vida a Deus.',
        'Tenho o hábito de louvar a Deus por Suas qualidades e ações continuamente.',
        'Eu me sinto renovado(a) espiritualmente sempre que estou envolvido(a) em adoração.',
        'A adoração é uma expressão constante de gratidão a Deus por tudo o que Ele é e faz.',
      ],
    },
    {
      'title': 'Comunhão',
      'icon': Icons.people,
      'color': Colors.teal,
      'description': 'Avalie sua vida em comunidade',
      'map': '_fellowship',
      'questions': [
        'Eu busco cultivar relacionamentos saudáveis com outros cristãos.',
        'Eu participo ativamente de uma igreja ou grupo de fé.',
        'Eu acredito que a comunhão com os irmãos em Cristo é vital para meu crescimento.',
        'Eu sou intencional em apoiar e ser apoiado(a) por outros cristãos.',
        'A comunhão fortalece minha vida espiritual e me encoraja a viver os princípios de Deus.',
      ],
    },
    {
      'title': 'Serviço',
      'icon': Icons.volunteer_activism,
      'color': Colors.indigo,
      'description': 'Avalie sua vida de serviço',
      'map': '_service',
      'questions': [
        'Eu busco ser uma bênção para os outros, servindo de forma prática e amorosa.',
        'O serviço aos outros é uma forma de adoração a Deus para mim.',
        'Eu sou sensível às necessidades ao meu redor e me esforço para ajudar.',
        'Eu vejo no serviço a oportunidade de refletir o amor de Cristo.',
        'O serviço é uma das maneiras pelas quais eu expresso meu compromisso com a fé.',
      ],
    },
    {
      'title': 'Silêncio',
      'icon': Icons.nature,
      'color': Colors.brown,
      'description': 'Avalie sua prática do silêncio',
      'map': '_silence',
      'questions': [
        'Eu pratico momentos de silêncio para ouvir a voz de Deus.',
        'Encontro paz e renovação espiritual no silêncio e na quietude.',
        'Eu busco momentos regulares para desconectar das distrações.',
        'Durante o silêncio, busco discernir a vontade de Deus para minha vida.',
        'A disciplina do silêncio tem me ajudado a crescer em paciência.',
      ],
    },
    {
      'title': 'Generosidade',
      'icon': Icons.favorite,
      'color': Colors.pink,
      'description': 'Avalie sua prática da generosidade',
      'map': '_generosity',
      'questions': [
        'Eu sou generoso(a) com meu tempo, recursos e talentos.',
        'Eu sinto que Deus me chamou a ser uma bênção para outros.',
        'A generosidade é uma expressão de minha gratidão a Deus.',
        'Eu busco ser sensível às necessidades dos outros.',
        'A prática da generosidade tem me aproximado mais de Deus.',
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
      'prayer': _calculateTotal(_prayer),
      'bibleReading': _calculateTotal(_bibleReading),
      'fasting': _calculateTotal(_fasting),
      'meditation': _calculateTotal(_meditation),
      'worship': _calculateTotal(_worship),
      'fellowship': _calculateTotal(_fellowship),
      'service': _calculateTotal(_service),
      'silence': _calculateTotal(_silence),
      'generosity': _calculateTotal(_generosity),
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/spiritual_disciplines'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(result),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        _showSuccessDialog();
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

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sucesso!'),
        content: const Text('Sua avaliação foi enviada com sucesso.'),
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
        title: const Text('Disciplinas Espirituais'),
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
            final section = _sections[index - 1];
            return _buildSectionPage(section);
          },
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildInstructionsPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info_outline, size: 64, color: Colors.blue),
          const SizedBox(height: 24),
          const Text(
            'Instruções',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Responda a cada pergunta com sinceridade, escolhendo a opção que melhor descreve você.\n\n'
            'Use uma escala de 1 a 5, onde:\n'
            '1 = Não me descreve\n'
            '5 = Descreve perfeitamente',
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
      case '_prayer':
        return _prayer;
      case '_bibleReading':
        return _bibleReading;
      case '_fasting':
        return _fasting;
      case '_meditation':
        return _meditation;
      case '_worship':
        return _worship;
      case '_fellowship':
        return _fellowship;
      case '_service':
        return _service;
      case '_silence':
        return _silence;
      case '_generosity':
        return _generosity;
      default:
        return {};
    }
  }
}