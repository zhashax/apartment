import 'package:apartment/config/utils/user_model.dart';
import 'package:equatable/equatable.dart';

class User_State extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class LoginInitState extends User_State{}

class LoginLoadingState extends User_State{}

class LoginSuccessState extends User_State{}

class LoginErrorState extends User_State{
  final message;
  LoginErrorState({this.message});
}
class UsernameState extends User_State{
  final name;
  UsernameState({this.name});
}

