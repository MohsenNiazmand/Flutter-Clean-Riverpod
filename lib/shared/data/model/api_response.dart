class ApiResponse<T> {
  ApiResponse({
    this.status,
    this.data,
    this.message,
    this.errors,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    final dataJson = json['data'];
    T? parsedData;

    if (dataJson is Map<String, dynamic>) {
      parsedData = fromJsonT(dataJson);
    } else if (dataJson is List) {
      // Special case: empty list should not be parsed as T
      if (dataJson.isEmpty) {
        parsedData = null;
      } else {
        parsedData = dataJson.map((item) {
          return fromJsonT(item);
        }).toList() as T;
      }
    } else {
      parsedData = null;
    }

    return ApiResponse<T>(
      status: json['status'] as String?,
      data: parsedData,
      message: json['message'] as String?,
      errors: json['errors'],
    );
  }

  final String? status;
  final T? data;
  final String? message;
  final dynamic errors;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return {
      'status': status,
      'data': data != null ? toJsonT(data!) : null,
      'message': message,
      'errors': errors,
    };
  }
}
