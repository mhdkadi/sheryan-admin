class Result<T> {
  Result({
    this.data,
    this.statusCode,
    this.statusMessage,
  });

  /// Response body. may have been transformed.
  T? data;

  /// Response status code.
  int? statusCode;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  String? statusMessage;
}
