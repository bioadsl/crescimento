class Pillar {
  final List<String> pillars;

  Pillar({required this.pillars});

  Map<String, dynamic> toMap() {
    return {
      'pillars': pillars.join(','),
    };
  }
}