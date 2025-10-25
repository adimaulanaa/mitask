class CreateTaskParams {
  final String id;
  final String title;
  final String? subtitle;
  final String? notes;
  final int isStatus;
  final String statusName;
  final String? type;
  final int isFavorite;
  final int isArchived;
  final int priority;
  final int reminderOn;
  final int dateOn;
  final int createdOn;
  final int? updatedOn;
  final int? deletedOn;
  final int colorTag;
  final int isPinned;
  final int syncStatus;

  const CreateTaskParams({
    this.id = '',
    required this.title,
    this.subtitle,
    this.notes,
    this.isStatus = 0,
    this.statusName = 'Not Started',
    this.type,
    this.isFavorite = 0,
    this.isArchived = 0,
    this.priority = 0,
    this.reminderOn = 0,
    this.dateOn = 0,
    required this.createdOn,
    this.updatedOn,
    this.deletedOn,
    this.colorTag = 0,
    this.isPinned = 0,
    this.syncStatus = 0,
  });

  /// Convert ke Map untuk disimpan di DB
  Map<String, dynamic> toMap() {
    return {
      // 🛠️ PERBAIKAN: Menggunakan key pendek untuk INSERT
      'id': id, // Asumsi `id` ditambahkan di layer repository
      'title': title, 
      'subtitle': subtitle,
      'notes': notes,
      'isStatus': isStatus,
      'statusName': statusName,
      'type': type,
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
