part of 'map_bloc.dart';

class MapState extends Equatable {
  
  final bool isMapInitialized;
  final bool isFollowingUser;

  const MapState({
    required this.isMapInitialized, 
    required this.isFollowingUser
  });
  
  @override
  List<Object> get props => [isFollowingUser, isMapInitialized];

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
  }) => MapState(
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    isMapInitialized: isMapInitialized ?? this.isMapInitialized
    ); 
}

