import 'package:hotelier/Constant/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
saveVideoFunction(XFile videoFile , String name) async {
  var stream = new http.ByteStream(videoFile.openRead());
  var length = await stream.toBytes();
  var request = new http.MultipartRequest("POST", Uri.parse("${anotherServerURL}api/Upload/Post"));

  var multipartFile = new http.MultipartFile.fromBytes('File', length,
      filename: name);
  request.files.add(multipartFile);
  var response = await request.send();

return response;
}