class SpiritualDiscipline {
  final List<String> disciplines;

  SpiritualDiscipline({required this.disciplines});

  Map<String, dynamic> toMap() {
    return {
      'disciplines': disciplines.join(','),
    };
  }
}