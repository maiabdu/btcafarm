import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void push (BuildContext context,  Widget widget  ){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}