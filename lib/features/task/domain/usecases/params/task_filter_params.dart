// Lokasi: mitask/features/task/domain/entities/task_filter_params.dart

class TaskFilterParams {
  // Kriteria Pencarian Teks
  final String? query; 

  // Kriteria Status (Default: false, kecuali Anda ingin default isAll=true)
  final bool isPin;
  final bool isFav;
  final bool isArch;

  // Kriteria Tanggal (DateOn)
  // DateTime lebih baik daripada String di sini karena lebih mudah diolah di Bloc/Repository
  final DateTime? startDate; 
  final DateTime? endDate;   

  const TaskFilterParams({
    this.query,
    this.isPin = false,
    this.isFav = false,
    this.isArch = false,
    this.startDate,
    this.endDate,
  });

  /// Digunakan untuk membuat instance baru dengan hanya mengubah properti tertentu.
  TaskFilterParams copyWith({
    String? query,
    bool? isPin,
    bool? isFav,
    bool? isArch,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return TaskFilterParams(
      query: query ?? this.query,
      isPin: isPin ?? this.isPin,
      isFav: isFav ?? this.isFav,
      isArch: isArch ?? this.isArch,
      
      // Jika Anda ingin mengizinkan clear/nulling pada tanggal, 
      // Anda harus menggunakan parameter yang nullable (misalnya, DateTime? newStartDate)
      startDate: startDate, 
      endDate: endDate,
    );
  }
}