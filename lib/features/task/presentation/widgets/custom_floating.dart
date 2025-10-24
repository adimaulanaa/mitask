import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';

// Asumsi Anda memiliki AppColors yang telah didefinisikan (e.g., AppColors.black, AppColors.white)

class CustomExpandedFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomExpandedFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 1. Tentukan Lebar dan Tinggi Maksimum
      height: 56, // Tinggi standar FAB
      constraints: const BoxConstraints(maxWidth: 170), // Batasi lebar total
      margin: EdgeInsets.only(bottom: 10),
      // 2. Gunakan InkWell untuk efek klik yang bagus
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(50), // Sudut sangat membulat
        // 3. Dekorasi (Warna Latar Belakang)
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary, // Warna latar belakang hitam
            borderRadius: BorderRadius.circular(50),
          ),
          // 4. Struktur Isi (Row)
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Push konten ke kanan
            children: [
              // Teks 'Add Task'
              const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 8.0,
                ), // Padding disesuaikan
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              // Tombol Lingkaran (Ikon Plus)
              Container(
                width:
                    48, // Ukuran lingkaran (sesuaikan dengan tinggi 56 jika perlu)
                height: 48,
                margin: const EdgeInsets.only(
                  right: 4,
                ), // Jarak dari tepi Container
                decoration: BoxDecoration(
                  color: Colors.white, // Warna lingkaran dalam putih
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.primary, // Warna ikon plus hitam
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
