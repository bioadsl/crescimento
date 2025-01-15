import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PillarScreen extends StatefulWidget {
  @override
  _PillarScreenState createState() => _PillarScreenState();
}

class _PillarScreenState extends State<PillarScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final Map<String, int> _missions = {};
  final Map<String, int> _teaching = {};
  final Map<String, int> _worship = {};
  final Map<String, int> _discipleship = {};

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final int missions = _missions.values.isNotEmpty ? _missions.values.reduce((a, b) => a + b) : 0;
      final int teaching = _teaching.values.isNotEmpty ? _teaching.values.reduce((a, b) => a + b) : 0;
      final int worship = _worship.values.isNotEmpty ? _worship.values.reduce((a, b) => a + b) : 0;
      final int discipleship = _discipleship.values.isNotEmpty ? _discipleship.values.reduce((a, b) => a + b) : 0;

      final Map<String, dynamic> result = {
        'user_id': 1, // Substitua pelo ID do usuário real
        'missions': missions,
        'teaching': teaching,
        'worship': worship,
        'discipleship': discipleship,
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/pillars'),
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
        title: Text('Questionário dos Pilares da Igreja CAP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'INSTRUÇÕES\nResponda cada pergunta com sinceridade, escolhendo a opção que melhor descreve você. Use uma escala de 1 a 5, onde:\n1 = Nunca.\n5 = Sempre.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text('Seção 1: Missões', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Busco ativamente compartilhar o evangelho com pessoas fora da igreja.', _missions, 'q1'),
              _buildRadioGroup('Participo de projetos missionários locais ou internacionais organizados pela igreja.', _missions, 'q2'),
              _buildRadioGroup('Oro regularmente por missionários e projetos de evangelização.', _missions, 'q3'),
              _buildRadioGroup('Apoio financeiramente ou com recursos as iniciativas de missões.', _missions, 'q4'),
              _buildRadioGroup('Sinto um chamado para alcançar aqueles que ainda não conhecem a Cristo.', _missions, 'q5'),
              SizedBox(height: 16),
              Text('Seção 2: Ensino', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Tenho o hábito de ensinar ou compartilhar o que aprendo da Palavra de Deus com outras pessoas.', _teaching, 'q1'),
              _buildRadioGroup('Participo de cursos, seminários ou treinamentos promovidos pela igreja.', _teaching, 'q2'),
              _buildRadioGroup('Busco aplicar os ensinamentos bíblicos na minha vida diária.', _teaching, 'q3'),
              _buildRadioGroup('Estudo e aprofundo meu conhecimento sobre a Bíblia e a fé cristã.', _teaching, 'q4'),
              _buildRadioGroup('Sinto-me responsável por ajudar outros a crescerem no conhecimento de Deus.', _teaching, 'q5'),
              SizedBox(height: 16),
              Text('Seção 3: Adoração', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Dedico momentos pessoais e coletivos para adorar a Deus.', _worship, 'q1'),
              _buildRadioGroup('Participo regularmente dos cultos e eventos de adoração na igreja.', _worship, 'q2'),
              _buildRadioGroup('Sinto que minha vida reflete um coração voltado para a adoração contínua.', _worship, 'q3'),
              _buildRadioGroup('Reconheço a soberania de Deus em todas as áreas da minha vida.', _worship, 'q4'),
              _buildRadioGroup('A adoração não é apenas um momento de música, mas uma atitude constante.', _worship, 'q5'),
              SizedBox(height: 16),
              Text('Seção 4: Discipulado', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Participo de grupos de discipulado ou acompanho alguém espiritualmente.', _discipleship, 'q1'),
              _buildRadioGroup('Busco ser discipulado(a) por alguém mais experiente na fé.', _discipleship, 'q2'),
              _buildRadioGroup('Ajudo outros a crescerem espiritualmente através de orientação e apoio.', _discipleship, 'q3'),
              _buildRadioGroup('Comprometo-me com o crescimento espiritual de outros membros da igreja.', _discipleship, 'q4'),
              _buildRadioGroup('Entendo que o discipulado é um processo contínuo e estou disposto(a) a aprender e ensinar.', _discipleship, 'q5'),
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