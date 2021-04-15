import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Story extends StatelessWidget{

  var title;
  var descp;
  var img;
  Story({this.title,this.img,this.descp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Story"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: HexColor("#FEF6FF"),
        padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
        child: Card(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              ),
              SizedBox(height: 10,),
              Image.network(img),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(descp,style: TextStyle(
                  fontSize: 15,
                  wordSpacing: 5,
                  letterSpacing: 1,
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

}