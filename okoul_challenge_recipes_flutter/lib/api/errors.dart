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

class ExceededApiRequest implements Exception {
  @override
  String toString() =>
      ("You have exceeded the MONTHLY quota for Requests on your current plan, BASIC. , Contact us :ahmmad.f@hotmail.com");
}
