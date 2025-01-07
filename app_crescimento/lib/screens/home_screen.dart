import 'package:flutter/material.dart';
import 'package:crescimento/models/daily_record.dart'; // Atualize esta linha
import 'package:crescimento/models/ministry.dart';
import 'package:crescimento/models/fruit_of_the_spirit.dart';
import 'package:crescimento/models/intimacy_level.dart';
import 'package:crescimento/models/spiritual_discipline.dart';
import 'package:crescimento/models/mission_item.dart';
import 'package:crescimento/models/pillar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final TextEditingController _apostolicController = TextEditingController();
  final TextEditingController _propheticController = TextEditingController();
  final TextEditingController _evangelisticController = TextEditingController();
  final TextEditingController _pastoralController = TextEditingController();
  final TextEditingController _teachingController = TextEditingController();
  final TextEditingController _loveController = TextEditingController();
  final TextEditingController _joyController = TextEditingController();
  final TextEditingController _peaceController = TextEditingController();
  final TextEditingController _patienceController = TextEditingController();
  final TextEditingController _intimacyLevelController = TextEditingController();
  final TextEditingController _spiritualDisciplinesController = TextEditingController();
  final TextEditingController _missionItemsController = TextEditingController();
  final TextEditingController _pillarsController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _apostolicController.dispose();
    _propheticController.dispose();
    _evangelisticController.dispose();
    _pastoralController.dispose();
    _teachingController.dispose();
    _loveController.dispose();
    _joyController.dispose();
    _peaceController.dispose();
    _patienceController.dispose();
    _intimacyLevelController.dispose();
    _spiritualDisciplinesController.dispose();
    _missionItemsController.dispose();
    _pillarsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      final dailyRecord = DailyRecord(
        ministry: Ministry(
          apostolic: int.parse(_apostolicController.text),
          prophetic: int.parse(_propheticController.text),
          evangelistic: int.parse(_evangelisticController.text),
          pastoral: int.parse(_pastoralController.text),
          teaching: int.parse(_teachingController.text),
        ),
        fruitOfTheSpirit: FruitOfTheSpirit(
          love: int.parse(_loveController.text),
          joy: int.parse(_joyController.text),
          peace: int.parse(_peaceController.text),
          patience: int.parse(_patienceController.text),
        ),
        intimacyLevel: IntimacyLevel(level: _intimacyLevelController.text),
        spiritualDiscipline: SpiritualDiscipline(
          disciplines: _spiritualDisciplinesController.text.split(','),
        ),
        missionItem: MissionItem(items: _missionItemsController.text.split(',')),
        pillar: Pillar(pillars: _pillarsController.text.split(',')),
      );

      // Save or process the dailyRecord object as needed
      print(dailyRecord.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionário Diário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('5 Ministérios', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _apostolicController,
                decoration: InputDecoration(labelText: 'Apostólico'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _propheticController,
                decoration: InputDecoration(labelText: 'Profético'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _evangelisticController,
                decoration: InputDecoration(labelText: 'Evangelístico'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _pastoralController,
                decoration: InputDecoration(labelText: 'Pastoral'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _teachingController,
                decoration: InputDecoration(labelText: 'Ensino'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SizedBox(height: 16),
              Text('Frutos do Espírito', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _loveController,
                decoration: InputDecoration(labelText: 'Amor'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _joyController,
                decoration: InputDecoration(labelText: 'Alegria'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _peaceController,
                decoration: InputDecoration(labelText: 'Paz'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _patienceController,
                decoration: InputDecoration(labelText: 'Paciência'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SizedBox(height: 16),
              Text('Níveis de Intimidade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _intimacyLevelController,
                decoration: InputDecoration(labelText: 'Nível de Intimidade'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SizedBox(height: 16),
              Text('Disciplinas Espirituais', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _spiritualDisciplinesController,
                decoration: InputDecoration(labelText: 'Disciplinas Espirituais (separadas por vírgula)'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SizedBox(height: 16),
              Text('Missões', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _missionItemsController,
                decoration: InputDecoration(labelText: 'Missões (separadas por vírgula)'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SizedBox(height: 16),
              Text('Pilares', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _pillarsController,
                decoration: InputDecoration(labelText: 'Pilares (separados por vírgula)'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
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