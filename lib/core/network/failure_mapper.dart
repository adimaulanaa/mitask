import 'dart:async';

import 'package:mitask/core/config/config_resources.dart';
import 'package:mitask/core/network/app_exception.dart';
import 'package:mitask/core/network/exceptions.dart';
import 'package:mitask/core/network/hendler_failure.dart';

Failure mapExceptionToFailure(dynamic e) {
  if (e is BadRequestException) {
    return BadRequestFailure(message: e.message);
  } else if (e is UnauthorisedException) {
    return UnauthorisedFailure(message: e.message);
  } else if (e is NotFoundException) {
    return NotFoundFailure(message: e.message);
  } else if (e is InvalidCredentialException) {
    return InvalidCredentialFailure(message: e.message);
  } else if (e is ServerException || e is FetchDataException) {
    return ServerFailure(message: e.message);
  } else if (e is NetworkException) {
    return const NetworkFailure(message: StringResources.networkFailureMessage);
  } else if (e is Exception) {
    // fallback untuk semua exception lain
    return ServerFailure(message: e.toString());
  } else {
    // fallback untuk error unknown / non-exception
    return const ServerFailure(message: 'Terjadi kesalahan tidak diketahui.');
  }
}

Future<T> handleApiCall<T>(
  Future<dynamic> Function() apiCall,
  T Function(dynamic data) onSuccess,
) async {
  try {
    final response = await apiCall();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return onSuccess(response.data);
    } else {
      final msg = response.data['message'] ?? 'Unknown error';
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(message: msg);
        case 401:
          throw InvalidCredentialException(message: msg);
        case 403:
          throw UnauthorisedException(message: msg);
        case 404:
          throw NotFoundException(message: msg);
        case 422:
          throw UnauthorisedException(message: msg);
        default:
          throw ServerException(message: msg);
      }
    }
  } catch (e) {
    if (e is AppException) {
      rethrow; // message asli tetap utuh
    } else {
      throw ServerException(message: e is Exception ? e.toString() : 'Unknown error');
    }
  }
}

