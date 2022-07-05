import 'package:flutter/material.dart';
import 'package:tour/core/injector.dart';
import 'package:tour/data/model/category_model.dart';
import 'package:tour/module/screens/menus/place/all_place_by_category.dart';

import '../../../../shared/theme/colors.dart';

class AllCategory extends StatefulWidget {
  final List<CategoryModel> categories;
  const AllCategory({Key? key, required this.categories}) : super(key: key);

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Categories'),
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.categories.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 116,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 7.5,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => si.routerService.nextRoute(
                context,
                AllPlacesByCategory(
                  category: widget.categories[index].category,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.only(right: 14.5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cardColor,
                    ),
                    child: Image.network(
                      widget.categories[index].image,
                      height: 50,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.categories[index].category,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
