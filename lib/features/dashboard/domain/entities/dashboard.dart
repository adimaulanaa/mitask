import 'package:equatable/equatable.dart';

// UserEntity adalah representasi user di domain layer.
// Objek ini harus immutable (tidak bisa diubah setelah dibuat).
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
  });

  // Equatable memastikan dua UserEntity dianggap sama jika semua propertinya sama.
  @override
  List<Object> get props => [id, email, name];
}