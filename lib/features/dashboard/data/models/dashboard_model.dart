import 'dart:convert';

class TaskModel {
  String? id;
  String? title;
  String? subtitle;
  String? notes;
  String? isStatus;
  String? isType;
  DateTime? createdOn;
  DateTime? updatedOn;

  TaskModel({
    this.id,
    this.title,
    this.subtitle,
    this.notes,
    this.isStatus,
    this.isType,
    this.createdOn,
    this.updatedOn,
  });

  // Convert a Breed into a Map. The keys must correspond to the titles of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'subtitle': subtitle,
      'notes': notes,
      'is_status': isStatus,
      'is_type': isType,
      'created_on': createdOn.toString(),
      'updated_on': updatedOn.toString(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      notes: map['notes'] ?? '',
      isStatus: map['is_status'] ?? 'false',
      isType: map['is_type'] ?? '',
      createdOn: map['created_on'] != null ? DateTime.parse(map['created_on']) : null,
      updatedOn: map['updated_on'] != null ? DateTime.parse(map['updated_on']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each breed when using the print statement.
  @override
  String toString() => 'user(_id: $id, title: $title, subtitle: $subtitle, notes: $notes, is_status: $isStatus, is_type: $isType, created_on: $createdOn, updated_on: $updatedOn)';
}
