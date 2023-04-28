import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CreateModel {
  final _picker = ImagePicker();

  Future<File?> getImage() async {
    //이미지피커를 사용해서 이미지를 선택한다
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    return File(image.path);
    //path = 이미지가 생성되는 경로, path는 null값을 안받기때문에 nullable로 바꿔줘야됨
  }
}
