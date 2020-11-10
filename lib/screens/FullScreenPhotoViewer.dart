import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenPhotoViewer extends StatelessWidget {
  final String imgURL;
  static const routeName = '/FullScreenPhotoViewer';

  const FullScreenPhotoViewer(this.imgURL);
  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizes.height),
        child: AppBar(
          shadowColor: Colors.transparent,
          flexibleSpace: Hero(
              tag: imgURL,
              child: Image.network(
                imgURL,
                fit: BoxFit.fill,
                height: sizes.height,
              )),
        ),
      ),
    );
    // return Container(
    //   width: sizes.width,
    //   height: sizes.height,
    //   child: Image.network(imgURL),
    // );
  }
}
