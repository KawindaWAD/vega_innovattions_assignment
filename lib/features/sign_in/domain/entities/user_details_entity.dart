import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;

  const UserDetails({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [name, email, phoneNumber];
}