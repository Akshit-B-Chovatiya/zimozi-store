import 'dart:convert';

APIResponse apiResponseFromJson(String str) => APIResponse.fromJson(json.decode(str));

String apiResponseToJson(APIResponse data) => json.encode(data.toJson());

class APIResponse {
  APIResponse(
      { required this.statusCode,
        required this.headers,
        required this.isSuccess,
        this.data,
        this.status,
        this.statusMessage,
        this.rowCount});

  final dynamic data;
  final String? status;
  final String? statusMessage;
  final int? rowCount;
  final bool isSuccess;
  final Map<String, dynamic> headers;
  final int statusCode;

  APIResponse copyWith({
    dynamic data,
    String? status,
    String? statusMessage,
    int? rowCount,
    bool? isSuccess,
    Map<String, dynamic>? headers,
    int? statusCode,
  }) =>
      APIResponse(
        data: data ?? this.data,
        status: status ?? this.status,
        statusMessage: statusMessage ?? this.statusMessage,
        rowCount: rowCount ?? this.rowCount,
        headers: headers ?? this.headers,
        isSuccess: isSuccess ?? this.isSuccess,
        statusCode: statusCode ?? this.statusCode,
      );

  factory APIResponse.fromJson(Map<String, dynamic> json) => APIResponse(
      data: json["Data"],
      status: json["Status"],
      statusMessage: json["StatusMessage"],
      rowCount: json["RowCount"],
      headers: json["Header"],
      statusCode: json["StatusCode"],
      isSuccess: json["IsSuccess"]);

  Map<String, dynamic> toJson() => {
    "Data": data,
    "Status": status,
    "StatusMessage": statusMessage,
    "RowCount": rowCount,
    "StatusCode": statusCode,
    "Header": headers,
    "IsSuccess": isSuccess
  };
}
