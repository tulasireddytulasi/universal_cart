import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final String errorMessage;
  final String description;
  final String dateTime;

  const ErrorModel({
    this.errorMessage = "",
    this.description = "",
    required this.dateTime,
  });

  @override
  List<Object> get props => [errorMessage, description, dateTime];
}
