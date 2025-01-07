import 'dart:io';

void main() {
  final sourceDirectory = 'crescimento';
  final targetDirectory = 'my_flutter_project';

  final directories = [
    'lib/models',
    'lib/screens',
    'lib/services',
    'lib/widgets',
    'test',
  ];

  final files = {
    'lib/models/user.dart': _userModel,
    'lib/models/daily_record.dart': _dailyRecordModel,
    'lib/screens/login_screen.dart': _loginScreen,
    'lib/screens/register_screen.dart': _registerScreen,
    'lib/screens/home_screen.dart': _homeScreen,
    'lib/screens/daily_record_screen.dart': _dailyRecordScreen,
    'lib/screens/report_screen.dart': _reportScreen,
    'lib/services/auth_service.dart': _authService,
    'lib/services/data_service.dart': _dataService,
    'lib/widgets/custom_button.dart': _customButton,
    'lib/widgets/custom_text_field.dart': _customTextField,
    'lib/main.dart': _mainFile,
    'pubspec.yaml': _pubspecYaml,
  };

  for (var dir in directories) {
    Directory('$targetDirectory/$dir').createSync(recursive: true);
  }

  files.forEach((path, content) {
    File('$targetDirectory/$path').writeAsStringSync(content);
  });

  print('Classes e arquivos integrados com sucesso no projeto $targetDirectory!');
}

const _userModel = '''
class User {
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password});
}
''';

const _dailyRecordModel = '''
class DailyRecord {
  final int apostolic;
  final int prophetic;
  final int evangelistic;
  final int pastoral;
  final int teaching;
  final int wisdom;
  final int faith;
  final int healing;
  final int prophecy;
  final int love;
  final int joy;
  final int peace;
  final int patience;
  final List<String> spiritualDisciplines;
  final String intimacyLevel;
  final List<String> missionItems;
  final List<String> pillars;

  DailyRecord({
    required this.apostolic,
    required this.prophetic,
    required this.evangelistic,
    required this.pastoral,
    required this.teaching,
    required this.wisdom,
    required this.faith,
    required this.healing,
    required this.prophecy,
    required this.love,
    required this.joy,
    required this.peace,
    required this.patience,
    required this.spiritualDisciplines,
    required this.intimacyLevel,
    required this.missionItems,
    required this.pillars,
  });
}
''';

const _loginScreen = '''
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar login
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
''';

const _registerScreen = '''
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Nome Completo'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar cadastro
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
''';

const _homeScreen = '''
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Bem-vindo ao App Crescimento!'),
      ),
    );
  }
}
''';

const _dailyRecordScreen = '''
import 'package:flutter/material.dart';

class DailyRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro Diário'),
      ),
      body: Center(
        child: Text('Tela de Registro Diário'),
      ),
    );
  }
}
''';

const _reportScreen = '''
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatórios'),
      ),
      body: Center(
        child: Text('Tela de Relatórios'),
      ),
    );
  }
}
''';

const _authService = '''
class AuthService {
  // Implementar métodos de autenticação
}
''';

const _dataService = '''
class DataService {
  // Implementar métodos de manipulação de dados
}
''';

const _customButton = '''
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
''';

const _customTextField = '''
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;

  CustomTextField({required this.labelText, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: labelText),
      obscureText: obscureText,
    );
  }
}
''';

const _mainFile = '''
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Crescimento',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
''';

const _pubspecYaml = '''
name: crescimento
description: App de Crescimento Espiritual
version: 1.0.0+1

environment:
  sdk: ">=2.12.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  # Adicione outras dependências aqui

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
''';