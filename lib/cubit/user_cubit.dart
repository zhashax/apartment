
import 'package:apartment/config/utils/user_model.dart';
import 'package:apartment/cubit/user_events.dart';
import 'package:apartment/cubit/user_state.dart';
import 'package:apartment/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvents,User_State>{
  String name;
  AuthRepository repository;
  UserBloc(User_State initialState,this.repository,this.name):super(initialState){
    on<StartEvent>((event,emit)async{
      emit(LoginInitState());
    });
    on<LoginButtonPressed>((event,emit)async{
      var pref = await SharedPreferences.getInstance();
      emit(LoginLoadingState());
      UserModel data = await repository.logIn(event.email, event.password);
      if(data.success == true){
        pref.setString("token", data.data.token);
        pref.setString("name", data.data.user.name);
        emit(LoginSuccessState());
      }else{
        emit(LoginErrorState(message: "auth error"));
      }
    });
    on<UserNameCalled>((event,emmit) async{
      var pref = await SharedPreferences.getInstance();
      String? name = pref.getString("name");
      emit(UsernameState(name: name));
    });
    
  }


}