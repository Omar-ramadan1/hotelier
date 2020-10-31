import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/AppBarWidget.dart';
import '../widgets/AppDrawerWidget.dart';
import '../widgets/MainScreenCardWidget.dart';
import '../widgets/bottomBarWidget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Special_Offer extends StatefulWidget {
  Special_Offer() : super();

  final String title = "Carousel Demo";

  @override
  Special_OfferState createState() => Special_OfferState();
}

class Special_OfferState extends State<Special_Offer> {
  //
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];


  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

YoutubePlayerController _controller =YoutubePlayerController(
  initialVideoId: "BE9ATY2Ygas&ab_channe",
  flags: YoutubePlayerFlags(
    autoPlay: true,
    mute: false
  )
  );
  @override
  Widget build(BuildContext context) {
        Size size =  MediaQuery.of(context).size;

    return Scaffold(
         drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/hotel-bell.jpg"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
              child: Container(
                child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                //SizedBox(height:),
                Text("فندق المعمرين الرياض",style: TextStyle(fontSize:24,fontWeight: FontWeight.bold),),
                SizedBox(height:10),
                carouselSlider = CarouselSlider(
                  height: 160.0,
                  aspectRatio:1/3,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  reverse: false,
                  enableInfiniteScroll: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(milliseconds: 2000),
                  pauseAutoPlayOnTouch: Duration(seconds: 10),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                  items: imgList.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          
                          width: 400,
                          
                          margin: EdgeInsets.symmetric(horizontal:25.0,vertical: 2),
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),  
                            color: Colors.green,
                          ),
                          child: Image.network(
                    //        imgUrl,
                        "",
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(imgList, (index, url) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index ? Colors.black : Colors.yellow,
                      ),
                    );
                  }),
                ),
            
                Container(
                    child:
                     Column(
                       children: [
                            Padding(
                              padding: const EdgeInsets.only(left:80),
                              child: Text("فندق المعمرين الرياض",style: TextStyle(color:Colors.black,fontSize:24),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                
                               
                                
                                Text("  اشارع اجياد23 الرياض \nالمملكه العريبه السعوديه",
                                style: TextStyle(color:Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                 IconButton(onPressed: null,
                                icon: Icon(Icons.gps_fixed)
                                
                                ,),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text("088564749",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
                              ),
                                IconButton(icon: Icon(Icons.phone), onPressed: null),
                               // Text("088564749")
                              ],

                            ),
                            Text("___________________________________________"),
                            Row(
                              children:[
                                Text(" pmجميع الاوقات        8:30")

                                ,
                                //Text("         |"),
                                Spacer(),
                                Text(" متاح اليوم        8:30")





                              ]
                            ) ,
                                                        Text("___________________________________________"),

                            SizedBox(height: 75),
                            
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Container(
                                
                                
                            //     child:   YoutubePlayer(
                            //      controller: _controller,
                            //    showVideoProgressIndicator: false,
                            //      progressIndicatorColor: Colors.blueAccent,
                            //    )
                            //   ),
                            // )
                           
                       ],
                     ),
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(40),
                    color: Colors.blue ,
                    
                    ),
                  

                  
                  
     //margin: EdgeInsets.only(top: 10),
          // // decoration: BoxDecoration(
          // //   color: Colors.black,
          // //   image: DecorationImage(
          // //       image: Image.asset(
          // //         "assets/card.jpg"
                
          // //       ).image,
                
          // //       ),
                
          // // ),
         // height: size.height -80,
         height: 500,
          width: size.width / 1.24,

    ),
    SizedBox(height:25),
    Column(
      children:<Widget>[
              // Row(
              //   children: [
              //     Container(
              //       height: 100,
              //       child: CircleAvatar(
              //         child: Container(
              //           height: 150,
              //           color: Colors.white,
              //           child: CircleAvatar(
              //             child: IconButton(
              //               onPressed: null,
              //               icon:Icon(
              //                 Icons.wifi
              //               )
              //             ),
              //           ),
              //
              //           ),
              //       ),
              //       ),
              //                           Spacer(),
              //
              //          Container(
              //       height: 100,
              //       child: CircleAvatar(
              //         child: Container(
              //           height: 150,
              //           color: Colors.white,
              //           child: CircleAvatar(
              //             child: IconButton(
              //               onPressed: null,
              //               icon:Icon(
              //                 Icons.wifi
              //               ),
              //               color: Colors.blue,
              //             ),
              //           ),
              //
              //           ),
              //       ),
              //       ),
              //                           Spacer(),
              //
              //          Container(
              //       height: 100,
              //       child: CircleAvatar(
              //         child: Container(
              //           height: 150,
              //           color: Colors.white,
              //           child: CircleAvatar(
              //                                     child: IconButton(
              //               onPressed: null,
              //               icon:Icon(
              //                 Icons.wifi
              //               )
              //             ),
              //           ),
              //
              //           ),
              //       ),
              //       ),
              //                           Spacer(),
              //
              //        Container(
              //       height: 100,
              //       child: CircleAvatar(
              //         child: Container(
              //           height: 150,
              //           color: Colors.white,
              //           child: CircleAvatar(
              //                                     child: IconButton(
              //               onPressed: null,
              //               icon:Icon(
              //                 Icons.wifi
              //               )
              //             ),
              //           ),
              //
              //           ),
              //       ),
              //       ),
              //       Spacer(),
              //          Container(
              //       height: 100,
              //       child: CircleAvatar(
              //         child: Container(
              //           height: 150,
              //           color: Colors.white,
              //           child: CircleAvatar(
              //                                     child: IconButton(
              //               onPressed: null,
              //               icon:Icon(
              //                 Icons.wifi
              //               )
              //             ),
              //           ),
              //
              //           ),
              //       ),
              //       ),
              //   ],
              // ),
                

      ]
    )
            ],
          ),
        ),
              ),
      ),
      
                  bottomNavigationBar : BottomBarWidget(),

    );
  }

}