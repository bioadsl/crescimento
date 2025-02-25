enum AssessmentType {
  spiritualDisciplines,
  fiveMinistries,
  fruitOfSpirit,
  pillars,
  intimacyLevel,
  spiritualGifts,
}

class Assessment {
  final AssessmentType type;
  final Map<String, double> scores;
  final DateTime createdAt;
  final String userId;
  final int? totalScore;

  Assessment({
    required this.type,
    required this.scores,
    required this.createdAt,
    required this.userId,
    this.totalScore,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      type: AssessmentType.values.firstWhere(
        (e) => e.toString().split('.').last == (json['type'] ?? ''),
        orElse: () => AssessmentType.spiritualDisciplines,
      ),
      scores: Map<String, double>.from(json['scores'] ?? {}),
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      userId: json['user_id']?.toString() ?? '0',
      totalScore: json['total_score'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString().split('.').last,
      'scores': scores,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
      'total_score': totalScore,
    };
  }

  static Map<AssessmentType, String> get typeNames => {
    AssessmentType.spiritualDisciplines: 'Disciplinas Espirituais',
    AssessmentType.fiveMinistries: 'Cinco Ministérios',
    AssessmentType.fruitOfSpirit: 'Frutos do Espírito',
    AssessmentType.pillars: 'Pilares',
    AssessmentType.intimacyLevel: 'Níveis de Intimidade',
    AssessmentType.spiritualGifts: 'Dons Espirituais',
  };

  String get typeName => typeNames[type] ?? '';

  static String getEndpoint(AssessmentType type) {
    switch (type) {
      case AssessmentType.spiritualDisciplines:
        return 'spiritual-disciplines';
      case AssessmentType.fiveMinistries:
        return 'five-ministries';
      case AssessmentType.fruitOfSpirit:
        return 'fruit-of-spirit';
      case AssessmentType.pillars:
        return 'pillars';
      case AssessmentType.intimacyLevel:
        return 'intimacy-level';
      case AssessmentType.spiritualGifts:
        return 'spiritual-gifts';
    }
  }

  double getAverageScore() {
    if (scores.isEmpty) return 0;
    final sum = scores.values.reduce((a, b) => a + b);
    return sum / scores.length;
  }

  String getHighestScore() {
    if (scores.isEmpty) return '';
    final highest = scores.entries
        .reduce((a, b) => a.value > b.value ? a : b);
    return '${highest.key}: ${highest.value.toStringAsFixed(1)}';
  }

  String getLowestScore() {
    if (scores.isEmpty) return '';
    final lowest = scores.entries
        .reduce((a, b) => a.value < b.value ? a : b);
    return '${lowest.key}: ${lowest.value.toStringAsFixed(1)}';
  }

  void debugPrint() {
    print('Type: $typeName');
    print('Scores carregados: $scores');
    print('Média: ${getAverageScore()}');
    print('Maior pontuação: ${getHighestScore()}');
    print('Menor pontuação: ${getLowestScore()}');
  }


}
