import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog_app/models/catalog.dart';
import 'package:flutter_catalog_app/widgets/drawer.dart';
import 'package:flutter_catalog_app/widgets/items_widget.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Dummy List Generator Starts Here
  //final bravo = List.generate(20, (index) => MyCatalogModel.product[0]);
  // Init State Starts Here  
  @override
  void initState() {    
    super.initState();
    myloadData();
  }

  // Using Function MyloadData for init 
  myloadData() async {    
    //await Future.delayed(Duration(seconds: 5));
      var catalogJson = await rootBundle.loadString("assets/files/catalog.json");
      var myDecodedData = jsonDecode(catalogJson); 
      var productDataFromDecoded = myDecodedData["products"];

      // Dummy list for Json Mapping
      List<Items> mylist = List.from(productDataFromDecoded).map<Items>((item) => Items.fromMap(item)).toList();
      
      // It's working will delete the above list later
      MyCatalogModel.product = List.from(productDataFromDecoded).map<Items>((item) => Items.fromMap(item)).toList();
      setState(() { }); /* Most People Search it on Stackoverflow */
      //      

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text(
            "Catalog App",
          ),
        ),
      ),      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyCatalogModel.product != null && MyCatalogModel.product.isNotEmpty         
        ? GridView.builder(          
          itemCount: MyCatalogModel.product.length,          
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16
            ),
          itemBuilder: (BuildContext context , int index){
            final xyz = MyCatalogModel.product[index];
            return Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(                
                borderRadius: BorderRadius.circular(10)),
              child: GridTile(
                header: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple                    
                    ),
                  child: Text(xyz.name, style: TextStyle(color: Colors.white, ),)),                
                child: Container(
                  padding: EdgeInsets.all(40),
                  child: Image.network(xyz.imageUrl)
                  ),
                footer: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple                    
                    ),
                  child: Text(xyz.price.toString(), style: TextStyle(color: Colors.white, ),))
              ),
            );
          }
          )
        : Center(child: CircularProgressIndicator(),),
      ),
      drawer: MyDrawer(),
    );
  }
}
