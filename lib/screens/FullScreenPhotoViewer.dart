import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenPhotoViewer extends StatefulWidget {
  final List imgList;
  final String imageURL;
  static const routeName = '/FullScreenPhotoViewer';

  const FullScreenPhotoViewer(this.imgList, this.imageURL);
  @override
  _FullScreenPhotoViewerState createState() => _FullScreenPhotoViewerState();
}

class _FullScreenPhotoViewerState extends State<FullScreenPhotoViewer> {
  int currentImagePage;
  PhotoViewController controller;
  double scaleCopy;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PhotoViewController()..outputStateStream.listen(listener);
    int i = 0;
    widget.imgList.forEach((element) {
      if (element == widget.imageURL) {
        setState(() {
          currentImagePage = i;
        });
      }
      i++;
    });
  }

  void listener(PhotoViewControllerValue value) {

      print(controller.prevValue.position);
      if(controller.prevValue.scale != null){
        if (controller.position == controller.initial.position && controller.prevValue.scale > controller.scale && controller.prevValue.position == controller.initial.position) {
          print("1111111111111");
          controller.value = controller.initial;
        }else if (controller.position == controller.initial.position && controller.prevValue.scale < controller.scale){
          controller.value = controller.initial;
          print("22222222222222222");
        }
      }


  }

  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizes.height),
        child: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.black,
          leading:
          IconButton(
            icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          flexibleSpace: PageView(
            scrollDirection: Axis.horizontal,
            children: [
              for (int i = 0; i < widget.imgList.length; i++)
                Container(
                  color: Colors.black,
                  height: sizes.height,
                  child: PhotoView(
                    controller: controller,
                    loadFailedChild: Container(
                      color: Colors.black,
                    ),
                    customSize: sizes,
                    maxScale: sizes.height,
                    basePosition: Alignment.center,
                    imageProvider: Image.network(
                      "${anotherServerURL}Content/Images/${widget.imgList[i]}",
                      fit: BoxFit.fill,
                      height: sizes.height,
                    ).image,
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
