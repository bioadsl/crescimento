import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IntimacyLevelScreen extends StatefulWidget {
  const IntimacyLevelScreen({super.key});

  @override
  State<IntimacyLevelScreen> createState() => _IntimacyLevelScreenState();
}

class _IntimacyLevelScreenState extends State<IntimacyLevelScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentSection = 0;

  final Map<String, int> _mission = {};
  final Map<String, int> _sharing = {};
  final Map<String, int> _prayer = {};
  final Map<String, int> _bible = {};
  final Map<String, int> _challenges = {};
  final Map<String, int> _support = {};
  final Map<String, int> _relationship = {};
  final Map<String, int> _heart = {};

  final List<Map<String, dynamic>> _sections = [
    {
      'title': 'Motivação para Seguir a Jesus',
      'icon': Icons.favorite,
      'color': Colors.red,
      'description': 'Avalie sua motivação em seguir a Jesus',
      'map': '_mission',
      'questions': [
        {
          'question': 'Por que você busca a Jesus?',
          'options': [1, 2, 3, 4, 5],
          'labels': [
            'Porque Ele pode suprir minhas necessidades.',
            'Para conhecer mais sobre o que Ele ensina.',
            'Para servi-Lo e viver conforme Sua vontade.',
            'Porque quero estar ao lado d\'Ele em todos os momentos.',
            'Porque O amo profundamente e quero conhecê-Lo mais intimamente.'
          ]
        },
        {
          'question': 'Com que frequência você reflete sobre o que Jesus significa para sua vida?',
          'options': [1, 2, 3, 4, 5],
          'labels': [
            'Somente em momentos de dificuldade.',
            'Quando ouço uma mensagem ou estudo algo específico.',
            'Regularmente durante o meu dia a dia.',
            'Sempre que oro ou leio a Palavra.',
            'Todos os dias, em todo momento, Ele está presente em meus pensamentos.'
          ]
        }
      ],
    },
    {
      'title': 'Envolvimento na Missão de Jesus',
      'icon': Icons.people,
      'color': Colors.blue,
      'description': 'Avalie seu envolvimento na missão',
      'map': '_mission',
      'questions': [
        {
          'question': 'Como você participa da missão de Jesus?',
          'options': [1, 2, 3, 4, 5],
          'labels': [
            'Apenas assisto cultos ou eventos.',
            'Ajudo quando solicitado.',
            'Faço parte de um ministério ou equipe na igreja.',
            'Busco oportunidades de servir além do ministério da igreja.',
            'Dedico minha vida para cumprir os propósitos de Jesus.'
          ]
        },
        {
          'question': 'Você compartilha a mensagem de Jesus com outros?',
          'options': [1, 2, 3, 4, 5],
          'labels': [
            'Não costumo compartilhar.',
            'Somente quando alguém pergunta diretamente.',
            'Comparto ocasionalmente com pessoas próximas.',
            'Busco ativamente compartilhar com aqueles ao meu redor.',
            'É uma prioridade para mim compartilhar o amor de Cristo.'
          ]
        }
      ],
    },
    {
      'title': 'Intimidade com Jesus',
      'icon': Icons.favorite_border,
      'color': Colors.purple,
      'description': 'Avalie sua intimidade com Jesus',
      'map': '_prayer',
      'questions': [
        {
          'question': 'Como é sua rotina de oração?',
          'options': [1, 2, 3, 4, 5],
          'labels': [
            'Oro apenas em momentos de necessidade.',
            'Oro ocasionalmente, mas sem consistência.',
            'Tenho uma rotina de oração regular.',
            'Oro frequentemente ao longo do dia.',
            'Oro constantemente e de maneira íntima, como se fosse uma conversa com um amigo.'
          ]
        },
        {
          'question': 'Como você se sente ao ler a Bíblia?',
          'options': [1, 2, 3, 4, 5],
          'labels': [
            'Leio raramente ou quando estou em um culto.',
            'Leio de vez em quando, mas às vezes é difícil entender.',
            'Tenho um plano de leitura regular e busco aplicá-lo à minha vida.',
            'Leio com frequência e sinto que Deus fala comigo por meio dela.',
            'Amo profundamente a Palavra e sinto que ela é essencial para meu dia a dia.'
          ]
        }
      ],
    },
    {
      'title': 'Reação Diante das Provações',
      'icon': Icons.security,
      'color': Colors.orange,
      'description': 'Avalie como você lida com as provações',
      'map': '_challenges',
      'questions': [
        {
          'question': 'Como você lida com desafios e provações?',
          'options': [1, 2, 3, 4, 5],
          'labels': [
            'Fico ansioso(a) e procuro soluções por conta própria.',
            'Peço ajuda a Deus, mas não consigo confiar totalmente.',
            'Confio em Deus, mas ainda luto para descansar n\'Ele.',
            'Entrego a situação a Deus e oro para que Ele me conduza.',
            'Descanso completamente em Deus, confiando plenamente em Sua vontade.'
          ]
        },
        {
          'question': 'Quando você enfrenta dificuldades, a quem você recorre primeiro?',
          'options': [1, 2, 3, 4, 5],
          'labels': [
            'A amigos ou familiares.',
            'À igreja ou a líderes espirituais.',
            'A Deus, mas também busco apoio humano.',
            'A Deus, confiando que Ele é minha primeira e principal solução.',
            'Somente a Deus, pois Ele é minha fortaleza em todas as coisas.'
          ]
        }
      ],
    },
    {
      'title': 'Profundidade do Relacionamento',
      'icon': Icons.favorite_border,
      'color': Colors.green,
      'description': 'Avalie a profundidade do seu relacionamento com Jesus',
      'map': '_relationship',
      'questions': [
        {
          'question': 'Como você descreveria seu relacionamento com Jesus?',
          'options': [1, 2, 3, 4, 5],
          'labels': [
            'Sei quem Ele é, mas ainda não o conheço bem.',
            'Estou aprendendo sobre Ele, mas sinto que há muito a crescer.',
            'Tenho um relacionamento crescente com Ele.',
            'Sinto-me próximo(a) de Jesus e vivo para agradá-Lo.',
            'Tenho plena certeza de que Ele é tudo para mim e minha vida é totalmente d\'Ele.'
          ]
        },
        {
          'question': 'Você sente que conhece o coração de Jesus?',
          'options': [1, 2, 3, 4, 5],
          'labels': [
            'Não tenho certeza.',
            'Tenho uma ideia geral do que Ele deseja.',
            'Entendo muitas de Suas prioridades e procuro segui-las.',
            'Conheço profundamente Seus valores e tento vivê-los.',
            'Sinto que conheço Seu coração e vivo em constante comunhão com Ele.'
          ]
        }
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
      'mission': _calculateTotal(_mission),
      'sharing': _calculateTotal(_sharing),
      'prayer': _calculateTotal(_prayer),
      'bible': _calculateTotal(_bible),
      'challenges': _calculateTotal(_challenges),
      'support': _calculateTotal(_support),
      'relationship': _calculateTotal(_relationship),
      'heart': _calculateTotal(_heart),
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/intimacy_levels'),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resultados'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Missão: ${results['mission']}'),
              Text('Compartilhamento: ${results['sharing']}'),
              Text('Oração: ${results['prayer']}'),
              Text('Bíblia: ${results['bible']}'),
              Text('Desafios: ${results['challenges']}'),
              Text('Suporte: ${results['support']}'),
              Text('Relacionamento: ${results['relationship']}'),
              Text('Coração: ${results['heart']}'),
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
        title: const Text('Níveis de Intimidade'),
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
                      'Avaliação de Níveis de Intimidade',
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
    Map<String, dynamic> question,
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
              question['question'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              question['options'].length,
              (index) => ListTile(
                title: Text(question['labels'][index]),
                leading: Radio<int>(
                  value: question['options'][index],
                  groupValue: answers[questionId],
                  onChanged: (value) {
                    setState(() {
                      answers[questionId] = value!;
                    });
                  },
                ),
              ),
            ),
          ],
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

  Map<String, int> _getMapForSection(String mapName) {
    switch (mapName) {
      case '_mission':
        return _mission;
      case '_sharing':
        return _sharing;
      case '_prayer':
        return _prayer;
      case '_bible':
        return _bible;
      case '_challenges':
        return _challenges;
      case '_support':
        return _support;
      case '_relationship':
        return _relationship;
      case '_heart':
        return _heart;
      default:
        return {};
    }
  }
}