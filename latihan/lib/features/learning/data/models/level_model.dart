class LevelModel {
  final String id;
  final String nama;
  final String deskripsi;
  final List<String> hurufDiperkenalkan;
  final int pelajaranCount;

  const LevelModel({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.hurufDiperkenalkan,
    required this.pelajaranCount,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['id'] as String? ?? '',
      nama: json['nama'] as String? ?? '',
      deskripsi: json['deskripsi'] as String? ?? '',
      hurufDiperkenalkan: List<String>.from(json['huruf_diperkenalkan'] as List? ?? []),
      pelajaranCount: json['pelajaran_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'huruf_diperkenalkan': hurufDiperkenalkan,
      'pelajaran_count': pelajaranCount,
    };
  }
}
