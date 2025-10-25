import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String? title;
  final String? subtitle;
  final String? notes;
  final int isStatus;
  final String? statusName;
  final String? isType;
  final int isFavorite;
  final int isArchived;
  final int priority;
  final int? reminderOn;
  final int? dateOn;
  final int? createdOn;
  final int? updatedOn;
  final int? deletedOn;
  final int? colorTag;
  final int isPinned;
  final int syncStatus;

  const TaskEntity({
    required this.id,
    this.title,
    this.subtitle,
    this.notes,
    this.isStatus = 0,
    this.statusName,
    this.isType,
    this.isFavorite = 0,
    this.isArchived = 0,
    this.priority = 0,
    this.reminderOn,
    this.dateOn,
    this.createdOn,
    this.updatedOn,
    this.deletedOn,
    this.colorTag,
    this.isPinned = 0,
    this.syncStatus = 0,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    notes,
    isStatus,
    statusName,
    isType,
    isFavorite,
    isArchived,
    priority,
    reminderOn,
    dateOn,
    createdOn,
    updatedOn,
    deletedOn,
    colorTag,
    isPinned,
    syncStatus,
  ];
}
