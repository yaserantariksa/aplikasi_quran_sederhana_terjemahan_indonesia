import 'package:aplikasi_quran/models/verse_model.dart';

class SurahModel {
  int id;
  String name;
  String transliteration;
  String translation;
  String type;
  int totalVerses;
  List<VerseModel> verses;

  SurahModel({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.translation,
    required this.type,
    required this.totalVerses,
    required this.verses,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) =>
      SurahModel(
        id: json['id'],
        name: json['name'],
        transliteration: json['transliteration'],
        translation: json['translation'],
        type: json['type'],
        totalVerses: json['total_verses'],
        verses: List<VerseModel>.from(
            json['verses'].map((a) => VerseModel.fromJson(a))),
      );
}
