import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:hotelier/Constant/Constant.dart';

uploadAssetImages(Asset image , String name) async {
  Uri uri =
      Uri.parse("${anotherServerURL}api/Upload/Post");
  http.MultipartRequest request = http.MultipartRequest("POST", uri);
  ByteData byteData = await image.getByteData();
  final result = await FlutterImageCompress.compressWithList(byteData.buffer.asUint8List() , quality: 15);
  print(result.length);

  print(byteData.buffer.asUint8List().length);
  http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
    'File',
    result,
    filename: name,
  );
  request.files.add(multipartFile);
// send
  var response = await request.send();
  print(response.statusCode);

  return response;
}
