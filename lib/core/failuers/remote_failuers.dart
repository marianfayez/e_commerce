
import 'package:e_commerce_app/core/failuers/failuers.dart';

class RemoteFailures extends RouteFailures {
  RemoteFailures(super.message);
}
class UnauthorizedFailure extends RouteFailures {
  UnauthorizedFailure(super.message);
}
class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
