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
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['_id'] as String,
      title: map['title'] as String?,
      subtitle: map['subtitle'] as String?,
      notes: map['notes'] as String?,
      isStatus: map['is_status'] ?? 0,
      statusName: map['status_name'] as String?,
      isType: map['is_type'] as String?,
      isFavorite: map['is_favorite'] ?? 0,
      isArchived: map['is_archived'] ?? 0,
      priority: map['priority'] ?? 0,
      reminderOn: map['reminder_on'],
      dateOn: map['date_on'],
      createdOn: map['created_on'],
      updatedOn: map['updated_on'],
      deletedOn: map['deleted_on'],
      colorTag: map['color_tag'] as String?,
      isPinned: map['is_pinned'] ?? 0,
      syncStatus: map['sync_status'] ?? 0,
    );
  }

  /// Convert ke Map (untuk insert/update)
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'subtitle': subtitle,
      'notes': notes,
      'is_status': isStatus,
      'status_name': statusName,
      'is_type': isType,
      'is_favorite': isFavorite,
      'is_archived': isArchived,
      'priority': priority,
      'reminder_on': reminderOn,
      'date_on': dateOn,
      'created_on': createdOn,
      'updated_on': updatedOn,
      'deleted_on': deletedOn,
      'color_tag': colorTag,
      'is_pinned': isPinned,
      'sync_status': syncStatus,
    };
  }
}
