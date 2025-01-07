import 'package:crescimento/models/ministry.dart';
import 'package:crescimento/models/fruit_of_the_spirit.dart';
import 'package:crescimento/models/intimacy_level.dart';
import 'package:crescimento/models/spiritual_discipline.dart';
import 'package:crescimento/models/mission_item.dart';
import 'package:crescimento/models/pillar.dart';

class DailyRecord {
  final int? id;
  final Ministry ministry;
  final FruitOfTheSpirit fruitOfTheSpirit;
  final IntimacyLevel intimacyLevel;
  final SpiritualDiscipline spiritualDiscipline;
  final MissionItem missionItem;
  final Pillar pillar;

  DailyRecord({
    this.id,
    required this.ministry,
    required this.fruitOfTheSpirit,
    required this.intimacyLevel,
    required this.spiritualDiscipline,
    required this.missionItem,
    required this.pillar,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'apostolic': ministry.apostolic,
      'prophetic': ministry.prophetic,
      'evangelistic': ministry.evangelistic,
      'pastoral': ministry.pastoral,
      'teaching': ministry.teaching,
      'love': fruitOfTheSpirit.love,
      'joy': fruitOfTheSpirit.joy,
      'peace': fruitOfTheSpirit.peace,
      'patience': fruitOfTheSpirit.patience,
      'spiritual_disciplines': spiritualDiscipline.disciplines.join(','),
      'intimacy_level': intimacyLevel.level,
      'mission_items': missionItem.items.join(','),
      'pillars': pillar.pillars.join(','),
    };
  }

  factory DailyRecord.fromMap(Map<String, dynamic> map) {
    return DailyRecord(
      id: map['id'],
      ministry: Ministry(
        apostolic: map['apostolic'],
        prophetic: map['prophetic'],
        evangelistic: map['evangelistic'],
        pastoral: map['pastoral'],
        teaching: map['teaching'],
      ),
      fruitOfTheSpirit: FruitOfTheSpirit(
        love: map['love'],
        joy: map['joy'],
        peace: map['peace'],
        patience: map['patience'],
      ),
      intimacyLevel: IntimacyLevel(level: map['intimacy_level']),
      spiritualDiscipline: SpiritualDiscipline(
        disciplines: map['spiritual_disciplines'].split(','),
      ),
      missionItem: MissionItem(items: map['mission_items'].split(',')),
      pillar: Pillar(pillars: map['pillars'].split(',')),
    );
  }
}