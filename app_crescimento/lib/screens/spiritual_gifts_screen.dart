import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpiritualGiftsScreen extends StatefulWidget {
  @override
  _SpiritualGiftsScreenState createState() => _SpiritualGiftsScreenState();
}

class _SpiritualGiftsScreenState extends State<SpiritualGiftsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final Map<String, int> _prophecy = {};
  final Map<String, int> _discernment = {};
  final Map<String, int> _tongues = {};
  final Map<String, int> _interpretation = {};
  final Map<String, int> _wisdom = {};
  final Map<String, int> _knowledge = {};
  final Map<String, int> _faith = {};
  final Map<String, int> _healing = {};
  final Map<String, int> _miracles = {};

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final int prophecy = _prophecy.values.isNotEmpty ? _prophecy.values.reduce((a, b) => a + b) : 0;
      final int discernment = _discernment.values.isNotEmpty ? _discernment.values.reduce((a, b) => a + b) : 0;
      final int tongues = _tongues.values.isNotEmpty ? _tongues.values.reduce((a, b) => a + b) : 0;
      final int interpretation = _interpretation.values.isNotEmpty ? _interpretation.values.reduce((a, b) => a + b) : 0;
      final int wisdom = _wisdom.values.isNotEmpty ? _wisdom.values.reduce((a, b) => a + b) : 0;
      final int knowledge = _knowledge.values.isNotEmpty ? _knowledge.values.reduce((a, b) => a + b) : 0;
      final int faith = _faith.values.isNotEmpty ? _faith.values.reduce((a, b) => a + b) : 0;
      final int healing = _healing.values.isNotEmpty ? _healing.values.reduce((a, b) => a + b) : 0;
      final int miracles = _miracles.values.isNotEmpty ? _miracles.values.reduce((a, b) => a + b) : 0;

      final Map<String, dynamic> result = {
        'user_id': 1, // Substitua pelo ID do usuário real
        'prophecy': prophecy,
        'discernment': discernment,
        'tongues': tongues,
        'interpretation': interpretation,
        'wisdom': wisdom,
        'knowledge': knowledge,
        'faith': faith,
        'healing': healing,
        'miracles': miracles,
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/spiritual_gifts'),
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
        title: Text('Questionário de Dons Espirituais'),
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
              Text('Seção 1: Profecia', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Frequentemente sinto que Deus coloca mensagens específicas em meu coração para compartilhar.', _prophecy, 'q1'),
              _buildRadioGroup('Tenho um desejo constante de falar a verdade com coragem e clareza.', _prophecy, 'q2'),
              _buildRadioGroup('Outros já confirmaram que palavras que compartilhei vieram de Deus.', _prophecy, 'q3'),
              _buildRadioGroup('Tenho facilidade em identificar quando algo está alinhado ou desalinhado com a Palavra de Deus.', _prophecy, 'q4'),
              _buildRadioGroup('Sinto que sou usado por Deus para edificar, exortar e consolar outras pessoas.', _prophecy, 'q5'),
              SizedBox(height: 16),
              Text('Seção 2: Discernimento de Espíritos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Consigo perceber a presença ou influência de forças espirituais em situações ou pessoas.', _discernment, 'q1'),
              _buildRadioGroup('Frequentemente sinto uma forte intuição sobre a origem divina ou maligna de algo.', _discernment, 'q2'),
              _buildRadioGroup('Já identifiquei quando algo parecia bom, mas não era de Deus.', _discernment, 'q3'),
              _buildRadioGroup('Tenho facilidade em reconhecer falsos ensinos ou práticas contrárias à Palavra de Deus.', _discernment, 'q4'),
              _buildRadioGroup('Sinto uma responsabilidade de alertar ou proteger outros contra enganos espirituais.', _discernment, 'q5'),
              SizedBox(height: 16),
              Text('Seção 3: Variedade de Línguas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho facilidade em orar em línguas ou busco intensamente este dom.', _tongues, 'q1'),
              _buildRadioGroup('Sinto que as línguas me ajudam a expressar melhor minha devoção a Deus.', _tongues, 'q2'),
              _buildRadioGroup('Já usei as línguas em momentos de oração intensa ou intercessão.', _tongues, 'q3'),
              _buildRadioGroup('Sinto que falar em línguas edifica meu espírito e minha conexão com Deus.', _tongues, 'q4'),
              _buildRadioGroup('Vejo o dom de línguas como uma expressão genuína do Espírito Santo.', _tongues, 'q5'),
              SizedBox(height: 16),
              Text('Seção 4: Interpretação de Línguas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Sinto que Deus me dá entendimento sobre mensagens espirituais em línguas.', _interpretation, 'q1'),
              _buildRadioGroup('Já tive experiências onde compreendi o significado de algo falado em línguas.', _interpretation, 'q2'),
              _buildRadioGroup('Acredito que a interpretação de línguas é essencial para edificação coletiva.', _interpretation, 'q3'),
              _buildRadioGroup('Sinto uma responsabilidade de trazer clareza e entendimento quando línguas são faladas.', _interpretation, 'q4'),
              _buildRadioGroup('Tenho um forte desejo de buscar e exercer este dom.', _interpretation, 'q5'),
              SizedBox(height: 16),
              Text('Seção 5: Palavra de Sabedoria', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho facilidade em oferecer conselhos baseados na Palavra de Deus para resolver situações complexas.', _wisdom, 'q1'),
              _buildRadioGroup('Consigo perceber a sabedoria divina em meio a situações difíceis.', _wisdom, 'q2'),
              _buildRadioGroup('Outros frequentemente me procuram em busca de orientação espiritual.', _wisdom, 'q3'),
              _buildRadioGroup('Sinto que Deus me dá discernimento para compreender a raiz dos problemas.', _wisdom, 'q4'),
              _buildRadioGroup('Tenho habilidade em aplicar verdades bíblicas em decisões práticas.', _wisdom, 'q5'),
              SizedBox(height: 16),
              Text('Seção 6: Palavra de Conhecimento', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Frequentemente percebo informações sobre pessoas ou situações que não poderiam ser conhecidas naturalmente.', _knowledge, 'q1'),
              _buildRadioGroup('Já tive momentos em que sabia algo específico sobre alguém que confirmou uma direção divina.', _knowledge, 'q2'),
              _buildRadioGroup('Tenho facilidade em compreender as Escrituras de forma profunda e aplicada.', _knowledge, 'q3'),
              _buildRadioGroup('Sinto que Deus me revela verdades para compartilhar com outros no momento certo.', _knowledge, 'q4'),
              _buildRadioGroup('Tenho um desejo constante de aprender mais sobre Deus e Sua Palavra.', _knowledge, 'q5'),
              SizedBox(height: 16),
              Text('Seção 7: Fé', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho confiança inabalável em Deus mesmo em situações difíceis.', _faith, 'q1'),
              _buildRadioGroup('Outros frequentemente se sentem encorajados pela minha atitude de fé.', _faith, 'q2'),
              _buildRadioGroup('Já vivi experiências onde confiei em Deus para o impossível e vi resultados.', _faith, 'q3'),
              _buildRadioGroup('Sinto que Deus me deu a habilidade de acreditar em Sua provisão em qualquer circunstância.', _faith, 'q4'),
              _buildRadioGroup('Sou motivado a orar com ousadia por coisas que parecem inatingíveis.', _faith, 'q5'),
              SizedBox(height: 16),
              Text('Seção 8: Dons de Cura', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Já senti um forte desejo de orar pela cura física ou emocional de outras pessoas.', _healing, 'q1'),
              _buildRadioGroup('Acredito que Deus deseja e pode curar pessoas hoje como fazia no passado.', _healing, 'q2'),
              _buildRadioGroup('Já testemunhei ou experimentei curas após orar ou impor as mãos sobre alguém.', _healing, 'q3'),
              _buildRadioGroup('Tenho empatia profunda por pessoas que sofrem com doenças ou dores.', _healing, 'q4'),
              _buildRadioGroup('Sinto que Deus pode me usar como um instrumento de cura em diferentes situações.', _healing, 'q5'),
              SizedBox(height: 16),
              Text('Seção 9: Operação de Milagres', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho fé de que Deus pode operar milagres através de mim para mostrar Seu poder.', _miracles, 'q1'),
              _buildRadioGroup('Já vivi ou testemunhei milagres que desafiam a lógica e a ciência.', _miracles, 'q2'),
              _buildRadioGroup('Sinto uma convicção forte de que Deus ainda faz obras sobrenaturais hoje.', _miracles, 'q3'),
              _buildRadioGroup('Tenho facilidade em acreditar em intervenções sobrenaturais em situações extremas.', _miracles, 'q4'),
              _buildRadioGroup('Outros me reconhecem como uma pessoa que inspira esperança em Deus para o impossível.', _miracles, 'q5'),
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