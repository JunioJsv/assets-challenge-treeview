import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String id;
  final String name;

  const Company({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
