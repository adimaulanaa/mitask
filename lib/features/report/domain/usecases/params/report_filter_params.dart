
class ReportFilterParams {
  // Kriteria Pencarian Teks
  final String? periodType; 
  // Kriteria Tanggal (DateOn)
  // DateTime lebih baik daripada String di sini karena lebih mudah diolah di Bloc/Repository
  final DateTime? startDate; 
  final DateTime? endDate;   

  const ReportFilterParams({
    this.periodType,
    this.startDate,
    this.endDate,
  });

  /// Digunakan untuk membuat instance baru dengan hanya mengubah properti tertentu.
  ReportFilterParams copyWith({
    String? periodType,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ReportFilterParams(
      periodType: periodType,
      startDate: startDate, 
      endDate: endDate,
    );
  }
}