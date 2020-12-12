import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenPhotoViewer extends StatefulWidget {
  final List imgList;
  final String imageURL;
  static const routeName = '/FullScreenPhotoViewer';

  const FullScreenPhotoViewer(this.imgList , this.imageURL);
  @override
  _FullScreenPhotoViewerState createState() => _FullScreenPhotoViewerState();
}

class _FullScreenPhotoViewerState extends State<FullScreenPhotoViewer> {
  int currentImagePage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int i = 0;
    widget.imgList.forEach((element) {
      if(element == widget.imageURL){
        setState(() {
          currentImagePage = i;
        });
      }
      i++;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizes.height),
        child: AppBar(
          shadowColor: Colors.transparent,
          flexibleSpace: PageView(
            scrollDirection: Axis.horizontal,
            children: [
              for(int i=0; i< widget.imgList.length; i++)
                Hero(
                  tag: "${anotherServerURL}Content/Images/${widget.imgList[i]}" ,
                  child: Container(
                    height: sizes.height,
                    child: PhotoView(
                      customSize: sizes,
                      maxScale: sizes.height,
                      basePosition: Alignment.center,
                      imageProvider:
                      Image.network(
                        "${anotherServerURL}Content/Images/${widget.imgList[i]}",
                        fit: BoxFit.fill,
                        height: sizes.height,
                      ).image,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}



    // return Container(
    //   width: sizes.width,
    //   height: sizes.height,
    //   child: Image.network(imgURL),
    // );
//   }
// }
