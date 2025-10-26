import 'package:mitask/core/config/config_resources.dart';

class ChecklistTaskParams {
  final String id;
  final int isStatus;
  final String statusName;
  final String? type;

  const ChecklistTaskParams({
    this.id = '',
    this.isStatus = 0,
    this.statusName = StringResources.statusNotStarted,
    this.type = '',
  });

  /// Convert ke Map untuk disimpan di DB
  Map<String, dynamic> toMap() {
    return {
      // 🛠️ PERBAIKAN: Menggunakan key pendek untuk INSERT
      'id': id,
      'isStatus': isStatus,
      'statusName': statusName,
      'type': type,
    };
  }
}
