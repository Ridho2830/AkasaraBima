class AksaraModel {
  final String id;
  final String kode;
  final String namaLatin;
  final String? unicodeChar;
  final String tipeFonem;
  final String mnemonik;
  final List<String> langkahTulis;
  final String audioUrl;
  final String gambarUrl;
  final int levelUnlock;
  final List<String> konfusableWith;

  const AksaraModel({
    required this.id,
    required this.kode,
    required this.namaLatin,
    this.unicodeChar,
    required this.tipeFonem,
    required this.mnemonik,
    required this.langkahTulis,
    required this.audioUrl,
    required this.gambarUrl,
    required this.levelUnlock,
    required this.konfusableWith,
  });

  factory AksaraModel.fromJson(Map<String, dynamic> json) {
    return AksaraModel(
      id: json['id'] as String? ?? '',
      kode: json['kode'] as String? ?? '',
      namaLatin: json['nama_latin'] as String? ?? '',
      unicodeChar: json['unicode_char'] as String?,
      tipeFonem: json['tipe_fonem'] as String? ?? '',
      mnemonik: json['mnemonik'] as String? ?? '',
      langkahTulis: List<String>.from(json['langkah_tulis'] as List? ?? []),
      audioUrl: json['audio_url'] as String? ?? '',
      gambarUrl: json['gambar_url'] as String? ?? '',
      levelUnlock: json['level_unlock'] as int? ?? 0,
      konfusableWith: List<String>.from(json['konfusable_with'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode': kode,
      'nama_latin': namaLatin,
      'unicode_char': unicodeChar,
      'tipe_fonem': tipeFonem,
      'mnemonik': mnemonik,
      'langkah_tulis': langkahTulis,
      'audio_url': audioUrl,
      'gambar_url': gambarUrl,
      'level_unlock': levelUnlock,
      'konfusable_with': konfusableWith,
    };
  }
}
