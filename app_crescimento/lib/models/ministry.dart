class Ministry {
  final int apostolic;
  final int prophetic;
  final int evangelistic;
  final int pastoral;
  final int teaching;

  Ministry({
    required this.apostolic,
    required this.prophetic,
    required this.evangelistic,
    required this.pastoral,
    required this.teaching,
  });

  Map<String, dynamic> toMap() {
    return {
      'apostolic': apostolic,
      'prophetic': prophetic,
      'evangelistic': evangelistic,
      'pastoral': pastoral,
      'teaching': teaching,
    };
  }
}