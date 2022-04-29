import 'dart:convert';

import 'package:apartment/config/utils/objects_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/utils/user_model.dart';
class AuthRepository{
  String api = 'http://p2p.proportunity.kz/';
  logIn(String email, String password) async {
    String apiUrl = 'http://p2p.proportunity.kz/api/user/login';
    final response = await http.post(Uri.parse(apiUrl),body: {
      "email":email,
      "password" : password
    });
    if (response.statusCode == 200 || response.statusCode == 201){
      String responseString = response.body;
      return userModelFromJson(responseString);
    }
    return [];
  }

  getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get('token');
  }

   Future<List> getObjects()async{
    String token = '';
     await getToken().then((val){
     token = val;
    });
    String apiUrl = 'http://p2p.proportunity.kz/api/objects/all';
    final response = await http.get(Uri.parse(apiUrl),headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200 || response.statusCode == 201){
       //String responseString = jsonDecode(response.body);
      //print(jsonDecode(response.body)['data']);
      print(jsonDecode(response.body)['data'][0]['images'][1]['image_name']);
      return jsonDecode(response.body)['data'];
  }return [];
}}





