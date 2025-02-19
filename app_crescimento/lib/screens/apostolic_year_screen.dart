import 'package:flutter/material.dart';

class ApostolicYearScreen extends StatelessWidget {
  const ApostolicYearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> months = [
      {
        'month': 'Janeiro',
        'title': 'Mês da Visão',
        'icon': Icons.visibility,
        'color': Colors.blue.shade400,
        'description': 'Tempo de buscar direção e propósito para o ano.',
        'activities': [
          'Definir metas espirituais para o ano',
          'Planejar leituras bíblicas sistemáticas',
          'Estabelecer alvos ministeriais',
          'Buscar direção em oração e jejum',
        ],
      },
      {
        'month': 'Fevereiro',
        'title': 'Mês do Discipulado',
        'icon': Icons.people,
        'color': Colors.green.shade400,
        'description': 'Foco em crescimento e mentoria espiritual.',
        'activities': [
          'Encontros regulares de discipulado',
          'Estudos bíblicos em grupo',
          'Treinamento de novos líderes',
          'Acompanhamento pastoral personalizado',
        ],
      },
      {
        'month': 'Março',
        'title': 'Mês da Família',
        'icon': Icons.family_restroom,
        'color': Colors.red.shade400,
        'description': 'Fortalecimento dos laços familiares e vida devocional em família.',
        'activities': [
          'Cultos em família',
          'Momentos de oração em conjunto',
          'Atividades familiares edificantes',
          'Estudos bíblicos para casais',
        ],
      },
      {
        'month': 'Abril',
        'title': 'Mês da Evangelização',
        'icon': Icons.share,
        'color': Colors.orange.shade400,
        'description': 'Alcance de vidas através do evangelho.',
        'activities': [
          'Ações evangelísticas',
          'Treinamento em evangelismo',
          'Eventos de alcance comunitário',
          'Testemunho pessoal intencional',
        ],
      },
      {
        'month': 'Maio',
        'title': 'Mês do Serviço',
        'icon': Icons.volunteer_activism,
        'color': Colors.purple.shade400,
        'description': 'Desenvolvimento do coração servo e ações práticas.',
        'activities': [
          'Projetos sociais',
          'Trabalho voluntário',
          'Assistência comunitária',
          'Ações de solidariedade',
        ],
      },
      {
        'month': 'Junho',
        'title': 'Mês da Adoração',
        'icon': Icons.music_note,
        'color': Colors.indigo.shade400,
        'description': 'Aprofundamento na intimidade com Deus através do louvor.',
        'activities': [
          'Momentos especiais de adoração',
          'Estudos sobre louvor',
          'Desenvolvimento musical',
          'Vigílias de oração e louvor',
        ],
      },
      {
        'month': 'Julho',
        'title': 'Mês da Missão',
        'icon': Icons.public,
        'color': Colors.teal.shade400,
        'description': 'Foco na expansão do Reino através das missões.',
        'activities': [
          'Conferência missionária',
          'Apoio a missionários',
          'Viagens missionárias',
          'Intercessão por nações',
        ],
      },
      {
        'month': 'Agosto',
        'title': 'Mês do Avivamento',
        'icon': Icons.local_fire_department,
        'color': Colors.deepOrange.shade400,
        'description': 'Busca por renovação espiritual e poder do Espírito Santo.',
        'activities': [
          'Campanhas de oração',
          'Jejum coletivo',
          'Cultos de avivamento',
          'Busca por batismo no Espírito Santo',
        ],
      },
      {
        'month': 'Setembro',
        'title': 'Mês da Palavra',
        'icon': Icons.menu_book,
        'color': Colors.brown.shade400,
        'description': 'Aprofundamento no conhecimento das Escrituras.',
        'activities': [
          'Maratona bíblica',
          'Estudos temáticos',
          'Memorização de versículos',
          'Seminários bíblicos',
        ],
      },
      {
        'month': 'Outubro',
        'title': 'Mês da Colheita',
        'icon': Icons.grass,
        'color': Colors.lightGreen.shade400,
        'description': 'Tempo de colher os frutos do trabalho espiritual.',
        'activities': [
          'Batismos',
          'Apresentação de novos convertidos',
          'Testemunhos de transformação',
          'Celebração de vitórias',
        ],
      },
      {
        'month': 'Novembro',
        'title': 'Mês da Gratidão',
        'icon': Icons.favorite,
        'color': Colors.pink.shade400,
        'description': 'Desenvolvimento da gratidão e reconhecimento.',
        'activities': [
          'Cultos de gratidão',
          'Testemunhos de bênçãos',
          'Ações de graças',
          'Momentos de celebração',
        ],
      },
      {
        'month': 'Dezembro',
        'title': 'Mês da Restauração',
        'icon': Icons.healing,
        'color': Colors.cyan.shade400,
        'description': 'Cura, restauração e preparação para o novo ano.',
        'activities': [
          'Ministração de cura interior',
          'Aconselhamento pastoral',
          'Momentos de perdão e reconciliação',
          'Planejamento para o novo ano',
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ano Apostólico'),
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
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: months.length,
          itemBuilder: (context, index) {
            final month = months[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: month['color'].withOpacity(0.2),
                  child: Icon(
                    month['icon'],
                    color: month['color'],
                  ),
                ),
                title: Text(
                  month['month'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  month['title'],
                  style: TextStyle(
                    color: month['color'],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          month['description'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Atividades do Mês:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...month['activities'].map<Widget>((activity) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: month['color'],
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    activity,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Implementar função para baixar/compartilhar planejamento
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Em breve: Download do planejamento anual'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        icon: const Icon(Icons.download),
        label: const Text('Baixar Planejamento'),
      ),
    );
  }
}