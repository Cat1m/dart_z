// lib/core/error/failures.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.serverFailure() = ServerFailure;
  const factory Failure.cacheFailure() = CacheFailure;
  const factory Failure.networkFailure() = NetworkFailure;
}
