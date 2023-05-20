import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;

import 'apiclass.dart';

class Listviewdemo extends StatefulWidget {
  const Listviewdemo({Key? key}) : super(key: key);

  @override
  State<Listviewdemo> createState() => _ListviewdemoState();
}

class _ListviewdemoState extends State<Listviewdemo> {

  Future<List<News>> fetchData() async{
    var url=Uri.parse("https://newsapi.org/v2/everything?q=tesla&from=2023-04-18&sortBy=publishedAt&apiKey=62b83e8a6267452fbd4fd6ccc5c26a23");
    final responce=await http.get(url);
    if(responce.statusCode==200){
      List listresponce=json.decode(responce.body);
      return listresponce.map((data) => News.FromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Listview with Api'),),

      body: FutureBuilder<List<News>>(
          future: fetchData(),
          builder: (context,abc){
            if(abc.hasData){
              return  ListView.builder(
                  itemCount: abc.data!.length,

                  itemBuilder: (BuildContext context,int len){
                    return Container(
                      height: 100,
                      color: Colors.grey,
                      child: Row(children: [

                        Image.network(abc.data![len].title,width: 80,height: 80,),
                        Center(child:Text(abc.data![len].url))
                      ],)



                      ,
                    );

                  });
            }
            else if(abc.hasError){
              return Text(abc.error.toString());

            }
            return const CircularProgressIndicator();
          }

      ),);
  }
}
