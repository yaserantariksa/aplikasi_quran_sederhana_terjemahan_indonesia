class VerseModel {
  int id;
  String text;
  String translation;
  String transliteration;

  VerseModel({
    required this.id,
    required this.text,
    required this.translation,
    required this.transliteration,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) => VerseModel(
        id: json['id'],
        text: json['text'],
        translation: json['translation'],
        transliteration: json['transliteration'],
      );
}
