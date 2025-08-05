abstract class Failure{
  final String message;
  Failure(this.message);
}

class ServiseFailure extends Failure{
  ServiseFailure(super.message);
}
class CacheFailure extends Failure {
  CacheFailure(super.message);
}