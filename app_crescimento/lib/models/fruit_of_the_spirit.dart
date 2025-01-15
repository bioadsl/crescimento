class FruitOfTheSpirit {
  final int love;
  final int joy;
  final int peace;
  final int patience;

  FruitOfTheSpirit({
    required this.love,
    required this.joy,
    required this.peace,
    required this.patience,
  });

  Map<String, dynamic> toMap() {
    return {
      'love': love,
      'joy': joy,
      'peace': peace,
      'patience': patience,
    };
  }
}