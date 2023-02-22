import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/constants.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_svg/svg.dart';


AppTypography appTypography = AppTypography();

class Categories extends StatefulWidget {
  final Function(String) updateSelectedCategory;

  const Categories({
    Key? key,
    required this.updateSelectedCategory,
  }) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String sCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: CupertinoButton(
          child: SvgPicture.asset(
            AppAssets.arrow,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppStrings.category,
          style: appTypography.text24Bold
              .copyWith(color: themeProvider.appTheme.mainWhiteColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            CategoryButton(
              category: AppStrings.cafe,
              isSelected: sCategory == AppStrings.cafe,
              selectCategory: selectCategory,
            ),
            CategoryButton(
              category: AppStrings.park,
              isSelected: sCategory == AppStrings.park,
              selectCategory: selectCategory,
            ),
            CategoryButton(
              category: AppStrings.museum,
              isSelected: sCategory == AppStrings.museum,
              selectCategory: selectCategory,
            ),
            CategoryButton(
              category: AppStrings.hotel,
              isSelected: sCategory == AppStrings.hotel,
              selectCategory: selectCategory,
            ),
            CategoryButton(
              category: AppStrings.restaurant,
              isSelected: sCategory == AppStrings.restaurant,
              selectCategory: selectCategory,
            ),
            CategoryButton(
              category: AppStrings.particularPlace,
              isSelected: sCategory == AppStrings.particularPlace,
              selectCategory: selectCategory,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: TextButton(
                    child: Text(
                      AppStrings.save.toUpperCase(),
                      style: appTypography.text14Regular
                          .copyWith(color: themeProvider.appTheme.whiteColor),
                    ),
                    style: TextButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: sCategory.isEmpty
                          ? themeProvider.appTheme.inactiveColor
                          : themeProvider.appTheme.greenColor,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        widget.updateSelectedCategory(sCategory);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectCategory(String category) {
    setState(() {
      sCategory = category;
    });
  }
}

class CategoryButton extends StatefulWidget {
  final String category;
  final bool isSelected;
  final Function(String) selectCategory;

  const CategoryButton({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.selectCategory,
  }) : super(key: key);

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              child: Text(
                widget.category,
                style: appTypography.text14Regular.copyWith(
                  fontSize: 18,
                  color: themeProvider.appTheme.secondaryWhiteColor,
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.selectCategory(widget.category);
                });
              },
            ),
            if (widget.isSelected)
              SvgPicture.asset(
                AppAssets.tick,
                color: themeProvider.appTheme.greenColor,
              ),
          ],
        ),
        divider,
      ],
    );
  }
}
