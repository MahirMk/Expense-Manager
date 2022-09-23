import 'package:expensemanager/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'DatabaseHelpers.dart';

class ManagerRegister extends StatefulWidget {

  @override
  State<ManagerRegister> createState() => _ManagerRegisterState();
}

class _ManagerRegisterState extends State<ManagerRegister> {

  TextEditingController _title = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _date = TextEditingController();

  var grpvalue = "I";
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _date.text = selectedDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Manager Register",style: GoogleFonts.lato(fontStyle: FontStyle.italic),)),
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
            Text("Remark",style:TextStyle(fontSize: 30)),
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
                  var id = await obj.ManagerRegister(title,remark,amt,gp,date);
                  print("Record inserted : "+id.toString());

                  _title.text="";
                  _remark.text="";
                  _amount.text="";
                   grpvalue = "I";
                  _date.text="";

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>HomePage())
                  );

                },
                child: Center(child: Text("ADD",style: TextStyle(fontSize: 30),)),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
