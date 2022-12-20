class HttpError implements Exception{
  String? _errorCode;
  String? _message;

  HttpError(Map<String, dynamic> code){
    _errorCode = code['cod'];
    _message = code['message'];
  }

  @override
  String toString() {
    return "HTTP Error!\n\t\t\t$_errorCode\n$_message";
  }
}