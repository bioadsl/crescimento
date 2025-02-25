import 'package:flutter/material.dart';

class MissionItemScreen extends StatefulWidget {
  const MissionItemScreen({super.key});

  @override
  _MissionItemScreenState createState() => _MissionItemScreenState();
}

class _MissionItemScreenState extends State<MissionItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, int> _missionItems = {};

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      final result = {
        'missionItems': _missionItems.values.reduce((a, b) => a + b),
      };

      // Save or process the result object as needed
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
        title: const Text('Missões'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildRadioGroup('Missões', _missionItems, 'missionItems'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}