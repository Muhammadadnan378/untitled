import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/PostModels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostModels> postList = [];

  Future<List<PostModels>> getPostApi ()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        postList.add(PostModels.fromJson(i));
      }
      return postList;
    }
    return postList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter API"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context,snashot){
                if(!snashot.hasData){
                  return Text("Loading");
                }else{
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Title", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              Text(postList[index].title.toString()),
                              Text("Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              Text(postList[index].body.toString())
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            ),
          )
        ],
      ),
    );
  }
}
