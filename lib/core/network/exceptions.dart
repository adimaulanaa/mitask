import 'package:mitask/core/network/app_exception.dart';

class ServerException extends AppException {
  const ServerException({
    super.message = 'Terjadi kesalahan pada server',
    super.code,
  });
}

class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Tidak ada koneksi internet',
    super.code,
  });
}

class BadRequestException extends AppException {
  const BadRequestException({
    super.message = 'Permintaan tidak valid',
    super.code,
  });
}

class UnauthorisedException extends AppException {
  const UnauthorisedException({
    super.message = 'Tidak memiliki otorisasi',
    super.code,
  });
}

class NotFoundException extends AppException {
  const NotFoundException({super.message = 'Data tidak ditemukan', super.code});
}

class FetchDataException extends AppException {
  const FetchDataException({
    super.message = 'Gagal mengambil data',
    super.code,
  });
}

class InvalidCredentialException extends AppException {
  const InvalidCredentialException({
    super.message = 'Kredensial tidak valid',
    super.code,
  });
}
