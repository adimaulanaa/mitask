import 'package:equatable/equatable.dart';

// =======================================================
// CLASS PENDUKUNG: DashboardItemEntity
// =======================================================
class DashboardItemEntity extends Equatable {
  final String logo;
  final String title;
  final String subtitle;
  final String created;

  const DashboardItemEntity({
    required this.logo,
    required this.title,
    required this.subtitle,
    required this.created,
  });

  @override
  List<Object> get props => [logo, title, subtitle, created];
}

// =======================================================
// CLASS UTAMA: DashboardEntity
// =======================================================
// DashboardEntity adalah representasi user di domain layer.
// Objek ini harus immutable (tidak bisa diubah setelah dibuat).
class DashboardEntity extends Equatable {
  final String name;
  final String greetings;
  final int pinned;
  final int favorite;
  final int archived;
  final int total;
  final List<DashboardItemEntity> recentItems;

  const DashboardEntity({
    required this.name,
    required this.greetings,
    this.pinned = 0,
    this.favorite = 0,
    this.archived = 0,
    this.total = 0,
    this.recentItems = const [],
  });

  // Equatable memastikan dua DashboardEntity dianggap sama jika semua propertinya sama.
  @override
  List<Object> get props => [
    name,
    greetings,
    pinned,
    favorite,
    archived,
    total,
    recentItems,
  ];
}
