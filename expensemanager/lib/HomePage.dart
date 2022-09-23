import 'package:expensemanager/UpdateProject.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'DatabaseHelpers.dart';
import 'ManagerRegister.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List> alldata;

  Future<List>getdata() async
  {
    DataBaseHelpers obj = new DataBaseHelpers();
    var data =await obj.HomePage();
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Expenses Details")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>ManagerRegister())
          );
        },
        child: Icon(Icons.add,size: 50,),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context,snapshot)
        {
          if(snapshot.hasData)
          {
            if(snapshot.data.length<=0)
            {
              return Center(child: Text("No Data"));
            }
            else
            {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index)
                {
                  return
                     Container(
                      margin: EdgeInsets.all(25.0),
                      color: Colors.red.shade50,
                      child: Column(
                        children: [
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data[index]["title"].toString(),style: TextStyle(fontSize: 20,color: Colors.blue.shade900),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data[index]["amt"].toString(),style: TextStyle(fontSize: 20,color: Colors.pink),),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data[index]["remark"].toString(),style: TextStyle(fontSize: 20,color: Colors.black45),),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data[index]["gp"].toString(),style: TextStyle(fontSize: 20,),),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(snapshot.data[index]["date"].toString(),style: TextStyle(fontSize: 20),),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: ElevatedButton(
                                  onPressed : (){
                                     AlertDialog alert = new AlertDialog(
                                      title: Text("Warning!",style: TextStyle(color: Colors.white),),
                                      backgroundColor: Colors.blue,
                                      content: Text("Are you sure you want to delete record?",style: TextStyle(color: Colors.white),),
                                      actions: [
                                        TextButton(onPressed: (){
                                          Navigator.of(context).pop();
                                        }, child: Text("Cancel",style: TextStyle(color: Colors.white),)),
                                        TextButton(onPressed: () async{
                                          var no = snapshot.data[index]["pid"].toString();
                                          DataBaseHelpers obj = new DataBaseHelpers();
                                          var status = await obj.deleteexpense(no);
                                          Fluttertoast.showToast(
                                              msg: "YOUR DATA IS CLEAR",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                          setState(() {
                                            alldata = getdata();
                                          });
                                          Navigator.of(context).pop();
                                        }, child: Text("Delete",style: TextStyle(color: Colors.white),)),
                                      ],
                                    );
                                    showDialog(context: context, builder: (BuildContext context){
                                      return alert;
                                    });
                                  },
                                  child: Text("Delete",style: TextStyle(fontSize: 20),),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: ElevatedButton(
                                  onPressed : (){

                                    var no = snapshot.data[index]["pid"].toString();

                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>UpdateProject(updateexpenseid: no,))
                                    );
                                  },
                                  child: Text("Edit",style: TextStyle(fontSize: 20),),
                                ),
                              ),
                            ],
                          ),
                        ],

                      ),
                  );
                },
              );
            }
          }
          else
          {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
