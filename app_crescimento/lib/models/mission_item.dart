class MissionItem {
  final List<String> items;

  MissionItem({required this.items});

  Map<String, dynamic> toMap() {
    return {
      'items': items.join(','),
    };
  }
}