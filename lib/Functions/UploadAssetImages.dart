import 'dart:typed_data';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:hotelier/Constant/Constant.dart';

uploadAssetImages(Asset image , String name) async {
  Uri uri =
      Uri.parse("${anotherServerURL}api/Upload/Post");
  http.MultipartRequest request = http.MultipartRequest("POST", uri);
  ByteData byteData = await image.getByteData();
  List<int> imageData = byteData.buffer.asUint8List();
  http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
    'File',
    imageData,
    filename: name,
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
