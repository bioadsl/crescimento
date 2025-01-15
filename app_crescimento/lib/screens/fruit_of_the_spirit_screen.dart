import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FruitOfTheSpiritScreen extends StatefulWidget {
  @override
  _FruitOfTheSpiritScreenState createState() => _FruitOfTheSpiritScreenState();
}

class _FruitOfTheSpiritScreenState extends State<FruitOfTheSpiritScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final Map<String, int> _love = {};
  final Map<String, int> _joy = {};
  final Map<String, int> _peace = {};
  final Map<String, int> _patience = {};
  final Map<String, int> _kindness = {};
  final Map<String, int> _goodness = {};
  final Map<String, int> _faithfulness = {};
  final Map<String, int> _gentleness = {};
  final Map<String, int> _selfControl = {};

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final int love = _love.values.isNotEmpty ? _love.values.reduce((a, b) => a + b) : 0;
      final int joy = _joy.values.isNotEmpty ? _joy.values.reduce((a, b) => a + b) : 0;
      final int peace = _peace.values.isNotEmpty ? _peace.values.reduce((a, b) => a + b) : 0;
      final int patience = _patience.values.isNotEmpty ? _patience.values.reduce((a, b) => a + b) : 0;
      final int kindness = _kindness.values.isNotEmpty ? _kindness.values.reduce((a, b) => a + b) : 0;
      final int goodness = _goodness.values.isNotEmpty ? _goodness.values.reduce((a, b) => a + b) : 0;
      final int faithfulness = _faithfulness.values.isNotEmpty ? _faithfulness.values.reduce((a, b) => a + b) : 0;
      final int gentleness = _gentleness.values.isNotEmpty ? _gentleness.values.reduce((a, b) => a + b) : 0;
      final int selfControl = _selfControl.values.isNotEmpty ? _selfControl.values.reduce((a, b) => a + b) : 0;

      final int totalScore = love + joy + peace + patience + kindness + goodness + faithfulness + gentleness + selfControl;

      final Map<String, dynamic> result = {
        'user_id': 1, // Substitua pelo ID do usuário real
        'love': love,
        'joy': joy,
        'peace': peace,
        'patience': patience,
        'kindness': kindness,
        'goodness': goodness,
        'faithfulness': faithfulness,
        'gentleness': gentleness,
        'self_control': selfControl,
        'total_score': totalScore,
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/fruit_of_the_spirit'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(result),
        );

        if (response.statusCode == 200) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Resultado'),
              content: Text('Os resultados foram enviados com sucesso!'),
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

  Widget _buildRadioGroup(String question, Map<String, int> group, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            return Expanded(
              child: Row(
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
                  Text('${index + 1}'),
                ],
              ),
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
        title: Text('Frutos do Espírito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'INSTRUÇÕES\nResponda cada pergunta com sinceridade, escolhendo a opção que melhor descreve você. Use uma escala de 1 a 5, onde:\n1 = Não me descreve.\n5 = Descreve perfeitamente.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text('Seção 1: Amor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho facilidade em demonstrar carinho e respeito pelas pessoas, independentemente de como me tratam.', _love, 'q1'),
              _buildRadioGroup('Busco ajudar os outros, mesmo quando não recebo nada em troca.', _love, 'q2'),
              _buildRadioGroup('Consigo perdoar com facilidade aqueles que me magoam.', _love, 'q3'),
              _buildRadioGroup('Coloco as necessidades dos outros acima das minhas quando necessário.', _love, 'q4'),
              _buildRadioGroup('Sinto que sou movido(a) por um amor genuíno por Deus e pelas pessoas.', _love, 'q5'),
              SizedBox(height: 16),
              Text('Seção 2: Alegria', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Sinto uma alegria constante, independentemente das circunstâncias.', _joy, 'q1'),
              _buildRadioGroup('Minha alegria vem de Deus e não das situações ao meu redor.', _joy, 'q2'),
              _buildRadioGroup('Consigo encontrar motivos para ser grato(a) em todas as situações.', _joy, 'q3'),
              _buildRadioGroup('Minha alegria é contagiante e inspira outras pessoas.', _joy, 'q4'),
              _buildRadioGroup('Sinto que a alegria do Senhor é a minha força.', _joy, 'q5'),
              SizedBox(height: 16),
              Text('Seção 3: Paz', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho uma paz interior que não depende das circunstâncias.', _peace, 'q1'),
              _buildRadioGroup('Confio que Deus está no controle de todas as coisas.', _peace, 'q2'),
              _buildRadioGroup('Consigo manter a calma em situações de conflito.', _peace, 'q3'),
              _buildRadioGroup('Busco promover a paz em meus relacionamentos.', _peace, 'q4'),
              _buildRadioGroup('Sinto que a paz de Deus guarda meu coração e minha mente.', _peace, 'q5'),
              SizedBox(height: 16),
              Text('Seção 4: Paciência', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho paciência com as pessoas, mesmo quando elas me frustram.', _patience, 'q1'),
              _buildRadioGroup('Consigo esperar o tempo de Deus para todas as coisas.', _patience, 'q2'),
              _buildRadioGroup('Sou paciente em situações difíceis e desafiadoras.', _patience, 'q3'),
              _buildRadioGroup('Busco entender e perdoar as falhas dos outros.', _patience, 'q4'),
              _buildRadioGroup('Sinto que a paciência é uma virtude que Deus está desenvolvendo em mim.', _patience, 'q5'),
              SizedBox(height: 16),
              Text('Seção 5: Bondade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Sou generoso(a) e gosto de ajudar as pessoas sem esperar nada em troca.', _kindness, 'q1'),
              _buildRadioGroup('Gosto de realizar pequenos atos de gentileza no meu dia a dia.', _kindness, 'q2'),
              _buildRadioGroup('Sou compassivo(a) com quem está passando por dificuldades.', _kindness, 'q3'),
              _buildRadioGroup('Busco tratar todas as pessoas com respeito e dignidade.', _kindness, 'q4'),
              _buildRadioGroup('Minha bondade reflete o amor de Deus nas minhas atitudes.', _kindness, 'q5'),
              SizedBox(height: 16),
              Text('Seção 6: Benignidade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Procuro ser uma influência positiva na vida das pessoas ao meu redor.', _goodness, 'q1'),
              _buildRadioGroup('Faço o possível para evitar causar mal ou prejuízo a alguém.', _goodness, 'q2'),
              _buildRadioGroup('Sou cuidadoso(a) nas palavras e ações para não ferir os outros.', _goodness, 'q3'),
              _buildRadioGroup('Acredito que a gentileza é uma força que transforma ambientes e corações.', _goodness, 'q4'),
              _buildRadioGroup('Minhas ações refletem o caráter de Cristo em situações cotidianas.', _goodness, 'q5'),
              SizedBox(height: 16),
              Text('Seção 7: Fidelidade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Sou fiel a Deus em meus compromissos e na prática da minha fé.', _faithfulness, 'q1'),
              _buildRadioGroup('As pessoas podem confiar em mim porque cumpro o que prometo.', _faithfulness, 'q2'),
              _buildRadioGroup('Sou leal aos meus relacionamentos e valores cristãos.', _faithfulness, 'q3'),
              _buildRadioGroup('Busco sempre ser íntegro(a) e confiável em tudo o que faço.', _faithfulness, 'q4'),
              _buildRadioGroup('Sinto um desejo constante de permanecer firme nos caminhos de Deus.', _faithfulness, 'q5'),
              SizedBox(height: 16),
              Text('Seção 8: Mansidão', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Sou uma pessoa calma e controlada, mesmo em situações de estresse.', _gentleness, 'q1'),
              _buildRadioGroup('Procuro resolver conflitos de maneira pacífica e amorosa.', _gentleness, 'q2'),
              _buildRadioGroup('Sou humilde e reconheço minhas limitações.', _gentleness, 'q3'),
              _buildRadioGroup('Busco tratar os outros com gentileza e respeito.', _gentleness, 'q4'),
              _buildRadioGroup('Sinto que a mansidão é uma característica importante do meu caráter.', _gentleness, 'q5'),
              SizedBox(height: 16),
              Text('Seção 9: Domínio Próprio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Consigo controlar minhas emoções e reações diante de provocações.', _selfControl, 'q1'),
              _buildRadioGroup('Tenho disciplina em manter hábitos saudáveis e espirituais.', _selfControl, 'q2'),
              _buildRadioGroup('Evito ceder a impulsos que sei que são prejudiciais ou pecaminosos.', _selfControl, 'q3'),
              _buildRadioGroup('Sou capaz de resistir a tentações, mesmo quando estou sob pressão.', _selfControl, 'q4'),
              _buildRadioGroup('Busco equilíbrio em todas as áreas da minha vida, confiando na direção de Deus.', _selfControl, 'q5'),
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