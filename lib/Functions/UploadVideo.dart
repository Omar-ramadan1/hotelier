import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

saveVideoFunction(PickedFile videoFile) async {

  var stream = new http.ByteStream(videoFile.openRead());
  var length = await stream.toBytes();
  Future<Uint8List> byteData = stream.toBytes();

  var request = new http.MultipartRequest("POST", Uri.parse("http://api.hoteliercard.com/api/Upload/Post"));
print(length.toString());
  var multipartFile = new http.MultipartFile.fromBytes('File', length,
      filename: "video.mp4");
  request.files.add(multipartFile);
  var response = await request.send();
  print(response.statusCode);
return response;
}