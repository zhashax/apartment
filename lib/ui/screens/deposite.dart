
import 'package:apartment/config/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Deposite extends StatefulWidget {
  static const String route = '/';

  @override
  _DepositeState createState() => _DepositeState();
}

class _DepositeState extends State<Deposite> {
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
              Text(tr('deposite'),
      ),
            ],
          )),

      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children: [
      Card (
        semanticContainer: true,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),

        margin: EdgeInsets.all(50),
      shadowColor: Colors.blueGrey,
      elevation: 5,
      child: Container(
        width: 400,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Депозит KZT",style: TextStyle(fontSize: 30,color: Color(0xff376565)),),
            Text("10000 ₸",style: TextStyle(fontSize: 25,color: Color(0xff376565)),),
          ],
        ),
      ),
    ),
            Divider(color: Colors.grey,),
            InkWell(
              onTap: (){},
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet,size: MediaQuery.of(context).size.width*0.1
                    ,),
                  SizedBox(width: 10,),
                   Text("Пополнить депозит",style: TextStyle(fontSize: 20,color: Colors.black),),
                  Spacer(flex: 2,),
                  Icon(CupertinoIcons.right_chevron),
                ],
              ),
            ),
Divider(color: Colors.grey,),

          ]),
    );
  }
}
