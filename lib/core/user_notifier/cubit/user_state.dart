part of 'user_cubit.dart';

class UserState extends Equatable {
  final DriverType user;
  const UserState({required this.user});

  factory UserState.initial() {
    return UserState(user: DriverType.ride);
  }

  UserState copyWith({DriverType? user}) {
    return UserState(user: user ?? this.user);
  }

  @override
  List<Object?> get props => [user];
}
