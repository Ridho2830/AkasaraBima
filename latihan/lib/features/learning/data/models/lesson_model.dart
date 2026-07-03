class LessonModel {
  final String id;
  final String levelId;
  final int urutan;
  final String nama;
  final String tipe;
  final Map<String, dynamic> kontenJson;
  final int passingScore;

  const LessonModel({
    required this.id,
    required this.levelId,
    required this.urutan,
    required this.nama,
    required this.tipe,
    required this.kontenJson,
    required this.passingScore,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as String? ?? '',
      levelId: json['level_id'] as String? ?? '',
      urutan: json['urutan'] as int? ?? 0,
      nama: json['nama'] as String? ?? '',
      tipe: json['tipe'] as String? ?? '',
      kontenJson: Map<String, dynamic>.from(json['konten_json'] as Map? ?? {}),
      passingScore: json['passing_score'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level_id': levelId,
      'urutan': urutan,
      'nama': nama,
      'tipe': tipe,
      'konten_json': kontenJson,
      'passing_score': passingScore,
    };
  }
}
