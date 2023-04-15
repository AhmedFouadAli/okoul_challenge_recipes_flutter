class NoInternetException implements Exception {
  @override
  String toString() => ("checkInternet");
}

class UnauthorizedException implements Exception {
  @override
  String toString() => ("sessionExpired");
}

class ServerErrorException implements Exception {
  @override
  String toString() => ("internalServerError");
}

class UnknownErrorException implements Exception {
  @override
  String toString() => ("unknownError");
}
