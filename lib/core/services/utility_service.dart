import 'package:image_picker/image_picker.dart';

class UtilityService {
  Future<String> snapPicture() async {
    String path = '';
    final ImagePicker _imagePicker = ImagePicker();
    await _imagePicker.pickImage(source: ImageSource.camera).then((value) {
      path = value!.path;
    });
    return path;
  }
}
