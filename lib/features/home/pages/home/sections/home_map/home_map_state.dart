part of 'home_map_cubit.dart';

class HomeMapState extends Equatable {
  const HomeMapState({required this.userLocation, required this.locationStatus});

  const HomeMapState.initial() : userLocation = null, locationStatus = null;

  final Location? userLocation;
  final AppLocationStatus? locationStatus;

  @override
  List<Object?> get props => [userLocation, locationStatus];

  HomeMapState copyWith({Location? userLocation, AppLocationStatus? locationStatus}) {
    return HomeMapState(
      userLocation: userLocation ?? this.userLocation,
      locationStatus: locationStatus ?? this.locationStatus,
    );
  }
}
