import 'package:flutter/material.dart';
import 'package:crescimento/screens/five_ministries_screen.dart';
import 'package:crescimento/screens/dashboard_screen.dart';
import 'package:crescimento/screens/fruit_of_the_spirit_screen.dart';
import 'package:crescimento/screens/intimacy_level_screen.dart';
import 'package:crescimento/screens/spiritual_discipline_screen.dart'; // Verifique se esse import está correto
import 'package:crescimento/screens/pillar_screen.dart';
import 'package:crescimento/screens/spiritual_gifts_screen.dart';
import 'package:crescimento/screens/apostolic_year_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raio X Pessoal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FiveMinistriesScreen()),
                );
              },
              child: Text('Descubra seu Ministério'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FruitOfTheSpiritScreen()),
                );
              },
              child: Text('Frutos do Espírito'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IntimacyLevelScreen()),
                );
              },
              child: Text('Níveis de Intimidade'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpiritualDisciplineScreen()),
                );
              },
              child: Text('Disciplinas Espirituais'),
            ),
            // SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => MissionItemScreen()),
            //     );
            //   },
            //   child: Text('Missão CAP'),
            // ),
      
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpiritualGiftsScreen()),
                );
              },
              child: Text('Dons Espirituais'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PillarScreen()),
                );
              },
              child: Text('Pilares CAP'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApostolicYearScreen()),
                );
              },
              child: Text('Ano Apostólico'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
              child: Text('Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}