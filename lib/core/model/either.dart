abstract class Either<L,R>{
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn);

  bool get isLeft;
  bool get isRight;
}
class Left<L,R> extends Either<L,R> {
  final L value;

  Left(this.value);

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn) {
    return leftFn(value);
  }

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;
}

class Right<L,R> extends Either<L,R> {
  final R value;

  Right(this.value);

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn) {
    return rightFn(value);
  }

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;
}