// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ErrorModel {
  final String message;
  final int statusCode;
  final bool isSuccess;

  ErrorModel({
    required this.message,
    required this.statusCode,
    required this.isSuccess,
  });

  ErrorModel copyWith({
    String? message,
    int? statusCode,
    bool? isSuccess,
  }) {
    return ErrorModel(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'statusCode': statusCode,
      'isSuccess': isSuccess,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      message: map['status_message'] as String,
      statusCode: map['status_code'] as int,
      isSuccess: map['success'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ErrorModel(message: $message, statusCode: $statusCode, isSuccess: $isSuccess)';

  @override
  bool operator ==(covariant ErrorModel other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.statusCode == statusCode &&
        other.isSuccess == isSuccess;
  }

  @override
  int get hashCode =>
      message.hashCode ^ statusCode.hashCode ^ isSuccess.hashCode;
}
