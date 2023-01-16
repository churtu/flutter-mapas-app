part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool isFollowingUser;
  final LatLng? lastKnowPosition;
  final List<LatLng>myLocationHistory;

  const LocationState({
    this.isFollowingUser = false,
    this.lastKnowPosition,
    myLocationHistory
  }): myLocationHistory  = myLocationHistory ?? const [];
  
  @override
  List<Object?> get props => [
    isFollowingUser,
    lastKnowPosition,
    myLocationHistory
  ];

  LocationState copyWith({
    bool? isFollowingUser,
    LatLng? lastKnowPosition,
    List<LatLng>?myLocationHistory
  }) => LocationState(
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    lastKnowPosition: lastKnowPosition ?? this.lastKnowPosition,
    myLocationHistory: myLocationHistory ?? this.myLocationHistory
  );
}
