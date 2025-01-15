import 'package:flutter/material.dart';

class ApostolicYearScreen extends StatelessWidget {
  final Map<String, List<Map<String, String>>> themes = {
    "Janeiro: O Ano Apostólico de Novos Começos": [
      {"Semana 1 - Isaías 43:18-19": "Não vos lembreis das coisas passadas, nem considereis as antigas. Eis que faço uma coisa nova; agora sairá à luz; porventura não a percebeis?"},
      {"Semana 2 - 2 Coríntios 5:17": "Assim que, se alguém está em Cristo, nova criatura é; as coisas velhas já passaram; eis que tudo se fez novo."},
      {"Semana 3 - Lamentações 3:22-23": "As misericórdias do Senhor são a causa de não sermos consumidos; elas se renovam a cada manhã."},
    ],
    "Fevereiro: O Ano Apostólico Vivendo por Jesus": [
      {"Semana 1 - Gálatas 2:20": "Já estou crucificado com Cristo; e vivo, não mais eu, mas Cristo vive em mim."},
      {"Semana 2 - Filipenses 1:21": "Porque para mim o viver é Cristo, e o morrer é lucro."},
      {"Semana 3 - João 15:5": "Eu sou a videira, vós as varas; quem está em mim, e eu nele, esse dá muito fruto; porque sem mim nada podeis fazer."},
    ],
    "Março: O Ano Apostólico na Família": [
      {"Semana 1 - Josué 24:15": "Eu e a minha casa serviremos ao Senhor."},
      {"Semana 2 - Efésios 5:25": "Maridos, amai vossas mulheres, como também Cristo amou a igreja."},
      {"Semana 3 - Provérbios 22:6": "Ensina a criança no caminho em que deve andar, e, até quando envelhecer, não se desviará dele."},
    ],
    "Abril: O Ano Apostólico nas Finanças": [
      {"Semana 1 - Malaquias 3:10": "Trazei todos os dízimos à casa do tesouro, para que haja mantimento na minha casa."},
      {"Semana 2 - 2 Coríntios 9:7": "Cada um contribua segundo propôs no seu coração; não com tristeza ou por necessidade, porque Deus ama ao que dá com alegria."},
      {"Semana 3 - Provérbios 3:9-10": "Honra ao Senhor com os teus bens e com as primícias de toda a tua renda."},
    ],
    "Maio: O Ano Apostólico no Amor ao Próximo": [
      {"Semana 1 - João 13:34-35": "Um novo mandamento vos dou: Que vos ameis uns aos outros."},
      {"Semana 2 - 1 João 4:7-8": "Amados, amemo-nos uns aos outros; porque a caridade é de Deus."},
      {"Semana 3 - Romanos 12:10": "Amai-vos cordialmente uns aos outros com amor fraternal."},
    ],
    "Junho: O Ano Apostólico Testemunhando Jesus nas Redes Sociais": [
      {"Semana 1 - Marcos 16:15": "Ide por todo o mundo, pregai o evangelho a toda criatura."},
      {"Semana 2 - Mateus 5:16": "Assim resplandeça a vossa luz diante dos homens."},
      {"Semana 3 - 1 Pedro 3:15": "Estai sempre preparados para responder com mansidão e temor a qualquer que vos pedir a razão da esperança que há em vós."},
    ],
    "Julho: O Ano Apostólico Resistindo com Jesus contra o Maligno": [
      {"Semana 1 - Tiago 4:7": "Sujeitai-vos, pois, a Deus; resisti ao diabo, e ele fugirá de vós."},
      {"Semana 2 - Efésios 6:11": "Revesti-vos de toda a armadura de Deus, para que possais estar firmes contra as astutas ciladas do diabo."},
      {"Semana 3 - 1 João 4:4": "Maior é o que está em vós do que o que está no mundo."},
    ],
    "Agosto: O Ano Apostólico Vencendo a Carne": [
      {"Semana 1 - Gálatas 5:16": "Andai em Espírito, e não cumprireis a concupiscência da carne."},
      {"Semana 2 - Romanos 8:13": "Se pelo Espírito mortificardes as obras do corpo, vivereis."},
      {"Semana 3 - 1 Coríntios 9:27": "Antes subjugo o meu corpo, e o reduzo à servidão."},
    ],
    "Setembro: O Ano Apostólico Permanecendo com Jesus contra o Mundo": [
      {"Semana 1 - João 15:19": "Se vós fósseis do mundo, o mundo amaria o que era seu."},
      {"Semana 2 - Romanos 12:2": "Não vos conformeis com este mundo."},
      {"Semana 3 - 1 João 2:15": "Não ameis o mundo, nem o que no mundo há."},
    ],
    "Outubro: O Ano Apostólico Conectados a Jesus no Devocional": [
      {"Semana 1 - Salmos 119:105": "Lâmpada para os meus pés é tua palavra."},
      {"Semana 2 - Mateus 6:6": "Quando orares, entra no teu quarto."},
      {"Semana 3 - Josué 1:8": "Medita nele dia e noite."},
    ],
    "Novembro: O Ano Apostólico Superando com Jesus contra os Vícios": [
      {"Semana 1 - 1 Coríntios 6:12": "Todas as coisas me são lícitas, mas nem todas as coisas convêm."},
      {"Semana 2 - Filipenses 4:13": "Posso todas as coisas naquele que me fortalece."},
      {"Semana 3 - Gálatas 5:1": "Permanecei, pois, firmes na liberdade com que Cristo nos libertou."},
    ],
    "Dezembro: O Ano Apostólico Perseverando com Jesus até o Fim": [
      {"Semana 1 - Mateus 24:13": "Aquele que perseverar até o fim será salvo."},
      {"Semana 2 - 2 Timóteo 4:7": "Combati o bom combate, acabei a carreira, guardei a fé."},
      {"Semana 3 - Hebreus 12:1-2": "Corramos com paciência a carreira que nos está proposta."},
    ],
  };

