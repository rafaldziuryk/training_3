import 'package:equatable/equatable.dart';
import 'package:weather/core/fail.dart';

abstract class UseCase<Type, Params> {
  Future<UseCaseResult<Fail, Type>> call(Params params);

  const UseCase();
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class UseCaseResult<F, T> {
  final F? resultFailure;
  final T? resultData;

  T get data {
    final data = resultData;

    if (state != UseCaseResultState.success) {
      throw UseCaseResultStateFail();
    }

    return data ?? (throw UseCaseResultStateFail());
  }

  F get failure {
    final failure = resultFailure;

    if (state != UseCaseResultState.failure) {
      throw UseCaseResultStateFail();
    }

    return failure ?? (throw UseCaseResultStateFail());
  }

  final UseCaseResultState state;

  bool get isSuccess => state == UseCaseResultState.success;

  const UseCaseResult._({
    this.resultFailure,
    this.resultData,
    required this.state,
  });

  factory UseCaseResult.success({T? data}) =>
      UseCaseResult._(resultData: data, resultFailure: null, state: UseCaseResultState.success);
  factory UseCaseResult.error(F error) =>
      UseCaseResult._(resultData: null, resultFailure: error, state: UseCaseResultState.failure);
}

enum UseCaseResultState { success, failure }
