class QuranModel {
   int id;
   String name;
   String transliteration;
   String translation;
   String type;
   int totalVerses;

  QuranModel({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.translation,
    required this.type,
    required this.totalVerses,
  });

  factory QuranModel.fromJson(Map<String, dynamic> json) => QuranModel(
    id: json["id"],
    name: json['name'],
    transliteration: json['transliteration'],
    translation: json['translation'],
    type: json['type'],
    totalVerses: json['total_verses'],
  );
}
