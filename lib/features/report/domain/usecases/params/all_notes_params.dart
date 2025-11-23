
class AllNotesParams {
  final DateTime? startDate; 
  final DateTime? endDate;   

  const AllNotesParams({
    this.startDate,
    this.endDate,
  });

  /// Digunakan untuk membuat instance baru dengan hanya mengubah properti tertentu.
  AllNotesParams copyWith({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return AllNotesParams(
      startDate: startDate, 
      endDate: endDate,
    );
  }
}