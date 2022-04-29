
import 'dart:convert';

import 'package:apartment/config/utils/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_credit_card/flutter_credit_card.dart';


import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';


class MyProfile extends StatefulWidget {


  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late String name = '',iin = '',email='',phone='';



 _getName() async{
   SharedPreferences pref = await SharedPreferences.getInstance();
   return pref.get('name');
}
_getEmail() async{
   SharedPreferences pref = await SharedPreferences.getInstance();
   return pref.get('email');
}
  _getIIN() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get('iin');
  }

  _getPhone() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get('phone');
  }


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
      _getName().then((name) {
        setState(() {
          this.name = name;
        });
      });
      _getEmail().then((email){
        setState(() {
          this.email = email;
        });
      });
      _getIIN().then((iin){
        setState(() {
          this.iin = iin;
        });
      });

      _getPhone().then((phone){
        setState(() {
          this.phone = phone;
        });
      });

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  Widget build(BuildContext context) {
     const String _appName = "profile";
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Text(""),
            onTap: ()=>Navigator.pop(context),
          ),
          Text(tr(_appName),
          ),
          InkWell(child: Icon(CupertinoIcons.creditcard),
            onTap: (){
              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>(CreditCardPage())));
            },
          )
        ],
      )),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children: [
            Divider(color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: CircleAvatar(
                    radius: 40,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
                ),
              Text(
                "name: " + name,
                style: TextStyle(
                  fontFamily: "Raleway",
                color: Colors.black,
                    fontSize: 20
                ),
              ),
              ],),
            Divider(color: Colors.grey,height: 20,),
            Row(children: [
              Icon(CupertinoIcons.envelope_fill),
              SizedBox(width: 10,),
              Expanded(
                child: Text(
                  email,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
              ),

            ],),
            Divider(color: Colors.grey,height: 20,),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(CupertinoIcons.barcode),
                SizedBox(width: 10,),
                Text(
                  "IIN: "+iin,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey,height: 20,),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(CupertinoIcons.phone_solid),
                SizedBox(width: 10,),
                Text(
                  phone,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey,height: 20,),
          ]),
    );
  }
}

// class CreditCardPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return CreditCardPageState();
//   }
// }
//
// class CreditCardPageState extends State<CreditCardPage> {
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return  Scaffold(
//       backgroundColor: Colors.teal[50],
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             InkWell(
//               child: Icon(CupertinoIcons.left_chevron),
//               onTap: ()=>Navigator.pop(context),
//             ),
//             SizedBox(width: size.width*0.20,),
//             Text(tr("app_name")),
//           ],
//         ),
//       ),
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             CreditCardWidget(
//               cardBgColor: Colors.greenAccent[200],
//               cardNumber: cardNumber,
//               expiryDate: expiryDate,
//               cardHolderName: cardHolderName,
//               cvvCode: cvvCode,
//               showBackView: isCvvFocused,
//               obscureCardNumber: true,
//               obscureCardCvv: true,
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     CreditCardForm(
//                       formKey: formKey,
//                       onCreditCardModelChange: onCreditCardModelChange,
//                       obscureCvv: true,
//                       obscureNumber: true,
//                       cardNumberDecoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Number',
//                         hintText: 'XXXX XXXX XXXX XXXX',
//                       ),
//                       expiryDateDecoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Expired Date',
//                         hintText: 'XX/XX',
//
//                       ),
//                       cvvCodeDecoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'CVV',
//                         hintText: 'XXX',
//                       ),
//                       cardHolderDecoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Card Holder Name',
//                       ),
//                     ),
//                     SizedBox(height: 20,),
//                     RaisedButton(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Container(
//                         margin: const EdgeInsets.all(8),
//                         child: const Text(
//                           'Validate',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                       color: const Color(0xff1b447b),
//                       onPressed: () {
//                         if (formKey.currentState!.validate()) {
//                           print('valid!');
//                           _showValidDialog(context,"Valid","Your card successfully valid !!!");
//                         } else {
//                           print('invalid!');
//                         }
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Stream<Future<AlertDialog>> _showValidDialog(BuildContext context, String title, String content,) async*{
//     showDialog<AlertDialog>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Color(0xff1b447b),
//           title: Text(title),
//           content: Text(content),
//           actions: [
//             FlatButton(
//                 child: Text(
//                   "Ok",
//                   style: TextStyle(fontSize: 18,color: Colors.cyan),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 }),
//           ],
//         );
//       },
//     );
//   }
//
//
//   void onCreditCardModelChange(CreditCardModel creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }
// }