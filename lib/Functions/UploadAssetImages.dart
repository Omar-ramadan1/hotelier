import 'dart:convert';
import 'dart:typed_data';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;

uploadAssetImages(Asset image) async {
  print("uploadAssetImages");
  Uri uri =
      Uri.parse("http://api.hoteliercard.com/api/Upload/Post");
  http.MultipartRequest request = http.MultipartRequest("POST", uri);
  ByteData byteData = await image.getByteData();
  List<int> imageData = byteData.buffer.asUint8List();
  http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
    'File',
    imageData,
    filename: "card.jpg",
  );
  request.files.add(multipartFile);
// send
  var response = await request.send();
  print(response.statusCode);

  // response.stream.transform(utf8.decoder).listen((value) {
  //   print(value);
  //   print(jsonDecode(value));
  // });
  return response;
}
