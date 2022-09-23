import 'package:flutter/material.dart';
import 'DatabaseHelpers.dart';
import 'HomePage.dart';

class UpdateProject extends StatefulWidget {

  var updateexpenseid="";
  UpdateProject({this.updateexpenseid});

  @override
  State<UpdateProject> createState() => _UpdateProjectState();
}

class _UpdateProjectState extends State<UpdateProject> {

  getdata() async
  {
    DataBaseHelpers obj = new DataBaseHelpers();
    var data = await obj.getsingleexpense(widget.updateexpenseid);
    _title.text = data[0]["title"].toString();
    _remark.text = data[0]["remark"].toString();
    _amount.text = data[0]["amt"].toString();
    setState(() {
      grpvalue = data[0]["gp"].toString();
      _date.text = data[0]["date"].toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  TextEditingController _title = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _date = TextEditingController();

  var grpvalue = "I";
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text("Title",style: TextStyle(fontSize: 30),),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black,width: 3.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: TextField(
                    controller: _title,
                    keyboardType: TextInputType.name,
                  )
              ),
            ),
            SizedBox(height: 50),
            Text("Remark",style: TextStyle(fontSize: 30),),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black,width: 3.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: TextField(
                    controller: _remark,
                    keyboardType: TextInputType.name,
                  )
              ),
            ),
            SizedBox(height: 50),
            Text("Amount",style: TextStyle(fontSize: 30),),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black,width: 3.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: TextField(
                  controller: _amount,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text("Salary",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text("Income",style: TextStyle(fontSize: 20),),
                ),
                Radio(
                  value: "Income",
                  groupValue: grpvalue,
                  onChanged: (val)
                  {
                    setState(() {
                      grpvalue=val;
                    });
                  },
                ),
                Text("Expense",style: TextStyle(fontSize: 20),),
                Radio(
                  value: "Expense",
                  groupValue: grpvalue,
                  onChanged: (val)
                  {
                    setState(() {
                      grpvalue=val;
                    }
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      controller: _date,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1,color: Colors.yellow),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: () async{
                  final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101));
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                      _date.text = selectedDate.toString();
                    });
                  }
                }, icon: Icon(Icons.calendar_today)),
              ],
            ),
            SizedBox(height: 50),
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black,width: 3.0),
              ),
              child: GestureDetector(
                onTap: () async{
                  var title = _title.text.toString();
                  var remark = _remark.text.toString();
                  var amt = _amount.text.toString();
                  var gp = grpvalue.toString();
                  var date = _date.text.toString();

                  DataBaseHelpers obj = new DataBaseHelpers();
                  var status = await obj.updateexpense(title,remark,amt,gp,date,widget.updateexpenseid);

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>HomePage())
                  );
                },
                child: Center(child: Text("Save",style: TextStyle(fontSize: 30),)),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
