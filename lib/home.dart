import 'package:flutter/material.dart';
 class Home extends StatefulWidget {
   const Home({Key? key}) : super(key: key);

   @override
   State<Home> createState() => _HomeState();
 }
String search='';
 class _HomeState extends State<Home> {
   @override
   Widget build(BuildContext context) {
     TextEditingController searchController =new TextEditingController();
     return SafeArea(child:Scaffold(
       body:Stack(
         children: [
           Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
           decoration:BoxDecoration(
             gradient: LinearGradient(
               colors: [
                 Color(0xff213A50),
                 Color(0xff071938),
               ]
             ),
           ) ,
       ),
           Column(
             children: [
             Container(
               padding: EdgeInsets.only(left: 10),
               margin:
               EdgeInsets.only(right: 30, left: 30, top: 20, bottom: 15),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(35),
                 color: Colors.white,
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   SizedBox(
                     width: 10,
                   ),
                   GestureDetector(
                     onTap: () {
                       setState(() {
                         search = searchController.text;
                       });
                     },
                     child: Icon(
                       Icons.search,
                       size: 30,
                       color: Colors.black26,
                     ),
                   ),
                   SizedBox(
                     width: 10,
                   ),
                   Expanded(
                     child: TextField(
                       controller: searchController,
                       onSubmitted: (value) {
                         setState(() {
                           search = value;
                         });
                       },
                       // onsubmitted isliye use krte hein taki textinputaction se input string value ko use kr sake serach k liye
                       textInputAction: TextInputAction
                           .search, //adding go or search many icon to phones keyboard
                       keyboardType: TextInputType.multiline,
                       minLines:
                       1, // Normal textInputField will be displayed
                       maxLines:
                       5, // When user presses enter it will adapt to it
                       decoration: InputDecoration(
                         border: InputBorder.none,
                         hintText: 'Search',
                         contentPadding: EdgeInsets.all(2),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
               Container(
                 padding: EdgeInsets.all(15),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment:MainAxisAlignment.start,
                   children: [
                     Text('What Do You Want To eat?',style: TextStyle(color:Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                     SizedBox(height: 10,),
                     Text('Lets Cook Something New !!',style: TextStyle(color:Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
                   ],
                 ),
               ),
               Text('$search'),
           ],
           )
         ],
       )
     ));
   }
 }
