class IntimacyLevel {
  final String level;

  IntimacyLevel({required this.level});

  Map<String, dynamic> toMap() {
    return {
      'level': level,
    };
  }
}