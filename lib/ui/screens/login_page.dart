
import 'package:apartment/config/theme.dart';
import 'package:apartment/cubit/user_cubit.dart';
import 'package:apartment/cubit/user_events.dart';
import 'package:apartment/cubit/user_state.dart';
import 'package:apartment/repository/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/utils/user_model.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  AuthRepository _repository = new AuthRepository();
  bool circular = false;
  late UserModel _user;
  get userMod => _user;
  var _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();


  String name = '';
  String? errorMessage;

  late UserBloc authBloc;
  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<UserBloc>(context);
    
  }
  @override
  Widget build(BuildContext context) {

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Не правильный формат!");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Не правильный формат!");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Не допускаются цифры");
          }
          if (!regex.hasMatch(value)) {
            return ("Минимум 6 символов");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));



    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 200,
                          child: Image(image: AssetImage("assets/images/logo.png"),)),
                      SizedBox(height: 45),
                      emailField,
                      SizedBox(height: 25),
                      passwordField,
                      SizedBox(height: 35),
                           InkWell(
                            onTap: ()async{
                              setState(() {
                                circular = true;
                              });

                              authBloc.add(LoginButtonPressed(email: emailController.text, password: passwordController.text));

                              UserModel _userModel = await _repository.logIn(emailController.text, passwordController.text);

                              if (_userModel.success == true){
                                SharedPreferences storage = await SharedPreferences.getInstance();
                                final text = _userModel.message;
                                final snackBar = SnackBar(content: Text(text,style: TextStyle(color: Colors.greenAccent),));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                storage.setString('token', _userModel.data.token);
                                storage.setString('name', _userModel.data.user.name);
                                storage.setString('email', _userModel.data.user.email);
                                storage.setString('iin', _userModel.data.user.iin);
                                storage.setString('phone', _userModel.data.user.phone);


                                setState(() {
                                  circular = false;
                                });
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), (route) => false);
                              }

                            },

                          child: Container(
                            width: 150,height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppThemes.textSwatch
                          ),
                            child: Center(
                              child: circular? CircularProgressIndicator():Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }

  }
