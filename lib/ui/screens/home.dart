
import 'package:carousel_slider/carousel_slider.dart';
import 'package:getwidget/getwidget.dart';
import 'package:apartment/repository/auth_repo.dart';
import 'package:apartment/ui/screens/my_location.dart';

import 'package:apartment/ui/widgets/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../config/theme.dart';


class Home extends StatefulWidget {
  static const String _appName = "app_name";

  const Home({Key? key}) : super(key: key);



  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text(tr(Home._appName),
        )),
        drawer: ApartmentDrawer(),
        body:
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: HomeScreen())
    );

  }
}



class HomeScreen extends StatefulWidget {

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
AuthRepository repo = AuthRepository();






@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var formatter = DateFormat("dd-MM-yyyy");

    Size size = MediaQuery.of(context).size;
    return Material(child: FutureBuilder<List>(
    builder: (BuildContext context, AsyncSnapshot snapshot) {

      if(snapshot.data == null){
        return Center(child: CircularProgressIndicator(),);
      }
      return RefreshIndicator(
        // background color
          backgroundColor: Colors.white,

          // refresh circular progress indicator color
          color: Colors.green,
          onRefresh: () {return repo.getObjects();},
          child: ListView.builder(
            itemExtent: 200.0,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              List list = snapshot.data[index]['images'];
              //print("herre:${list.toString()}");
              print("dateTime:${snapshot.data[index]['updated_at']}");
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyLocation(title: snapshot.data[index]['title'], lat: double.parse(snapshot.data[index]['longitude']), long: double.parse(snapshot.data[index]['latitude'],),cost_1m: int.parse(snapshot.data[index]['cost_1m']),cost_rent: int.parse(snapshot.data[index]['cost_rent']),area:snapshot.data[index]['area'],full_address: snapshot.data[index]['full_address'],fromDate: snapshot.data[index]['created_at'],duringDate: snapshot.data[index]['updated_at'],),));
                },
                child: Column(
                  children: [
                    Expanded(
                      child: GFListTile(
                        avatar: Container(
                          width: 200,
                          height: 150,
                          child: Image(image: NetworkImage(repo.api+"/storage/assets/objects/"+snapshot.data[index]['images'][0]['image_name']),),
                        ),
                        titleText: "${snapshot.data[index]['title']}",
                        subTitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(color: Colors.grey[700],),
                          Text("м/кв: ${snapshot.data[index]['area']}",style: TextStyle(color:Colors.black87,fontSize: 18,),),
                          Text("оплата до: ${formatter.format(DateTime.parse(snapshot.data[index]['updated_at']))}",style: TextStyle(color:Colors.black87, fontSize: 18,),),
                            SizedBox(height: 20,),
                            LinearPercentIndicator(
                              width:size.width*0.3,
                              lineHeight: 20,
                              percent: 0.5,
                              center: Text("50.0%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: AppThemes.primarySwatch.shade200,
                              backgroundColor: AppThemes.primarySwatch.shade50,
                              animation: true,
                              animationDuration: 5000,
                            ),
                        ],),

                      ),

                    ),
                    Divider(color: Colors.black87,),
                  ],
                ),
              );
            },
          ));
    },
    future: repo.getObjects(),),);
  }
}




