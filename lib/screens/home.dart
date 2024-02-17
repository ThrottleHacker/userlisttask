import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../model_class/user.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
   List<User> _users=[];
   List<User> _filteredUsers = [];
   var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    parseJson();
  }

  void parseJson() async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/users_list.json");
    final jsonResult = jsonDecode(data);
    final parsed = jsonResult['Response']['Users'];
    print("parsed $parsed");
    _users = parsed.map<User>((json) => User.fromJson(json)).toList();
    _filteredUsers.addAll(_users);
    filterUsers("");
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "User List",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 7.w,
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                width: 100.w,
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: searchController,
                  onChanged: (value) {
                    filterUsers(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.black45,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 66, 125, 145),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 20.0,
                    mainAxisExtent: 250
                  ),
                  itemCount: _filteredUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildGridItem(_filteredUsers[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
   void filterUsers(String query) {
     setState(() {
       _filteredUsers = _users
           .where((user) =>
       user.name.toLowerCase().contains(query.toLowerCase()) ||
           user.email.toLowerCase().contains(query.toLowerCase()))
           .toList();
       sortFilteredUsers();
     });
   }

   void sortFilteredUsers() {
     _filteredUsers.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
   }

   Widget _buildGridItem(User user) {
     return Card(
       elevation: 2,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           SizedBox(height: 10,),
           Center(
             child: CircleAvatar(
               radius: 50,
               backgroundImage: NetworkImage(user.image),
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   user.name,
                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                 ),
                 SizedBox(height: 4),
                 Text(user.email),
                 SizedBox(height: 4),
                 Text(user.mobile),
                 SizedBox(height: 4),
                 Text(user.zone),
               ],
             ),
           ),
           Container(
             height: 2.h,
             width: 100.w,
             decoration: BoxDecoration(
               color: Colors.redAccent,
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(10),
                 bottomRight: Radius.circular(10),
               ),
               border: Border.all(
                 color: Colors.white, // Border color
                 width: 0, // Border width
               ),
             ),

           )
         ],
       ),
     );
   }

}
