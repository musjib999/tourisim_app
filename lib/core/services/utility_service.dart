import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour/data/model/category_model.dart';
import 'package:tour/data/source/json_file.dart';

class UtilityService {
  Future<String> snapPicture(ImageSource imageSource) async {
    String path = '';
    final ImagePicker _imagePicker = ImagePicker();
    await _imagePicker
        .pickImage(source: imageSource, imageQuality: 75)
        .then((value) {
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

  CachedNetworkImage getCachedNetworkImage(
      {required String url, double? height, double? width}) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, image) {
        return Container(
          width: width ?? 250,
          height: height ?? 140,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
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
