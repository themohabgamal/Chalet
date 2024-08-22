import 'package:chalet_spot/core/error/failures.dart';

abstract class ReserveState {}

class ReserveInitial extends ReserveState {}

class ReserveLoading extends ReserveState {}

class ReserveSuccess extends ReserveState {
  String msg;

  ReserveSuccess(this.msg);
}

class ReserveError extends ReserveState {
  Failures failures;

  ReserveError(this.failures);
}

class ReserveCodeLoading extends ReserveState {}

class ReserveCodeSuccess extends ReserveState {
  String msg;

  ReserveCodeSuccess(this.msg);
}

class ReserveCodeError extends ReserveState {
  Failures failures;

  ReserveCodeError(this.failures);
}
