
import 'package:equatable/equatable.dart';

class UserEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class StartEvent extends UserEvents{
}
class LoginButtonPressed extends UserEvents{
  final String email;
  final String password;
  LoginButtonPressed({required this.email,required this.password});
}
class UserNameCalled extends UserEvents{
  final String name;
  UserNameCalled({required this.name});
}