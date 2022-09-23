import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelpers
{
  Database db;

  Future<Database> expense_db() async
  {
    if(db!=null)
    {
      return db;
    }
    else
    {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = join (dir.path,"expense_db");
      var db = await openDatabase(path,version: 1,onCreate: create_table);
      return db;
    }
  }
  create_table(Database db,int version) async
  {
    db.execute("create table expense (pid integer primary key autoincrement,title text,remark text,amt text,gp text,date text)");
    print("Table Created");
  }
  Future<int> ManagerRegister(title,remark,amt,gp,date) async
  {
    var db = await expense_db();
    int id = await db.rawInsert("insert into expense (title,remark,amt,gp,date) values (?,?,?,?,?)",[title,remark,amt,gp,date]);
    return id;
  }

  Future<List> HomePage() async
  {
    var db = await expense_db();
    var data = await db.rawQuery("select * from expense");
    return data.toList();
  }
  Future<int>deleteexpense(no) async
  {
    var db = await expense_db();
    var status = await db.rawDelete("delete from expense where pid=?",[no]);
    return status;
  }
  Future<int> updateexpense(title,remark,amt,gp,date,no) async
  {
    var db = await expense_db();
    int status = await db.rawUpdate("update expense set title=?,remark=?,amt=?,gp=?,date=? where pid=?",[title,remark,amt,gp,date,no]);
    return status;
  }
  Future<List> getsingleexpense(no) async
  {
    var db = await expense_db();
    var data = await db.rawQuery("select * from expense where pid=?",[no]);
    return data.toList();
  }
}