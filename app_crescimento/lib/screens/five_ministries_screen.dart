import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FiveMinistriesScreen extends StatefulWidget {
  @override
  _FiveMinistriesScreenState createState() => _FiveMinistriesScreenState();
}

class _FiveMinistriesScreenState extends State<FiveMinistriesScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final Map<String, int> _apostolic = {};
  final Map<String, int> _prophetic = {};
  final Map<String, int> _evangelistic = {};
  final Map<String, int> _pastoral = {};
  final Map<String, int> _teaching = {};

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final int apostolic = _apostolic.values.reduce((a, b) => a + b);
      final int prophetic = _prophetic.values.reduce((a, b) => a + b);
      final int evangelistic = _evangelistic.values.reduce((a, b) => a + b);
      final int pastoral = _pastoral.values.reduce((a, b) => a + b);
      final int teaching = _teaching.values.reduce((a, b) => a + b);

      final Map<String, dynamic> result = {
        'user_id': 1, // Substitua pelo ID do usuário real
        'apostolic': apostolic,
        'prophetic': prophetic,
        'evangelistic': evangelistic,
        'pastoral': pastoral,
        'teaching': teaching,
        'timestamp': DateTime.now().toIso8601String(), // Add this line if you need to include a timestamp
      };


      final response = await http.post(
        Uri.parse('http://localhost:8080/five_ministries'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(result),
      );

      if (response.statusCode == 200) {
        final Map<String, int> scores = {
          'Apostólico': apostolic,
          'Profético': prophetic,
          'Evangelístico': evangelistic,
          'Pastoral': pastoral,
          'Ensino': teaching,
        };

        final String predominantMinistry = scores.entries.reduce((a, b) => a.value > b.value ? a : b).key;

        final Map<String, String> descriptions = {
          'Apostólico': "Ministério Apostólico: Você tem um chamado para iniciar novos projetos e liderar pessoas.",
          'Profético': "Ministério Profético: Você tem uma forte sensibilidade espiritual e um desejo de corrigir injustiças.",
          'Evangelístico': "Ministério Evangelístico: Você tem paixão por compartilhar o evangelho com novas pessoas.",
          'Pastoral': "Ministério Pastoral: Você tem um grande amor pelas pessoas e deseja ajudá-las a crescer em sua fé.",
          'Ensino': "Ministério de Ensino: Você tem facilidade para explicar conceitos bíblicos e ajudar outros a crescerem em conhecimento.",
        };

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Resultado'),
            content: Text(descriptions[predominantMinistry]!),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle error
        print('Failed to submit result');
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
                Text('${index + 1}'),
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
        title: Text('Questionário dos 5 Ministérios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('INSTRUÇÕES\nResponda cada pergunta com sinceridade, escolhendo a opção que melhor descreve você. Use uma escala de 1 a 5, onde:\n1 = Não me descreve.\n5 = Descreve perfeitamente.', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Ministério Apostólico', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Gosto de começar novos projetos ou empreendimentos que promovam o Reino de Deus.', _apostolic, 'q1'),
              _buildRadioGroup('Tenho facilidade para liderar e inspirar pessoas a seguirem uma visão.', _apostolic, 'q2'),
              _buildRadioGroup('Sinto um chamado para alcançar lugares ou pessoas que ainda não ouviram o evangelho.', _apostolic, 'q3'),
              _buildRadioGroup('Tenho interesse em estruturar igrejas ou ministérios de maneira organizada e funcional.', _apostolic, 'q4'),
              _buildRadioGroup('Consigo identificar talentos nas pessoas e ajudá-las a desenvolverem suas habilidades espirituais.', _apostolic, 'q5'),
              SizedBox(height: 16),
              Text('Ministério Profético', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho uma forte sensibilidade espiritual e consigo discernir o que Deus está falando.', _prophetic, 'q1'),
              _buildRadioGroup('Frequentemente sinto o desejo de corrigir injustiças ou de confrontar situações contrárias à Palavra de Deus.', _prophetic, 'q2'),
              _buildRadioGroup('Tenho facilidade em encorajar outros a ouvirem a Deus e buscarem Sua direção.', _prophetic, 'q3'),
              _buildRadioGroup('Sinto que minha vida é direcionada pela oração e pela busca constante da vontade de Deus.', _prophetic, 'q4'),
              _buildRadioGroup('Às vezes percebo ou sinto coisas espirituais antes de acontecerem.', _prophetic, 'q5'),
              SizedBox(height: 16),
              Text('Ministério Evangelístico', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho paixão por compartilhar o evangelho com pessoas que ainda não conhecem Jesus.', _evangelistic, 'q1'),
              _buildRadioGroup('Gosto de estar em contato com pessoas de diferentes contextos e culturas para falar de Cristo.', _evangelistic, 'q2'),
              _buildRadioGroup('Sinto que sou chamado a trazer novas pessoas para a igreja e para o Reino de Deus.', _evangelistic, 'q3'),
              _buildRadioGroup('Tenho facilidade para iniciar conversas sobre Jesus com desconhecidos.', _evangelistic, 'q4'),
              _buildRadioGroup('Fico motivado ao ver vidas transformadas pelo evangelho.', _evangelistic, 'q5'),
              SizedBox(height: 16),
              Text('Ministério Pastoral', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho um grande amor pelas pessoas e desejo ajudá-las a crescer em sua fé.', _pastoral, 'q1'),
              _buildRadioGroup('Tenho facilidade para aconselhar e orientar pessoas em momentos difíceis.', _pastoral, 'q2'),
              _buildRadioGroup('Sinto um chamado para cuidar do bem-estar espiritual, emocional e físico de outros.', _pastoral, 'q3'),
              _buildRadioGroup('Preocupo-me com a unidade e harmonia dentro da igreja ou do grupo que participo.', _pastoral, 'q4'),
              _buildRadioGroup('Sou paciente e compreensivo ao lidar com as falhas e dificuldades das pessoas.', _pastoral, 'q5'),
              SizedBox(height: 16),
              Text('Ministério de Ensino', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho facilidade para explicar conceitos bíblicos de maneira clara e compreensível.', _teaching, 'q1'),
              _buildRadioGroup('Gosto de estudar profundamente a Bíblia e compartilhar o que aprendo.', _teaching, 'q2'),
              _buildRadioGroup('Tenho paixão por ajudar outros a crescerem em conhecimento e sabedoria espiritual.', _teaching, 'q3'),
              _buildRadioGroup('Sinto alegria em preparar e ministrar estudos ou pregações.', _teaching, 'q4'),
              _buildRadioGroup('Fico motivado quando vejo outros aplicando o que aprenderam através de meus ensinamentos.', _teaching, 'q5'),
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