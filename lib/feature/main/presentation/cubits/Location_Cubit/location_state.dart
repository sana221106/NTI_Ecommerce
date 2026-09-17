import 'package:geolocator/geolocator.dart';

sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSuccess extends LocationState {
  final Position position;
  final String address;

  LocationSuccess({
    required this.position,
    required this.address,
  });
}

final class LocationFailure extends LocationState {
  final String errorMessage;

  LocationFailure({
    required this.errorMessage,
  });
}