
import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';




import '../../config/theme.dart';
import '../../cubit/theme_cubit.dart';

class MyLocation extends StatefulWidget{
  late String duringDate;
  late String fromDate;
  late double lat;
  late double long;
  late String title;
  late int cost_1m;
  late int cost_rent;
  late String area;
  late String full_address;
  MyLocation({required this.title,required this.lat,required this.long,required this.cost_1m,required this.cost_rent,required this.area,required this.full_address,required this.fromDate,required this.duringDate}) {
  }

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {

  Widget build(BuildContext context) {
    //var formatter = DateFormat("yyyy-MM-ddTKK:mm:ss");
    var formatter = DateFormat("dd-MM-yyyy");
    return Scaffold(
      appBar: AppBar(title:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            child: Text(""),
            onTap: ()=>Navigator.pop(context),
          ),
          SizedBox(width: MediaQuery.of(context).size.width*0.15,),
          Text(tr(widget.title),
          ),
        ],
      )),
      backgroundColor: Theme.of(context).backgroundColor,
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.all(20),
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(widget.lat, widget.long),
                  zoom: 13.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    attributionBuilder: (_) {
                      return Text("Место положения");
                    },
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 100.0,
                        height: 100.0,
                        point: LatLng(widget.lat, widget.long),
                        builder: (ctx) =>
                            Container(
                              child: Icon(Icons.add_location,color: Colors.redAccent,size: 30,),
                            ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: Container(
              padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(this.widget.full_address,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 24,color: Colors.black),),
                // SizedBox(height: 10,),
                // Text("дата начала: ${formatter.parse(this.widget.fromDate)} ",style: TextStyle(fontSize: 16,color: Colors.black87),),
                // SizedBox(height: 5,),
                Text("действует до: ${formatter.format(DateTime.parse(this.widget.duringDate))}",style: TextStyle(fontSize: 16,color: Colors.black87),),
                SizedBox(height: 20,),
              Text("Общая квадратура объекта: ${this.widget.area} м\u00B2",style: TextStyle(fontSize: 16,color: Colors.black87),),
                SizedBox(height: 20,),
                LinearPercentIndicator(
                  width:250,
                  lineHeight: 30,
                  percent: 0.5,
                  center: Text("50.0%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: AppThemes.primarySwatch.shade200,
                  backgroundColor: AppThemes.primarySwatch.shade50,
                  animation: true,
                  animationDuration: 5000,
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: Row(children: [
                    Column(children: [
                      Text("Стоимость м\u00B2: "+"${this.widget.cost_1m}₸",style: TextStyle(fontSize: 16,color: Colors.black87),),
                      SizedBox(height: 25),
                      ButtonTheme(
                        minWidth: 100.0,
                        height: 50,
                        child: FlatButton(onPressed: (){},
                          textColor:Colors.white,color: AppThemes.primarySwatch.shade100, child: Text("Купить м\u00B2"),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),),
                      ),

                    ],),
                    SizedBox(width: 20,height: 20,),
                    Expanded(
                      child: Column(children: [ Text("Сумма аренды м\u00B2: "+"${this.widget.cost_rent}₸",style: TextStyle(fontSize: 16,color: Colors.black87),),
                        SizedBox(height: 10,),
    ButtonTheme(
    minWidth: 100.0,
    height: 50,
    child: FlatButton(onPressed: (){

    },
    textColor:Colors.white,color: AppThemes.primarySwatch.shade100, child: Text("Оплатить аренду"),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),),
    ),],),
                    ),

                  ],),
                ),
            ],),
          ),),
        ],
      ),
    );
  }
}




