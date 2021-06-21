import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realchat/OwnerAppPages/Chat.dart';
import 'package:realchat/OwnerAppPages/ProfilePages/Profile.dart';
import 'package:realchat/chat/chat.dart';
import '../OwnerAppPages/dashboard.dart';

class HomePage extends StatefulWidget {
  final String SchoolUpin;
  const HomePage({Key key, this.SchoolUpin}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // DatabaseReference reference = FirebaseDatabase.instance.reference().child("Schools");
  final fb = FirebaseDatabase.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;


  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }
  String InstID = "...";
  Future<void> _fetchUserDataFromDatabase() async {
    print('_auth.currentUser.uid -> ${_auth.currentUser.uid}');
    final ref = fb.reference().child("Schools").child("School-Members").child(_auth.currentUser.uid);
    final DataSnapshot data = await ref.once();
    print("User data: ${data.value}");
    setState(() {
      InstID = data.value['InstID'].toString();
    });
  }
  getUser() async {
    user = await _auth.currentUser;
    await user?.reload();
    user = _auth.currentUser;

    if (user != null) {
      setState(() {
        this.user = user;
        this.isloggedin = true;
      });
    }
  }


  @override
  void initState() {
    _fetchUserDataFromDatabase();
    super.initState();
    this.checkAuthentification();
    this.getUser();

  }

  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    Chat(),
    ProfilePage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 30,
                    onPressed: (){
                      setState(() {
                        currentScreen = Dashboard(SchoolUpin: InstID,);
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0? Colors.lightBlueAccent : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(color:  currentTab == 0? Colors.lightBlueAccent: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 30,
                    onPressed: (){
                      setState(() {
                        currentScreen = Chat(InstID: InstID,);
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          color: currentTab == 1? Colors.lightBlueAccent : Colors.grey,
                        ),
                        Text(
                          'Chat',
                          style: TextStyle(color:  currentTab == 1? Colors.lightBlueAccent: Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
              //right Tab Bar Icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 30,
                    onPressed: (){
                      setState(() {
                        currentScreen = ProfilePage(SchoolUpin: InstID);
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 4? Colors.lightBlueAccent : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(color:  currentTab == 4? Colors.lightBlueAccent: Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ) ,
        ),
      ),
    );
  }
}
