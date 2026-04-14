class TranslationHistory {
  final String id;
  final String text;
  final DateTime timestamp;
  final double accuracy;
  final String? videoPath;

  TranslationHistory({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.accuracy,
    this.videoPath,
  });
}
