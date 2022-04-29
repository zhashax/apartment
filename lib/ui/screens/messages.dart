import 'package:apartment/ui/widgets/deposite/responsive.dart';

import 'package:apartment/ui/widgets/drawer.dart';
import 'package:apartment/ui/widgets/messsage_widget_page.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../config/theme.dart';
import '../../cubit/theme_cubit.dart';
import 'home.dart';

class Messages extends StatefulWidget {


  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String _appName = "messages";
    return Scaffold(
      appBar: AppBar(
          title:Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                child: Text(""),
                onTap: ()=>Navigator.pop(context),
              ),
              SizedBox(width: MediaQuery.of(context).size.width*0.15,),
              Text(tr(_appName),
              ),
            ],
          )),

      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children: [
            Card (
              margin: EdgeInsets.all(10),
              color: AppThemes.primarySwatch.shade100,
              shadowColor: Colors.blueGrey,
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon (
                        Icons.attach_money,
                        color: Colors.blue,
                        size: 45
                    ),
                    title: Text(
                      "Покупка квадратуры",
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Card (
              margin: EdgeInsets.all(10),
              color: AppThemes.primarySwatch.shade100,
              shadowColor: Colors.blueGrey,
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon (
                        Icons.key,
                        color: Colors.blue,
                        size: 45
                    ),
                    title: Text(
                      "Аренда",
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Card (
              margin: EdgeInsets.all(10),
              color: AppThemes.primarySwatch.shade100,
              shadowColor: Colors.blueGrey,
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon (
                        Icons.account_balance_wallet,
                        color: Colors.blue,
                        size: 45
                    ),
                    title: Text(
                      "Депозит",
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Card (
              margin: EdgeInsets.all(10),
              color: AppThemes.primarySwatch.shade100,
              shadowColor: Colors.blueGrey,
              elevation: 10,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessageWidget(),));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon (
                          Icons.ten_k_outlined,
                          color: Colors.blue,
                          size: 45
                      ),
                      title: Text(
                        "Акций",
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ]),
    );
  }
}
