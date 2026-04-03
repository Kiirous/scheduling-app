part of 'home_map_cubit.dart';

class HomeMapState extends Equatable {
  const HomeMapState({required this.userLocation, required this.locationStatus, required this.professionals});

  const HomeMapState.initial() : userLocation = null, locationStatus = null, professionals = null;

  final Location? userLocation;
  final AppLocationStatus? locationStatus;
  final List<Professional>? professionals;

  @override
  List<Object?> get props => [userLocation, locationStatus];

  HomeMapState copyWith({
    Location? userLocation,
    AppLocationStatus? locationStatus,
    List<Professional>? professionals,
  }) {
    return HomeMapState(
      userLocation: userLocation ?? this.userLocation,
      locationStatus: locationStatus ?? this.locationStatus,
      professionals: professionals ?? this.professionals,
    );
  }
}
