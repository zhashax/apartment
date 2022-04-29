
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../widgets/calendar_popup.dart';

class History extends StatefulWidget {

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 2));
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
    const String _appName = "history";
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

            Text(
              '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 36),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
      FocusScope.of(context).requestFocus(FocusNode());

      showDemoDialog(context: context);
    },
    tooltip: 'choose date Range',
    child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
    ),

    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
      ),
    );
  }
}
