import 'package:friendsapp/app/data/model/friendmodel.dart';
import 'package:friendsapp/app/data/model/usermodel.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBService extends GetxService {
  late Database db;
  late String dbpath;
  final usertable = "User";
  final friendtable = "Friend";
  @override
  void onInit() async {
    await init();
    // print(await isExistingUser(mobile: 1234567890, password: 'arjun123'));
    // var friend = Friend(
    //     fname: "bapun",
    //     lname: 'mantri',
    //     email: 'bapun@mail.in',
    //     mobile: 1414125252,
    //     fid: 1);
    // print("friend inserted " + (await insertFriend(friend: friend)).toString());
    // print("friend updated " +
    //     (await updateFriend(
    //             friend: friend.copyWith(id: 1, fname: 'priyaranjan')))
    //         .toString());
    // //print('delete friend ' + (await deleteFriend(friend.copyWith(id: 1))).toString());
    // print((await getCurrentUserAllFriend(fid: 1)).length);
    super.onInit();
  }

  Future<DBService> init() async {
    dbpath = await getDatabasesPath();

    String path = join(dbpath, 'demo.db');
    // await deleteDatabase(path);
    // open the database
    db = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          '''CREATE TABLE IF NOT EXISTs $usertable ( id INTEGER PRIMARY KEY, 
          fname TEXT,
          lname text,
          email TEXT,
          mobile INTEGER UNIQUE,
          password TEXT UNIQUE
          )
          '''
              .trim());
      await db.execute('''CREATE TABLE IF NOT EXISTS $friendtable (
        id INTEGER PRIMARY KEY, 
        fname TEXT,
        lname text,
        email TEXT UNIQUE,
        mobile INTEGER UNIQUE,
        fid INTEGER)'''
          .trim());
    });
    return this;
  }

  Future<int> insertUser({required User user}) async {
    var id = 0;
    await db.transaction((txn) async {
      id = await txn.rawInsert(
          'INSERT INTO $usertable(fname,lname,email,mobile,password) VALUES(?, ?, ?, ?, ?)',
          [
            user.fname,
            user.lname,
            user.email,
            user.mobile,
            user.password,
          ]);

      return id;
    });
    return id;
  }

  Future<User?> isExistingUser(
      {required int mobile, required String password}) async {
    User? user;
    List<Map> maps = await db.query(usertable,
        columns: ['id', 'fname', 'lname', 'email', 'mobile', 'password'],
        where: 'mobile = ? AND password = ?',
        limit: 1,
        whereArgs: [mobile, password]);
    if (maps.isNotEmpty) {
      user = User.fromMap(maps.first as Map<String, dynamic>);
    }
    return user;
  }

  Future<List<Friend>> getCurrentUserAllFriend({required int fid}) async {
    List<Friend> friends = [];
    List<Map> maps = await db
        .query(friendtable, columns: null, where: 'fid = ?', whereArgs: [fid]);
    if (maps.isNotEmpty) {
      friends =
          maps.map((e) => Friend.fromMap(e as Map<String, dynamic>)).toList();
    }
    return friends;
  }

  Future<List<Friend>> getSearchByName(
      {required int fid, required String name}) async {
    List<Friend> friends = [];
    List<Map> maps = await db.query(friendtable,
        columns: null,
        where: 'fid=? AND (fname || lname) LIKE ?',
        whereArgs: [fid, '%$name%']);
    if (maps.isNotEmpty) {
      friends =
          maps.map((e) => Friend.fromMap(e as Map<String, dynamic>)).toList();
    }
    return friends;
  }

  Future<int> insertFriend({required Friend friend}) async {
    var id = 0;
    await db.transaction((txn) async {
      id = await txn.rawInsert(
          'INSERT INTO $friendtable(fname,lname,email,mobile,fid) VALUES(?, ?, ?, ?, ?)',
          [
            friend.fname,
            friend.lname,
            friend.email,
            friend.mobile,
            friend.fid,
          ]);

      return id;
    });
    return id;
  }

  Future<bool> updateFriend({required Friend friend}) async {
    var isupdated = false;
    await db.transaction((txn) async {
      var count = await txn.update(friendtable, friend.toMap(),
          where: 'id = ?', whereArgs: [friend.id]);
      if (count > 0) {
        isupdated = true;
      }
    });
    return isupdated;
  }

  Future<bool> deleteFriend({required Friend friend}) async {
    var isdeleted = false;
    await db.transaction((txn) async {
      var count = await txn
          .delete(friendtable, where: 'id = ?', whereArgs: [friend.id]);
      if (count > 0) {
        isdeleted = true;
      }
    });
    return isdeleted;
  }
}
