

import 'package:apartment/config/utils/user_model.dart';
import 'package:apartment/cubit/theme_cubit.dart';

import 'package:apartment/ui/screens/deposite.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/history.dart';
import '../screens/messages.dart';
import '../screens/profile.dart';

class ApartmentDrawer extends StatefulWidget {

  const ApartmentDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _ApartmentDrawerState createState() => _ApartmentDrawerState();
}

class _ApartmentDrawerState extends State<ApartmentDrawer> {


  String name='';

  @override
  void initState(){

    _getName().then((name) {
      setState(() {
        this.name = name;
      });
    });

    super.initState();

  }

  _getName() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var name = storage.getString('name');
    return name;
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>ThemeCubit()),
    ], child: BlocBuilder<ThemeCubit,ThemeState>(builder: (context,state){
      return
      SafeArea(
        child: Drawer(

          child: Container(
            color: state.themeData.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [


                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  ),
                  InkWell(
                    onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyProfile()));},
                    child: Text(
                      tr('profile'),
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Divider(
                      color: Colors.blueGrey[400],
                      thickness: 2,
                    ),
                  ),
                  InkWell(
                    onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>History()));},
                    child: Text(
                      tr('history'),
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Divider(
                      color: Colors.blueGrey[400],
                      thickness: 2,
                    ),
                  ),
                  InkWell(
                    onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Messages()));},
                    child: Text(
                      tr('messages'),
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Divider(
                      color: Colors.blueGrey[400],
                      thickness: 2,
                    ),
                  ),
                  InkWell(
                    onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Deposite()));},
                    child: Text(
                      tr('deposite'),
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),


                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        tr('copyright'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

    },),);
  }
}
