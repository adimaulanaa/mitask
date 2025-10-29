import 'package:equatable/equatable.dart';

// =======================================================
// CLASS PENDUKUNG: ReportItemEntity
// =======================================================
class ReportItemEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String created;

  const ReportItemEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.created,
  });

  @override
  List<Object> get props => [id, title, subtitle, created];
}

// =======================================================
// CLASS PENDUKUNG: ProductivityEntity
// =======================================================
class ProductivityEntity extends Equatable {
  final double mon;
  final double tue;
  final double wed;
  final double thu;
  final double fri;
  final double sat;
  final double sun;
  final double total;

  const ProductivityEntity({
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.sun,
    required this.total,
  });

  factory ProductivityEntity.fromDailySummary(Map<String, double> summary) {
    final values = [
      summary['mon'] ?? 0.0,
      summary['tue'] ?? 0.0,
      summary['wed'] ?? 0.0,
      summary['thu'] ?? 0.0,
      summary['fri'] ?? 0.0,
      summary['sat'] ?? 0.0,
      summary['sun'] ?? 0.0,
    ];

    final totalAverage = values.isEmpty
        ? 0.0
        : values.reduce((a, b) => a + b) / values.length;

    return ProductivityEntity(
      mon: summary['mon'] ?? 0.0,
      tue: summary['tue'] ?? 0.0,
      wed: summary['wed'] ?? 0.0,
      thu: summary['thu'] ?? 0.0,
      fri: summary['fri'] ?? 0.0,
      sat: summary['sat'] ?? 0.0,
      sun: summary['sun'] ?? 0.0,
      total: totalAverage,
    );
  }

  @override
  List<Object> get props => [mon, tue, wed, thu, fri, sat, sun];
}

// =======================================================
// CLASS UTAMA: ReportEntity
// =======================================================
// ReportEntity adalah representasi user di domain layer.
// Objek ini harus immutable (tidak bisa diubah setelah dibuat).
class ReportEntity extends Equatable {
  final int pinned;
  final int favorite;
  final int pending;
  final int archived;
  final int complated;
  final int total;
  final List<ReportItemEntity> recentItems;
  final ProductivityEntity? productivity;

  const ReportEntity({
    this.pinned = 0,
    this.favorite = 0,
    this.pending = 0,
    this.archived = 0,
    this.complated = 0,
    this.total = 0,
    this.recentItems = const [],
    this.productivity,
  });

  // Equatable memastikan dua ReportEntity dianggap sama jika semua propertinya sama.
  @override
  List<Object?> get props => [
    pinned,
    favorite,
    pending,
    archived,
    complated,
    total,
    recentItems,
    productivity,
  ];
}
