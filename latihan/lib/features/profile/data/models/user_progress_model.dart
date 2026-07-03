class UserHurufProgressModel {
  final String userId;
  final String hurufId;
  final String status; // 'introduced' | 'practiced' | 'mastered'
  final int totalAttempts;
  final int correctCount;
  final double writeAccuracyAvg;
  final int masteryScore;
  final DateTime nextReviewAt;
  final DateTime lastPracticed;

  const UserHurufProgressModel({
    required this.userId,
    required this.hurufId,
    required this.status,
    required this.totalAttempts,
    required this.correctCount,
    required this.writeAccuracyAvg,
    required this.masteryScore,
    required this.nextReviewAt,
    required this.lastPracticed,
  });

  factory UserHurufProgressModel.fromJson(Map<String, dynamic> json) {
    return UserHurufProgressModel(
      userId: json['user_id'] as String? ?? '',
      hurufId: json['huruf_id'] as String? ?? '',
      status: json['status'] as String? ?? 'introduced',
      totalAttempts: json['total_attempts'] as int? ?? 0,
      correctCount: json['correct_count'] as int? ?? 0,
      writeAccuracyAvg: (json['write_accuracy_avg'] as num? ?? 0.0).toDouble(),
      masteryScore: json['mastery_score'] as int? ?? 0,
      nextReviewAt: json['next_review_at'] != null 
          ? DateTime.parse(json['next_review_at'] as String)
          : DateTime.now(),
      lastPracticed: json['last_practiced'] != null 
          ? DateTime.parse(json['last_practiced'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'huruf_id': hurufId,
      'status': status,
      'total_attempts': totalAttempts,
      'correct_count': correctCount,
      'write_accuracy_avg': writeAccuracyAvg,
      'mastery_score': masteryScore,
      'next_review_at': nextReviewAt.toIso8601String(),
      'last_practiced': lastPracticed.toIso8601String(),
    };
  }
}
