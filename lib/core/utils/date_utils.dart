import 'package:intl/intl.dart';

/// Mengonversi string tanggal dengan format 'dd MMM yyyy'
/// menjadi Unix Timestamp (milidetik).
///
/// Jika string input kosong, null, atau gagal di-parse, maka akan mengembalikan null.
int dateStringToTimestamp(String? dateString) {
  if (dateString == null || dateString.trim().isEmpty) {
    return 0;
  }

  // Hapus spasi ekstra dan potensi prefix (meskipun tidak diharapkan dari TextFormField)
  String cleanedString = dateString.trim();

  // Format yang digunakan CustomDateInput untuk menyimpan tanggal
  final DateFormat formatter = DateFormat('dd MMM yyyy'); 
  
  try {
    // Parsing string ke objek DateTime
    final DateTime dateTime = formatter.parse(cleanedString);
    
    // Konversi ke Unix timestamp (dalam milidetik)
    return dateTime.millisecondsSinceEpoch; 
    
  } catch (e) {
    return 0;
  }
}

/// Mengonversi Unix Timestamp (milidetik) menjadi string tanggal.
/// Contoh output: "20 Okt 2025"
String timestampToDateString(int? timestamp) {
  // 1. Cek jika timestamp null atau nol (nilai default yang Anda gunakan)
  if (timestamp == null || timestamp == 0) {
    return '-'; // Mengembalikan string kosong atau tanda hubung jika tidak ada tanggal
  }

  // 2. Tentukan format output yang diinginkan
  // 'dd' (tanggal 2 digit), 'MMM' (singkatan bulan), 'yyyy' (tahun 4 digit)
  // Catatan: 'MMM' akan menggunakan bahasa default atau bahasa yang diatur di DateFormat.
  final DateFormat formatter = DateFormat('dd MMM yyyy'); 

  try {
    // 3. Ubah timestamp (milidetik) menjadi objek DateTime
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    
    // 4. Format objek DateTime menjadi string
    return formatter.format(dateTime);
    
  } catch (e) {
    return 'Invalid Date';
  }
}

/// Mengonversi Unix Timestamp (milidetik) menjadi string jam dan menit.
/// Output contoh: "13:00"
String timestampToTimeString(int? timestamp) {
  // Cek jika timestamp null atau nol
  if (timestamp == null || timestamp == 0) {
    return '--:--'; // Mengembalikan placeholder
  }

  // Tentukan format output: HH (jam 2 digit 24-jam), mm (menit 2 digit)
  final DateFormat formatter = DateFormat('HH:mm'); 

  try {
    // 1. Ubah timestamp (milidetik) menjadi objek DateTime
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    
    // 2. Format objek DateTime menjadi string jam:menit
    // PENTING: Format ini akan menggunakan zona waktu LOKAL perangkat Anda (WIB).
    return formatter.format(dateTime);
    
  } catch (e) {
    return 'Invalid Time';
  }
}