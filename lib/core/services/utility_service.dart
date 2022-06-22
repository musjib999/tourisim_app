import 'package:image_picker/image_picker.dart';
import 'package:tour/data/model/category_model.dart';
import 'package:tour/data/source/json_file.dart';

class UtilityService {
  Future<String> snapPicture() async {
    String path = '';
    final ImagePicker _imagePicker = ImagePicker();
    await _imagePicker.pickImage(source: ImageSource.camera).then((value) {
      path = value!.path;
    });
    return path;
  }

  Future<List<CategoryModel>> getAllCategories() async {
    List<CategoryModel> categoryList = [];
    final categories = await readJson('assets/json/category.json');
    for (var category in categories) {
      CategoryModel categoryModel = CategoryModel.fromJson(category);
      categoryList.add(categoryModel);
    }
    return categoryList;
  }
}
