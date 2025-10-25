import 'package:mitask/features/task/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    super.title,
    super.subtitle,
    super.notes,
    super.isStatus = 0,
    super.statusName,
    super.isType,
    super.isFavorite = 0,
    super.isArchived = 0,
    super.priority = 0,
    super.reminderOn,
    super.dateOn,
    super.createdOn,
    super.updatedOn,
    super.deletedOn,
    super.colorTag,
    super.isPinned = 0,
    super.syncStatus = 0,
  });

  /// Convert dari Map (data dari database)
  // TaskModel.dart

factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String?,
      subtitle: map['subtitle'] as String?,
      notes: map['notes'] as String?,
      
      isStatus: map['isStatus'] as int? ?? 0, // Menggunakan int?
      statusName: map['statusName'] as String?,
      isType: map['type'] as String?,
      isFavorite: map['isFavorite'] as int? ?? 0, // Menggunakan int?
      isArchived: map['isArchived'] as int? ?? 0, // Menggunakan int?
      priority: map['priority'] as int? ?? 0, // Menggunakan int?
      
      // 💡 PERBAIKAN: Tangani nilai Timestamp (Int) yang mungkin null di DB
      reminderOn: map['reminderOn'] as int?,
      dateOn: map['dateOn'] as int?,
      createdOn: map['createdOn'] as int?,
      updatedOn: map['updatedOn'] as int?,
      deletedOn: map['deletedOn'] as int?,
      
      // colorTag sudah kita perbaiki menjadi int
      colorTag: map['colorTag'] as int? ?? 0, 
      isPinned: map['isPinned'] as int? ?? 0,
      syncStatus: map['syncStatus'] as int? ?? 0,
    );
}

  /// Convert ke Map (untuk insert/update)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'notes': notes,
      'isStatus': isStatus,
      'statusName': statusName,
      'type': isType,
      'isFavorite': isFavorite,
      'isArchived': isArchived,
      'priority': priority,
      'reminderOn': reminderOn,
      'dateOn': dateOn,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'deletedOn': deletedOn,
      'colorTag': colorTag,
      'isPinned': isPinned,
      'syncStatus': syncStatus,
    };
  }
}
