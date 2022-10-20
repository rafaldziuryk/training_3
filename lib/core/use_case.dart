import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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
  final F? failure;
  final T? data;

  final UseCaseResultState state;

  bool get isSuccess => state == UseCaseResultState.success;

  const UseCaseResult._({
    this.failure,
    this.data,
    required this.state,
  });

  factory UseCaseResult.success({T? data}) =>
      UseCaseResult._(data: data, failure: null, state: UseCaseResultState.success);
  factory UseCaseResult.error(F error) =>
      UseCaseResult._(data: null, failure: error, state: UseCaseResultState.failure);
}

enum UseCaseResultState { success, failure }