  final Map<String, List<Map<String, List<Map<String, String>>>>> directions = {
    "1º Trimestre, Direcionamento 1: Evangelizar": [
      {
        "Janeiro: O Chamado para Evangelizar": [
          {"Semana 1 - Mateus 28:19-20": "Portanto, vão e façam discípulos de todas as nações..."},
          {"Semana 2 - Marcos 16:15": "Vão pelo mundo todo e preguem o evangelho a todas as pessoas."},
          {"Semana 3 - Romanos 10:14-15": "Como, pois, invocarão aquele em quem não creram?"}
        ]
      },
      {
        "Fevereiro: O Poder do Espírito Santo na Evangelização": [
          {"Semana 1 - Atos 1:8": "Mas receberão poder quando o Espírito Santo descer sobre vocês..."},
          {"Semana 2 - 2 Timóteo 1:7": "Pois Deus não nos deu espírito de covardia, mas de poder..."},
          {"Semana 3 - João 15:26-27": "Quando vier o Conselheiro... vocês também testemunharão..."}
        ]
      },
      {
        "Março: Estratégias para Evangelizar": [
          {"Semana 1 - Colossenses 4:5-6": "Sejam sábios no procedimento para com os de fora..."},
          {"Semana 2 - 1 Pedro 3:15": "Estejam sempre preparados para responder a qualquer pessoa..."},
          {"Semana 3 - Tito 2:7-8": "Em tudo seja você mesmo um exemplo..."}
        ]
      }
    ],
    "2º Trimestre, Direcionamento 2: Estabelecer a Palavra em Cada Indivíduo": [
      {
        "Abril: A Importância da Palavra de Deus": [
          {"Semana 1 - Salmos 119:105": "A tua palavra é lâmpada que ilumina os meus passos..."},
          {"Semana 2 - Isaías 40:8": "A erva seca e as flores caem, mas a palavra de nosso Deus permanece para sempre."},
          {"Semana 3 - João 6:63": "As palavras que eu lhes disse são espírito e vida."}
        ]
      },
      {
        "Maio: Aplicando a Palavra no Dia a Dia": [
          {"Semana 1 - Tiago 1:22": "Sejam praticantes da palavra, e não apenas ouvintes."},
          {"Semana 2 - Mateus 7:24": "Todo aquele que ouve estas minhas palavras e as pratica é como um homem prudente."},
          {"Semana 3 - Salmos 1:2-3": "Antes, o seu prazer está na lei do Senhor..."}
        ]
      },
      {
        "Junho: Guardando a Palavra no Coração": [
          {"Semana 1 - Salmos 119:11": "Guardei no coração a tua palavra para não pecar contra ti."},
          {"Semana 2 - Provérbios 4:20-22": "Meu filho, escute o que eu digo; preste atenção às minhas palavras."},
          {"Semana 3 - Colossenses 3:16": "Habite ricamente em vocês a palavra de Cristo."}
        ]
      }
    ],
    "3º Trimestre, Direcionamento 3: Fundamentar a Palavra em Cada Indivíduo": [
      {
        "Julho: Construindo Sobre a Rocha": [
          {"Semana 1 - Mateus 7:25": "Caiu a chuva, transbordaram os rios... mas não caiu, porque tinha seus alicerces na rocha."},
          {"Semana 2 - 1 Coríntios 3:11": "Pois ninguém pode colocar outro alicerce além do que já está posto, que é Jesus Cristo."},
          {"Semana 3 - Efésios 2:20": "Edificados sobre o fundamento dos apóstolos e dos profetas, tendo Jesus Cristo como pedra angular."}
        ]
      },
      {
        "Agosto: Permanecendo Firmes na Verdade": [
          {"Semana 1 - João 8:31-32": "Se vocês permanecerem firmes na minha palavra, verdadeiramente serão meus discípulos."},
          {"Semana 2 - 1 Pedro 5:9": "Resistam-lhe, permanecendo firmes na fé."},
          {"Semana 3 - Hebreus 6:19": "Temos esta esperança como âncora da alma, firme e segura."}
        ]
      },
      {
        "Setembro: Protegendo-se contra Ventos de Doutrina": [
          {"Semana 1 - Efésios 4:14": "Para que não sejamos mais como crianças, levados de um lado para o outro..."},
          {"Semana 2 - 2 Timóteo 4:3-4": "Pois virá o tempo em que não suportarão a sã doutrina..."},
          {"Semana 3 - Colossenses 2:6-8": "Portanto, assim como receberam Cristo Jesus como Senhor, continuem a viver nele."}
        ]
      }
    ],
    "4º Trimestre, Direcionamento 4: Edificar a Vida Espiritual de Cada Um": [
      {
        "Outubro: Crescendo em Santidade": [
          {"Semana 1 - 1 Pedro 1:15-16": "Sejam santos, porque eu sou santo."},
          {"Semana 2 - Hebreus 12:14": "Esforcem-se para viver em paz com todos e para serem santos."},
          {"Semana 3 - 1 Tessalonicenses 4:7": "Pois Deus não nos chamou para a impureza, mas para a santidade."}
        ]
      },
      {
        "Novembro: Desenvolvendo os Frutos do Espírito": [
          {"Semana 1 - Gálatas 5:22-23": "Mas o fruto do Espírito é amor, alegria, paz..."},
          {"Semana 2 - João 15:4-5": "Permaneçam em mim, e eu permanecerei em vocês."},
          {"Semana 3 - Romanos 8:6": "A mentalidade da carne é morte, mas a mentalidade do Espírito é vida e paz."}
        ]
      },
      {
        "Dezembro: Perseverando na Caminhada Cristã": [
          {"Semana 1 - Filipenses 3:13-14": "Esquecendo-me das coisas que ficaram para trás e avançando para as que estão adiante..."},
          {"Semana 2 - 2 Timóteo 4:7": "Combati o bom combate, terminei a corrida, guardei a fé."},
          {"Semana 3 - Apocalipse 2:10": "Seja fiel até a morte, e eu lhe darei a coroa da vida."}
        ]
      }
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ano Apostólico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Ano Apostólico',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...themes.keys.map((month) {
              List<Map<String, String>> verses = themes[month]!;
              return ExpansionTile(
                title: Text(month, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                children: verses.map((verse) {
                  String reference = verse.keys.first;
                  String text = verse[reference]!;
                  return ListTile(
                    title: Text(reference, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(text),
                  );
                }).toList(),
              );
            }).toList(),
            SizedBox(height: 16),
            Text(
              'Direcionamentos do Ano Apostólico',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...directions.keys.map((direction) {
              List<Map<String, List<Map<String, String>>>> weeks = directions[direction]!;
              return ExpansionTile(
                title: Text(direction, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                children: weeks.map((week) {
                  String weekTitle = week.keys.first;
                  List<Map<String, String>> verses = week[weekTitle]!;
                  return ExpansionTile(
                    title: Text(weekTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    children: verses.map((verse) {
                      String reference = verse.keys.first;
                      String text = verse[reference]!;
                      return ListTile(
                        title: Text(reference, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(text),
                      );
                    }).toList(),
                  );
                }).toList(),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}