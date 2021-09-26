class HttpException implements Exception {
  String msg;

  HttpException(this.msg);

  @override
  String toString() {
    return msg;
  }
}
