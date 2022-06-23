import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
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

  CachedNetworkImage getCachedNetworkImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, image) {
        return Container(
          width: 240,
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      placeholder: (context, image) => Image.asset(
        'assets/images/placeholder.png',
        fit: BoxFit.fill,
        width: 240,
        height: 120,
      ),
    );
  }
}
