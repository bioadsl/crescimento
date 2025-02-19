import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpiritualGiftsScreen extends StatefulWidget {
  const SpiritualGiftsScreen({super.key});

  @override
  State<SpiritualGiftsScreen> createState() => _SpiritualGiftsScreenState();
}

class _SpiritualGiftsScreenState extends State<SpiritualGiftsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentPage = 0;

  final Map<String, int> _prophecy = {};
  final Map<String, int> _discernment = {};
  final Map<String, int> _tongues = {};
  final Map<String, int> _interpretation = {};
  final Map<String, int> _wisdom = {};
  final Map<String, int> _knowledge = {};
  final Map<String, int> _faith = {};
  final Map<String, int> _healing = {};
  final Map<String, int> _miracles = {};

  final List<Map<String, dynamic>> _gifts = [
    {
      'title': 'Profecia',
      'icon': Icons.record_voice_over,
      'color': Colors.purple.shade400,
      'description': 'Capacidade de receber e transmitir mensagens divinas',
      'map': '_prophecy',
      'questions': [
        'Frequentemente sinto que Deus coloca mensagens específicas em meu coração.',
        'Tenho um desejo constante de falar a verdade com coragem e clareza.',
        'Outros já confirmaram que palavras que compartilhei vieram de Deus.',
        'Identifico facilmente o que está alinhado com a Palavra de Deus.',
        'Sou usado para edificar, exortar e consolar outras pessoas.',
      ],
    },
    {
      'title': 'Discernimento',
      'icon': Icons.visibility,
      'color': Colors.blue.shade400,
      'description': 'Habilidade de distinguir entre espíritos',
      'map': '_discernment',
      'questions': [
        'Consigo perceber a presença de forças espirituais em situações.',
        'Tenho forte intuição sobre a origem divina ou maligna de algo.',
        'Já identifiquei quando algo parecia bom, mas não era de Deus.',
        'Reconheço facilmente falsos ensinos ou práticas contrárias.',
        'Sinto responsabilidade de alertar contra enganos espirituais.',
      ],
    },
    {
      'title': 'Línguas',
      'icon': Icons.language,
      'color': Colors.orange.shade400,
      'description': 'Dom de falar em línguas espirituais',
      'map': '_tongues',
      'questions': [
        'Tenho facilidade em orar em línguas ou busco este dom.',
        'As línguas me ajudam a expressar melhor minha devoção.',
        'Já usei línguas em momentos de oração intensa.',
        'Falar em línguas edifica meu espírito e conexão com Deus.',
        'Vejo o dom como expressão genuína do Espírito Santo.',
      ],
    },
    {
      'title': 'Interpretação',
      'icon': Icons.translate,
      'color': Colors.green.shade400,
      'description': 'Capacidade de interpretar mensagens em línguas',
      'map': '_interpretation',
      'questions': [
        'Deus me dá entendimento sobre mensagens em línguas.',
        'Já compreendi o significado de algo falado em línguas.',
        'Acredito na importância da interpretação para edificação.',
        'Sinto responsabilidade de trazer clareza às línguas.',
        'Tenho forte desejo de buscar e exercer este dom.',
      ],
    },
    {
      'title': 'Sabedoria',
      'icon': Icons.lightbulb,
      'color': Colors.amber.shade400,
      'description': 'Dom de aconselhar com sabedoria divina',
      'map': '_wisdom',
      'questions': [
        'Ofereço conselhos baseados na Palavra para situações complexas.',
        'Percebo a sabedoria divina em situações difíceis.',
        'Outros me procuram em busca de orientação espiritual.',
        'Deus me dá discernimento para entender problemas.',
        'Aplico verdades bíblicas em decisões práticas.',
      ],
    },
    {
      'title': 'Conhecimento',
      'icon': Icons.school,
      'color': Colors.indigo.shade400,
      'description': 'Revelação sobrenatural de informações',
      'map': '_knowledge',
      'questions': [
        'Recebo informações que não poderia saber naturalmente.',
        'Já soube algo específico que confirmou direção divina.',
        'Compreendo as Escrituras de forma profunda.',
        'Deus me revela verdades para compartilhar no momento certo.',
        'Desejo constantemente aprender mais sobre Deus.',
      ],
    },
    {
      'title': 'Fé',
      'icon': Icons.favorite,
      'color': Colors.red.shade400,
      'description': 'Fé sobrenatural para crer no impossível',
      'map': '_faith',
      'questions': [
        'Tenho confiança inabalável mesmo em dificuldades.',
        'Outros se sentem encorajados pela minha fé.',
        'Já confiei em Deus para o impossível e vi resultados.',
        'Creio na provisão divina em qualquer circunstância.',
        'Oro com ousadia por coisas aparentemente inatingíveis.',
      ],
    },
    {
      'title': 'Cura',
      'icon': Icons.healing,
      'color': Colors.teal.shade400,
      'description': 'Dom de ministrar cura divina',
      'map': '_healing',
      'questions': [
        'Sinto forte desejo de orar pela cura de outros.',
        'Creio que Deus ainda cura como no passado.',
        'Já testemunhei curas após oração ou imposição de mãos.',
        'Tenho empatia por pessoas que sofrem com doenças.',
        'Sinto que Deus me usa como instrumento de cura.',
      ],
    },
    {
      'title': 'Milagres',
      'icon': Icons.flash_on,
      'color': Colors.deepPurple.shade400,
      'description': 'Operação de obras sobrenaturais',
      'map': '_miracles',
      'questions': [
        'Creio que Deus pode operar milagres através de mim.',
        'Já vivi ou testemunhei milagres inexplicáveis.',
        'Tenho convicção de que Deus ainda faz obras sobrenaturais.',
        'Acredito em intervenções divinas em casos extremos.',
        'Inspiro esperança em Deus para o impossível.',
      ],
    },
  ];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, int> result = {
        'user_id': 1,
        'prophecy': _calculateTotal(_prophecy),
        'discernment': _calculateTotal(_discernment),
        'tongues': _calculateTotal(_tongues),
        'interpretation': _calculateTotal(_interpretation),
        'wisdom': _calculateTotal(_wisdom),
        'knowledge': _calculateTotal(_knowledge),
        'faith': _calculateTotal(_faith),
        'healing': _calculateTotal(_healing),
        'miracles': _calculateTotal(_miracles),
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/spiritual_gifts'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(result),
        );

        if (response.statusCode == 200) {
          _showResultDialog('Sucesso!', 'Suas respostas foram enviadas com sucesso.');
        } else {
          final errorResponse = json.decode(response.body);
          _showResultDialog('Erro', 'Falha ao enviar: ${errorResponse['error']}');
        }
      } catch (e) {
        _showResultDialog('Erro', 'Ocorreu um erro. Tente novamente mais tarde.');
      }
    }
  }

  int _calculateTotal(Map<String, int> map) {
    return map.values.isNotEmpty ? map.values.reduce((a, b) => a + b) : 0;
  }

  void _showResultDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
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

  Map<String, int> _getMapForGift(String mapName) {
    switch (mapName) {
      case '_prophecy':
        return _prophecy;
      case '_discernment':
        return _discernment;
      case '_tongues':
        return _tongues;
      case '_interpretation':
        return _interpretation;
      case '_wisdom':
        return _wisdom;
      case '_knowledge':
        return _knowledge;
      case '_faith':
        return _faith;
      case '_healing':
        return _healing;
      case '_miracles':
        return _miracles;
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

  Widget _buildInstructionsPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.card_giftcard,
            size: 64,
            color: Colors.purple,
          ),
          const SizedBox(height: 24),
          const Text(
            'Dons Espirituais',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            'Descubra seus dons espirituais respondendo às perguntas com sinceridade.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Use uma escala de 1 a 5, onde:\n1 = Não me descreve\n5 = Descreve perfeitamente',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dons Espirituais'),
        elevation: 0,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemCount: _gifts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildInstructionsPage();
          }

          final gift = _gifts[index - 1];
          final answers = _getMapForGift(gift['map']);

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
                          gift['icon'],
                          size: 32,
                          color: gift['color'],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                gift['title'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                gift['description'],
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
                ...gift['questions'].asMap().entries.map((entry) {
                  return _buildQuestionCard(
                    entry.value,
                    answers,
                    'q${entry.key + 1}',
                    gift['color'],
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _currentPage == _gifts.length
          ? _buildSubmitButton()
          : _buildNavigationButtons(),
    );
  }
}