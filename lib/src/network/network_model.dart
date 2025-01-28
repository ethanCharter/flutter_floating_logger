import 'package:floating_logger/floating_logger.dart'
    show ValueNotifier, Equatable, DioLogger, FloatingLoggerItem;

/// Repository class for managing application logs.
///
/// [FloatingLoggerItem] The LogRepository and LogRepositoryModel classes
/// are used to manage and store logs displayed on the floating logger interface.
/// The logs aredynamically updated through ValueNotifier, ensuring that the
/// floating logger UI reflects real-time changes as new logs are added or cleared.
///
/// [DioLogger] The LogRepository acts as a backend to store HTTP request/response
/// logs generated by DioLogger. Each request is captured as a LogRepositoryModel,
/// including details such as type, path, response, header, and data. These logs
/// can then be accessed by FloatingLoggerItem or other UI components for
/// debugging or monitoring network activity.
class LogRepository {
  /// A `ValueNotifier` that tracks a list of logs, allowing real-time updates to any listeners.
  final ValueNotifier<List<LogRepositoryModel>> _logsNotifier =
      ValueNotifier<List<LogRepositoryModel>>([]);

  /// Adds a new log to the list and notifies listeners.
  void addLog(LogRepositoryModel log) {
    _logsNotifier.value = [log, ..._logsNotifier.value];
    // Adds the new log at the beginning of the list.
  }

  /// Provides access to the `ValueNotifier` for logs.
  ValueNotifier<List<LogRepositoryModel>> get logsNotifier => _logsNotifier;

  /// Clears all logs in the list.
  void clearLogs() {
    _logsNotifier.value = [];
  }
}

/// Data model for a log item, used within [LogRepository].
/// This class defines the structure of each log and ensures it can be used with
/// libraries like Equatable for comparison.
class LogRepositoryModel extends Equatable {
  /// The type of request or log, such as `GET`, `POST`, etc.
  final String? type;

  /// The response returned from the server.
  final String? response;

  /// Query parameters sent or received in the server request.
  final String? queryparameter;

  /// Headers sent in the request or received in the response.
  final String? header;

  /// The body data sent in the request, typically for `POST` requests.
  final String? data;

  /// The body data returned in the server's response.
  final String? responseData;

  /// The API path or endpoint used for the request.
  final String? path;

  /// Additional message related to the log, often used for debugging or extra information.
  final String? message;

  /// A cURL representation of the request, useful for replicating the request in a terminal or tool.
  final String? curl;
  
  const LogRepositoryModel({
    this.type,
    this.response,
    this.queryparameter,
    this.header,
    this.data,
    this.responseData,
    this.path,
    this.message,
    this.curl,
  });

  /// Factory constructor for creating a log instance from a JSON object.
  factory LogRepositoryModel.fromJson(Map<String, dynamic> json) {
    return LogRepositoryModel(
      type: json["type"] ?? "-",
      response: json["response"] ?? "-",
      queryparameter: json["queryparameter"] ?? "-",
      header: json["header"] ?? "-",
      data: json["data"] ?? "-",
      responseData: json["response_data"] ?? "-",
      message: json["message"] ?? "-",
      curl: json["curl"] ?? "-",
    );
  }

  /// Converts the log instance into a JSON object.
  Map<String, dynamic> toJson() => {
        "type": type,
        "response": response,
        "queryparameter": queryparameter,
        "header": header,
        "data": data,
        "response_data": responseData,
        "path": path,
        "message": message,
        "curl": curl,
      };

  /// Overrides the `toString` method to format log information as a string.
  @override
  String toString() {
    return "$type, $response, $header, $queryparameter, $data, $responseData, $path, $message, $curl";
  }

  /// Properties used by `Equatable` for object comparison.
  @override
  List<Object?> get props => [
        type,
        response,
        header,
        queryparameter,
        data,
        responseData,
        path,
        message,
        curl,
      ];
}
