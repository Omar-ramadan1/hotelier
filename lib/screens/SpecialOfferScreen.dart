import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:hotelier/widgets/HotelContainerWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

class SpecialOfferScreen extends StatefulWidget {
    static const routeName = '/specia';

  @override
  _SpecialOfferScreenState createState() => _SpecialOfferScreenState();
}
class Category {
  int id;
  String name;
  Category(this.id, this.name);

  static List<Category> getCategory() {
    return <Category>[
      Category(1, 'منتجعات'),
      Category(2, 'شقق فندقيه'),
      Category(3, 'فنادق'),
      
      Category(4, 'other'),
    ];
  }
}

class _SpecialOfferScreenState extends State<SpecialOfferScreen> {
    List<Category> _category = Category.getCategory();

List<DropdownMenuItem<Category>> _dropdownItems;
  Category _selectedCategory;
    @override
  void initState() {
    _dropdownItems = buildDrobDownMenuItems(_category);
    _selectedCategory = _dropdownItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Category>> buildDrobDownMenuItems(List categories) {
    List<DropdownMenuItem<Category>> items = List();
    for (Category cat in categories) {
      items.add(DropdownMenuItem(
        value: cat,
        child: Text(cat.name),
      ));
    }
    return items;
  }
  
  onchangeDropdownItems(Category selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }
@override
  Widget build(BuildContext context) {

    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/hotel-bell.jpg"," ${_selectedCategory.name}"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(

                  children: [
                    Text(
                      "الفندق",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    DropdownWidget( عابدين" , ["عابدين" ,"اخر"] , 60 , 20,(value){print(value); }),
                  ],
                ),

                Column(

                  children: [
                    Text("نسبه الخصم",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    DropdownWidget("10%" , ["10%" , "20%" , "30%" ] , 60 , 20,(value){print(value); }),
                  ],
                ),

                Column(

                  children: [
                    Text("التصنيف",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    //DropdownWidget("10%" , ["10%" , "20%" , "30%" ] , 60 , 20,(value){print(value); }),
                  DropdownButton(
               // style: TextStyle(color: Colors.blue, fontSize: 24),
                
                //dropdownColor: Colors.blue,
                value: _selectedCategory,
                items: _dropdownItems,
                onChanged: onchangeDropdownItems,
              ),
                  ],
                ),
                Column(

                  children: [
                    Text("عدد النجوم",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    DropdownWidget('1' , ['1','2','3','4','5'] , 40 , 20,(value){print(value); }),
                  ],
                ),

              ],
            ),
              
            SizedBox(height: 50),
            HotelContainerWidget(),
            SizedBox(height: 10),
            HotelContainerWidget(),
            SizedBox(height: 10),
            HotelContainerWidget(),
            SizedBox(height: 10),
            HotelContainerWidget(),
            SizedBox(height: 10),
            HotelContainerWidget(),
            SizedBox(height: 10),
          ],
        ),
      ),
    //  bottomNavigationBar: BottomBarWidget(),
    );
  }
}
