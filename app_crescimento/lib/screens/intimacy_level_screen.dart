import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IntimacyLevelScreen extends StatefulWidget {
  @override
  _IntimacyLevelScreenState createState() => _IntimacyLevelScreenState();
}

class _IntimacyLevelScreenState extends State<IntimacyLevelScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final Map<String, int> _mission = {};
  final Map<String, int> _sharing = {};
  final Map<String, int> _prayer = {};
  final Map<String, int> _bible = {};
  final Map<String, int> _challenges = {};
  final Map<String, int> _support = {};
  final Map<String, int> _relationship = {};
  final Map<String, int> _heart = {};

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final int mission = _mission.values.isNotEmpty ? _mission.values.reduce((a, b) => a + b) : 0;
      final int sharing = _sharing.values.isNotEmpty ? _sharing.values.reduce((a, b) => a + b) : 0;
      final int prayer = _prayer.values.isNotEmpty ? _prayer.values.reduce((a, b) => a + b) : 0;
      final int bible = _bible.values.isNotEmpty ? _bible.values.reduce((a, b) => a + b) : 0;
      final int challenges = _challenges.values.isNotEmpty ? _challenges.values.reduce((a, b) => a + b) : 0;
      final int support = _support.values.isNotEmpty ? _support.values.reduce((a, b) => a + b) : 0;
      final int relationship = _relationship.values.isNotEmpty ? _relationship.values.reduce((a, b) => a + b) : 0;
      final int heart = _heart.values.isNotEmpty ? _heart.values.reduce((a, b) => a + b) : 0;

      final int totalScore = mission + sharing + prayer + bible + challenges + support + relationship + heart;

      final Map<String, dynamic> result = {
        'user_id': 1, // Substitua pelo ID do usuário real
        'mission': mission,
        'sharing': sharing,
        'prayer': prayer,
        'bible': bible,
        'challenges': challenges,
        'support': support,
        'relationship': relationship,
        'heart': heart,
        'total_score': totalScore,
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/intimacy_level'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(result),
        );

        if (response.statusCode == 200) {
          String resultMessage;
          if (totalScore <= 15) {
            resultMessage = "Multidão Você está começando sua jornada.";
          } else if (totalScore <= 25) {
            resultMessage = "Os 70 Você está se comprometendo mais com Jesus.";
          } else if (totalScore <= 35) {
            resultMessage = "Os 12 Você está crescendo no discipulado e serviço.";
          } else if (totalScore <= 45) {
            resultMessage = "Os 3 Você tem um relacionamento próximo e profundo.";
          } else {
            resultMessage = "O 1 Você vive em íntima comunhão com Jesus.";
          }

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Resultado'),
              content: Text(resultMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          final errorResponse = json.decode(response.body);
          print('Failed to submit result: ${errorResponse['error']}');
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Erro'),
              content: Text('Falha ao enviar os resultados: ${errorResponse['error']}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        print('Error: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erro'),
            content: Text('Ocorreu um erro ao enviar os resultados. Tente novamente mais tarde.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Widget _buildRadioGroup(String question, Map<String, int> group, String key, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        Column(
          children: List.generate(options.length, (index) {
            return Row(
              children: [
                Radio<int>(
                  value: index + 1,
                  groupValue: group[key],
                  onChanged: (value) {
                    setState(() {
                      group[key] = value!;
                    });
                  },
                ),
                Expanded(child: Text(options[index])),
              ],
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Níveis de Intimidade com Jesus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('INSTRUÇÕES\nResponda a cada pergunta com sinceridade, escolhendo a opção que melhor descreve você. Use uma escala de 1 a 5, onde:\n1 = Não me descreve.\n5 = Descreve perfeitamente.', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Seção 1: Motivação para Seguir a Jesus', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup(
                'Por que você busca a Jesus?',
                _mission,
                'q1',
                [
                  '1) Porque Ele pode suprir minhas necessidades.',
                  '2) Para conhecer mais sobre o que Ele ensina.',
                  '3) Para servi-Lo e viver conforme Sua vontade.',
                  '4) Porque quero estar ao lado d\'Ele em todos os momentos.',
                  '5) Porque O amo profundamente e quero conhecê-Lo mais intimamente.'
                ],
              ),
              _buildRadioGroup(
                'Com que frequência você reflete sobre o que Jesus significa para sua vida?',
                _mission,
                'q2',
                [
                  '1) Somente em momentos de dificuldade.',
                  '2) Quando ouço uma mensagem ou estudo algo específico.',
                  '3) Regularmente durante o meu dia a dia.',
                  '4) Sempre que oro ou leio a Palavra.',
                  '5) Todos os dias, em todo momento, Ele está presente em meus pensamentos.'
                ],
              ),
              SizedBox(height: 16),
              Text('Seção 2: Envolvimento na Missão de Jesus', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup(
                'Como você participa da missão de Jesus?',
                _mission,
                'q3',
                [
                  '1) Apenas assisto cultos ou eventos.',
                  '2) Ajudo quando solicitado.',
                  '3) Faço parte de um ministério ou equipe na igreja.',
                  '4) Busco oportunidades de servir além do ministério da igreja.',
                  '5) Dedico minha vida para cumprir os propósitos de Jesus.'
                ],
              ),
              _buildRadioGroup(
                'Você compartilha a mensagem de Jesus com outros?',
                _sharing,
                'q1',
                [
                  '1) Não costumo compartilhar.',
                  '2) Somente quando alguém pergunta diretamente.',
                  '3) Comparto ocasionalmente com pessoas próximas.',
                  '4) Busco ativamente compartilhar com aqueles ao meu redor.',
                  '5) É uma prioridade para mim compartilhar o amor de Cristo.'
                ],
              ),
              SizedBox(height: 16),
              Text('Seção 3: Intimidade com Jesus', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup(
                'Como é sua rotina de oração?',
                _prayer,
                'q1',
                [
                  '1) Oro apenas em momentos de necessidade.',
                  '2) Oro ocasionalmente, mas sem consistência.',
                  '3) Tenho uma rotina de oração regular.',
                  '4) Oro frequentemente ao longo do dia.',
                  '5) Oro constantemente e de maneira íntima, como se fosse uma conversa com um amigo.'
                ],
              ),
              _buildRadioGroup(
                'Como você se sente ao ler a Bíblia?',
                _bible,
                'q1',
                [
                  '1) Leio raramente ou quando estou em um culto.',
                  '2) Leio de vez em quando, mas às vezes é difícil entender.',
                  '3) Tenho um plano de leitura regular e busco aplicá-lo à minha vida.',
                  '4) Leio com frequência e sinto que Deus fala comigo por meio dela.',
                  '5) Amo profundamente a Palavra e sinto que ela é essencial para meu dia a dia.'
                ],
              ),
              SizedBox(height: 16),
              Text('Seção 4: Reação Diante das Provações', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup(
                'Como você lida com desafios e provações?',
                _challenges,
                'q1',
                [
                  '1) Fico ansioso(a) e procuro soluções por conta própria.',
                  '2) Peço ajuda a Deus, mas não consigo confiar totalmente.',
                  '3) Confio em Deus, mas ainda luto para descansar n\'Ele.',
                  '4) Entrego a situação a Deus e oro para que Ele me conduza.',
                  '5) Descanso completamente em Deus, confiando plenamente em Sua vontade.'
                ],
              ),
              _buildRadioGroup(
                'Quando você enfrenta dificuldades, a quem você recorre primeiro?',
                _support,
                'q1',
                [
                  '1) A amigos ou familiares.',
                  '2) À igreja ou a líderes espirituais.',
                  '3) A Deus, mas também busco apoio humano.',
                  '4) A Deus, confiando que Ele é minha primeira e principal solução.',
                  '5) Somente a Deus, pois Ele é minha fortaleza em todas as coisas.'
                ],
              ),
              SizedBox(height: 16),
              Text('Seção 5: Profundidade do Relacionamento com Jesus', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup(
                'Como você descreveria seu relacionamento com Jesus?',
                _relationship,
                'q1',
                [
                  '1) Sei quem Ele é, mas ainda não o conheço bem.',
                  '2) Estou aprendendo sobre Ele, mas sinto que há muito a crescer.',
                  '3) Tenho um relacionamento crescente com Ele.',
                  '4) Sinto-me próximo(a) de Jesus e vivo para agradá-Lo.',
                  '5) Tenho plena certeza de que Ele é tudo para mim e minha vida é totalmente d\'Ele.'
                ],
              ),
              _buildRadioGroup(
                'Você sente que conhece o coração de Jesus?',
                _heart,
                'q1',
                [
                  '1) Não tenho certeza.',
                  '2) Tenho uma ideia geral do que Ele deseja.',
                  '3) Entendo muitas de Suas prioridades e procuro segui-las.',
                  '4) Conheço profundamente Seus valores e tento vivê-los.',
                  '5) Sinto que conheço Seu coração e vivo em constante comunhão com Ele.'
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}