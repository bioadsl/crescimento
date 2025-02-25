import 'package:flutter/material.dart';
import 'package:app_crescimento/screens/five_ministries_screen.dart';
import 'package:app_crescimento/screens/dashboard_screen.dart';
import 'package:app_crescimento/screens/fruit_of_the_spirit_screen.dart';
import 'package:app_crescimento/screens/intimacy_level_screen.dart';
import 'package:app_crescimento/screens/spiritual_discipline_screen.dart';
import 'package:app_crescimento/screens/pillar_screen.dart';
import 'package:app_crescimento/screens/spiritual_gifts_screen.dart';
import 'package:app_crescimento/screens/apostolic_year_screen.dart';
import 'package:app_crescimento/screens/history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raio X Pessoal'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildMenuCard(
                context,
                'Descubra seu Ministério',
                Icons.person_search,
                Colors.blue,
                const FiveMinistriesScreen(),
              ),
              _buildMenuCard(
                context,
                'Frutos do Espírito',
                Icons.local_florist,
                Colors.green,
                const FruitOfTheSpiritScreen(),
              ),
              _buildMenuCard(
                context,
                'Níveis de Intimidade',
                Icons.favorite,
                Colors.red,
                const IntimacyLevelScreen(),
              ),
              _buildMenuCard(
                context,
                'Disciplinas Espirituais',
                Icons.book,
                Colors.purple,
                const SpiritualDisciplineScreen(),
              ),
              _buildMenuCard(
                context,
                'Dons Espirituais',
                Icons.card_giftcard,
                Colors.orange,
                const SpiritualGiftsScreen(),
              ),
              _buildMenuCard(
                context,
                'Pilares CAP',
                Icons.foundation,
                Colors.brown,
                const PillarScreen(),
              ),
              _buildMenuCard(
                context,
                'Ano Apostólico',
                Icons.calendar_today,
                Colors.teal,
                const ApostolicYearScreen(),
              ),
              _buildMenuCard(
                context,
                'Dashboard',
                Icons.dashboard,
                Colors.indigo,
                const DashboardScreen(),
              ),
              _buildButton(
                context,
                'Histórico',
                Icons.history,
                Colors.purple,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Color color, Widget screen) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, IconData icon, Color color, VoidCallback onPressed) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}