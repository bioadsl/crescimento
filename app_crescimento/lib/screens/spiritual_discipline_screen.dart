import 'package:flutter/material.dart';

class SpiritualDisciplineScreen extends StatefulWidget {
  @override
  _SpiritualDisciplineScreenState createState() => _SpiritualDisciplineScreenState();
}

class _SpiritualDisciplineScreenState extends State<SpiritualDisciplineScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final Map<String, int> _prayer = {};
  final Map<String, int> _bibleReading = {};
  final Map<String, int> _fasting = {};
  final Map<String, int> _meditation = {};
  final Map<String, int> _worship = {};
  final Map<String, int> _fellowship = {};
  final Map<String, int> _service = {};
  final Map<String, int> _silence = {};
  final Map<String, int> _generosity = {};

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final int prayer = _prayer.values.isNotEmpty ? _prayer.values.reduce((a, b) => a + b) : 0;
      final int bibleReading = _bibleReading.values.isNotEmpty ? _bibleReading.values.reduce((a, b) => a + b) : 0;
      final int fasting = _fasting.values.isNotEmpty ? _fasting.values.reduce((a, b) => a + b) : 0;
      final int meditation = _meditation.values.isNotEmpty ? _meditation.values.reduce((a, b) => a + b) : 0;
      final int worship = _worship.values.isNotEmpty ? _worship.values.reduce((a, b) => a + b) : 0;
      final int fellowship = _fellowship.values.isNotEmpty ? _fellowship.values.reduce((a, b) => a + b) : 0;
      final int service = _service.values.isNotEmpty ? _service.values.reduce((a, b) => a + b) : 0;
      final int silence = _silence.values.isNotEmpty ? _silence.values.reduce((a, b) => a + b) : 0;
      final int generosity = _generosity.values.isNotEmpty ? _generosity.values.reduce((a, b) => a + b) : 0;

      final Map<String, dynamic> result = {
        'user_id': 1, // Substitua pelo ID do usuário real
        'prayer': prayer,
        'bibleReading': bibleReading,
        'fasting': fasting,
        'meditation': meditation,
        'worship': worship,
        'fellowship': fellowship,
        'service': service,
        'silence': silence,
        'generosity': generosity,
      };

      // Enviar os resultados para o servidor ou processá-los conforme necessário
      print(result);
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
        title: Text('Questionário de Disciplinas Espirituais'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'INSTRUÇÕES\nResponda a cada pergunta com sinceridade, escolhendo a opção que melhor descreve você. Use uma escala de 1 a 5, onde:\n1 = Não me descreve.\n5 = Descreve perfeitamente.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text('Seção 1: Oração', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Eu reservo um tempo diário para orar e conversar com Deus.', _prayer, 'q1'),
              _buildRadioGroup('Durante minhas orações, busco não apenas pedir, mas também ouvir o que Deus quer me dizer.', _prayer, 'q2'),
              _buildRadioGroup('A oração é uma parte vital da minha vida espiritual, e eu não me sinto completo(a) sem ela.', _prayer, 'q3'),
              _buildRadioGroup('Eu oro em momentos de alegria e em momentos de dificuldades, confiando em Deus sempre.', _prayer, 'q4'),
              _buildRadioGroup('Sinto que minha vida de oração tem me aproximado cada vez mais de Deus.', _prayer, 'q5'),
              SizedBox(height: 16),
              Text('Seção 2: Leitura da Bíblia', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Eu leio a Bíblia regularmente e busco entendê-la em meu dia a dia.', _bibleReading, 'q1'),
              _buildRadioGroup('Tenho o hábito de meditar nas Escrituras e refletir sobre como elas se aplicam à minha vida.', _bibleReading, 'q2'),
              _buildRadioGroup('A leitura da Bíblia é algo que me alimenta espiritualmente e me fortalece.', _bibleReading, 'q3'),
              _buildRadioGroup('Busco conhecer melhor a Palavra de Deus para crescer em sabedoria e discernimento.', _bibleReading, 'q4'),
              _buildRadioGroup('Sinto que a Bíblia é um guia constante na minha vida, iluminando meus passos.', _bibleReading, 'q5'),
              SizedBox(height: 16),
              Text('Seção 3: Jejum', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Eu pratico o jejum como uma forma de buscar mais intimidade com Deus.', _fasting, 'q1'),
              _buildRadioGroup('Durante o jejum, eu me concentro em orar e refletir sobre minha relação com Deus.', _fasting, 'q2'),
              _buildRadioGroup('O jejum é uma disciplina que me ajuda a colocar Deus em primeiro lugar, acima das minhas necessidades físicas.', _fasting, 'q3'),
              _buildRadioGroup('Sinto que o jejum me traz crescimento espiritual e me ajuda a depender mais de Deus.', _fasting, 'q4'),
              _buildRadioGroup('Eu tenho aprendido a ser mais sensível à voz de Deus durante os períodos de jejum.', _fasting, 'q5'),
              SizedBox(height: 16),
              Text('Seção 4: Meditação', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Eu reservo momentos para meditar nas coisas de Deus e refletir sobre Suas verdades.', _meditation, 'q1'),
              _buildRadioGroup('A meditação me ajuda a acalmar minha mente e sentir a presença de Deus.', _meditation, 'q2'),
              _buildRadioGroup('Eu busco focar em passagens bíblicas e deixar que elas penetrem no meu coração.', _meditation, 'q3'),
              _buildRadioGroup('A meditação me ajuda a aplicar as Escrituras em minha vida de forma prática.', _meditation, 'q4'),
              _buildRadioGroup('Eu encontro paz e clareza espiritual quando pratico a meditação.', _meditation, 'q5'),
              SizedBox(height: 16),
              Text('Seção 5: Adoração', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Eu busco adorar a Deus não apenas em cultos, mas também em minha vida diária.', _worship, 'q1'),
              _buildRadioGroup('Eu sinto que a adoração é uma forma de entregar meu coração e minha vida a Deus.', _worship, 'q2'),
              _buildRadioGroup('Tenho o hábito de louvar a Deus por Suas qualidades e ações, não apenas em momentos especiais, mas continuamente.', _worship, 'q3'),
              _buildRadioGroup('Eu me sinto renovado(a) espiritualmente sempre que estou envolvido(a) em adoração.', _worship, 'q4'),
              _buildRadioGroup('A adoração é uma expressão constante de gratidão a Deus por tudo o que Ele é e faz.', _worship, 'q5'),
              SizedBox(height: 16),
              Text('Seção 6: Comunhão', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Eu busco cultivar relacionamentos saudáveis com outros cristãos e compartilhar minha fé com eles.', _fellowship, 'q1'),
              _buildRadioGroup('Eu participo ativamente de uma igreja ou grupo de fé, e estou disposto(a) a servir aos outros.', _fellowship, 'q2'),
              _buildRadioGroup('Eu acredito que a comunhão com os irmãos em Cristo é vital para meu crescimento espiritual.', _fellowship, 'q3'),
              _buildRadioGroup('Eu sou intencional em apoiar e ser apoiado(a) por outros cristãos na caminhada de fé.', _fellowship, 'q4'),
              _buildRadioGroup('A comunhão com outros cristãos fortalece minha vida espiritual e me encoraja a viver de acordo com os princípios de Deus.', _fellowship, 'q5'),
              SizedBox(height: 16),
              Text('Seção 7: Serviço', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Eu busco ser uma bênção para os outros, servindo de forma prática e amorosa.', _service, 'q1'),
              _buildRadioGroup('O serviço aos outros é uma forma de adoração a Deus para mim.', _service, 'q2'),
              _buildRadioGroup('Eu sou sensível às necessidades ao meu redor e me esforço para ajudar sempre que posso.', _service, 'q3'),
              _buildRadioGroup('Eu vejo no serviço a oportunidade de refletir o amor de Cristo de maneira tangível.', _service, 'q4'),
              _buildRadioGroup('O serviço é uma das maneiras pelas quais eu expresso meu compromisso com a fé cristã.', _service, 'q5'),
              SizedBox(height: 16),
              Text('Seção 8: Disciplina de Silêncio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Eu pratico momentos de silêncio para ouvir a voz de Deus e refletir sobre minha vida.', _silence, 'q1'),
              _buildRadioGroup('Encontro paz e renovação espiritual no silêncio e na quietude.', _silence, 'q2'),
              _buildRadioGroup('Eu busco momentos regulares para desconectar das distrações e me concentrar em Deus.', _silence, 'q3'),
              _buildRadioGroup('Durante o silêncio, busco discernir a vontade de Deus para minha vida.', _silence, 'q4'),
              _buildRadioGroup('A disciplina do silêncio tem me ajudado a crescer em paciência e autoconhecimento.', _silence, 'q5'),
              SizedBox(height: 16),
              Text('Seção 9: Generosidade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildRadioGroup('Eu sou generoso(a) com meu tempo, meus recursos e meus talentos.', _generosity, 'q1'),
              _buildRadioGroup('Eu sinto que Deus me chamou a ser uma bênção financeira e material para outros.', _generosity, 'q2'),
              _buildRadioGroup('A generosidade é uma expressão de minha gratidão a Deus por tudo o que Ele me deu.', _generosity, 'q3'),
              _buildRadioGroup('Eu busco ser sensível às necessidades dos outros e agir conforme Deus me orienta.', _generosity, 'q4'),
              _buildRadioGroup('A prática da generosidade tem me aproximado mais de Deus e do Seu coração.', _generosity, 'q5'),
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