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
  bool get isSuccess => data != null;

  const UseCaseResult({
    this.failure,
    this.data,
  });

  factory UseCaseResult.success(T data) => UseCaseResult(data: data, failure: null);
  factory UseCaseResult.error(F error) => UseCaseResult(data: null, failure: error);
}