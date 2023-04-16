import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/RecipeView.dart';
import 'package:food_recipe_app/model.dart';
import 'package:food_recipe_app/search.dart';
import 'package:http/http.dart';
 class Home extends StatefulWidget {
   const Home({Key? key}) : super(key: key);

   @override
   State<Home> createState() => _HomeState();
 }
String search='';
 class _HomeState extends State<Home> {
   bool isloading =true;
   List<RecipeModel> recipelist = <RecipeModel>[];
   TextEditingController searchController =new TextEditingController();

    getRecipe(String query)async {
     String url="https://api.edamam.com/search?q=$query&app_id=ad06d07c&app_key=e3d8df37a605c84f260617076cf7db42";
     Response response = await get(Uri.parse(url));
     Map data =jsonDecode(response.body);
     // log(data.toString());// jo bhi data hoga woh string m hona chahiye
    data["hits"].forEach((element){
      RecipeModel recipeModel = new RecipeModel();
      recipeModel= RecipeModel.fromMap(element["recipe"]);
      recipelist.add(recipeModel);
      setState(() {
        isloading=false;
      });
      // log(recipelist.toString());
    });
    // forEach is a method that allows you to iterate over a collection of elements and
     // perform an action on each of them. This method is useful when you need to perform the
     // same operation on every element in a list

    // fromMap is a factory constructor that allows you to create a new instance of a class
     // from a Map object. This method is useful when you have data in a Map format and you want
     // to convert it into an object.
    recipelist.forEach((recipe) {
      print(recipe.applabel);
    });
   }
   @override
  void initState() {
    // TODO: implement initState
    getRecipe("samosa");
    super.initState();
  }
   @override
   Widget build(BuildContext context) {
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
           SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child: Column(
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
                         if ((searchController.text).replaceAll(" ", "") ==
                             "") {
                           print("Blank search");
                         } else {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
                         }
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
                             getRecipe(searchController.text);
                             Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
                             // recipelist.clear();
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
                           hintText: 'Search Here Ex:-Samosa',
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
                 // Text('$search'),
                 Container(
                   child: isloading? CircularProgressIndicator(): ListView.builder(
                     physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       // itemCount: recipelist.length,
                       itemCount:recipelist.length,
                       itemBuilder: (context,index){
                   return InkWell(
                     onTap: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context)=>RecipeView(recipelist[index].appurl) ));
                     },
                     child: Card(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       margin: EdgeInsets.all(15),
                       child: Stack(
                         children: [
                           ClipRRect(
                             // child: Image.network(recipelist[index].appimgurl,),
                             child:Image.network(recipelist[index].appimgurl,
                             fit: BoxFit.cover,
                               width: double.infinity,
                               height: 280,
                             ),
                             borderRadius: BorderRadius.circular(10),
                           ),
                           Positioned(
                             left: 0,
                             bottom: 0,
                             right: 0,
                             child: Container(

                               decoration: BoxDecoration(
                                 color: Colors.black26
                               ),
                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                               child: Text(recipelist[index].applabel,
                               style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                               ),
                             ),
                             ),
                           Positioned(
                             right: 0,
                             child: Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only(
                                   bottomLeft: Radius.circular(20),
                                 ),
                                   color: Colors.black26,

                               ),
                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Icon(Icons.local_fire_department,color: Colors.white,),
                                   Text((recipelist[index].appcalories).toString().substring(0,6),
                                   style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                   ),
                                 ],
                               ),
                             ),
                           )
                         ],
                       ),
                     ),

                   );
                   //  return Text('lol');
                 }
                 ),
                 ),
             ],
             ),
           )
         ],
       )
     ));
   }
 }

 
//e3d8df37a605c84f260617076cf7db42
//ad06d07c
//https://api.edamam.com/search?q=chicken&app_id=${YOUR_APP_ID}&app_key=${YOUR_APP_KEY}&from=0&to=3&calories=591-722&health=alcohol-free