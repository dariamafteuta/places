import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_job/constants.dart';
import 'package:flutter_job/domain/coordinate.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screens/new_place_category.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddSightScreen extends StatefulWidget {
  final Function(Sight) newSight;

  const AddSightScreen({Key? key, required this.newSight}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

AppTypography appTypography = AppTypography();

class _AddSightScreenState extends State<AddSightScreen> {
  final category = FocusNode();
  final name = FocusNode();
  final latitude = FocusNode();
  final longitude = FocusNode();
  final description = FocusNode();

  final _nameController = TextEditingController();
  final _lonController = TextEditingController();
  final _latController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String selectedCategory = '';

  @override
  void dispose() {
    _nameController.dispose();
    _lonController.dispose();
    _latController.dispose();
    _descriptionController.dispose();

    category.dispose();
    name.dispose();
    latitude.dispose();
    longitude.dispose();
    description.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 100,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(
            AppStrings.cancel,
            style: appTypography.textGreyInactive18Bold,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.newPlace,
          style: appTypography.text24Bold
              .copyWith(color: themeProvider.appTheme.mainWhiteColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const _Content(content: AppStrings.category),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                focusNode: category,
                readOnly: true,
                controller: TextEditingController(text: selectedCategory),
                onTap: () {
                  Navigator.push<AddSightScreen>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Categories(
                        updateSelectedCategory: updateSelectedCategory,
                      ),
                    ),
                  );
                },
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(name),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: themeProvider.appTheme.greenColor),
                  ),
                  hintText: AppStrings.unSelected,
                  hintStyle: appTypography.textGreyInactive18Bold,
                  suffixIcon: CupertinoButton(
                    onPressed: () {
                      Navigator.push<AddSightScreen>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Categories(
                            updateSelectedCategory: updateSelectedCategory,
                          ),
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      AppAssets.view,
                      color: themeProvider.appTheme.mainWhiteColor,
                    ),
                  ),
                ),
                validator: (val) => val!.isEmpty ? 'Выберите категорию' : null,
              ),
              const SizedBox(
                height: 24,
              ),
              const _Content(content: AppStrings.name),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                focusNode: name,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(latitude),
                cursorWidth: 1,
                cursorColor: themeProvider.appTheme.mainWhiteColor,
                style: appTypography.text14Regular
                    .copyWith(color: themeProvider.appTheme.mainWhiteColor),
                controller: _nameController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  errorBorder: errorBorder,
                  enabledBorder: enableBorder,
                  focusedBorder: focusBorder,
                  suffixIcon: _nameController.text.isNotEmpty
                      ? CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: _nameController.clear,
                          child: SvgPicture.asset(
                            AppAssets.clear,
                            color: themeProvider.appTheme.mainWhiteColor,
                          ),
                        )
                      : null,
                ),
                validator: (val) =>
                    val!.isEmpty ? 'Введите название места' : null,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Content(content: AppStrings.latitude),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: 162,
                        child: TextFormField(
                          focusNode: latitude,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(longitude),
                          cursorWidth: 1,
                          cursorColor: themeProvider.appTheme.mainWhiteColor,
                          keyboardType: TextInputType.number,
                          style: appTypography.text14Regular.copyWith(
                            color: themeProvider.appTheme.mainWhiteColor,
                          ),
                          controller: _latController,
                          onChanged: (value) => setState(() {}),
                          decoration: InputDecoration(
                            errorBorder: errorBorder,
                            enabledBorder: enableBorder,
                            focusedBorder: focusBorder,
                            suffixIcon: _latController.text.isNotEmpty
                                ? CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: _latController.clear,
                                    child: SvgPicture.asset(
                                      AppAssets.clear,
                                      color:
                                          themeProvider.appTheme.mainWhiteColor,
                                    ),
                                  )
                                : null,
                          ),
                          validator: (value) => _validateLatitude(value!),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Content(content: AppStrings.longitude),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: 162,
                        child: TextFormField(
                          focusNode: longitude,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(description),
                          cursorWidth: 1,
                          cursorColor: themeProvider.appTheme.mainWhiteColor,
                          keyboardType: TextInputType.number,
                          style: appTypography.text14Regular.copyWith(
                            color: themeProvider.appTheme.mainWhiteColor,
                          ),
                          controller: _lonController,
                          onChanged: (value) => setState(() {}),
                          decoration: InputDecoration(
                            errorBorder: errorBorder,
                            enabledBorder: enableBorder,
                            focusedBorder: focusBorder,
                            suffixIcon: _lonController.text.isNotEmpty
                                ? CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: _lonController.clear,
                                    child: SvgPicture.asset(
                                      AppAssets.clear,
                                      color:
                                          themeProvider.appTheme.mainWhiteColor,
                                    ),
                                  )
                                : null,
                          ),
                          validator: (value) => _validateLongitude(value!),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    AppStrings.specifyOnTheMap,
                    style: appTypography.text16Bold
                        .copyWith(color: themeProvider.appTheme.greenColor),
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const _Content(content: AppStrings.description),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                focusNode: description,
                onEditingComplete: () => FocusScope.of(context).unfocus(),
                cursorWidth: 1,
                cursorColor: themeProvider.appTheme.mainWhiteColor,
                style: appTypography.text14Regular.copyWith(
                  color: themeProvider.appTheme.mainWhiteColor,
                ),
                controller: _descriptionController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  errorBorder: errorBorder,
                  enabledBorder: enableBorder,
                  focusedBorder: focusBorder,
                  suffixIcon: _descriptionController.text.isNotEmpty
                      ? CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: _descriptionController.clear,
                          child: SvgPicture.asset(
                            AppAssets.clear,
                            color: themeProvider.appTheme.mainWhiteColor,
                          ),
                        )
                      : null,
                ),
                validator: (val) =>
                    val!.isEmpty ? 'Введите описание места' : null,
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  child: Text(
                    AppStrings.create.toUpperCase(),
                    style: appTypography.text14Regular
                        .copyWith(color: themeProvider.appTheme.whiteColor),
                  ),
                  style: TextButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: color(),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submitForm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color color() {
    var color = themeProvider.appTheme.inactiveColor;

    if (selectedCategory.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _lonController.text.isNotEmpty &&
        _latController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      color = themeProvider.appTheme.greenColor;
    }

    return color;
  }

  void updateSelectedCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        widget.newSight(
          Sight(
            name: _nameController.text,
            coordinate: Coordinate(
              lat: double.parse(_latController.text),
              lon: double.parse(_lonController.text),
            ),
            url:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKwIViXzr8IpPKK5ASHcPXyLdfo5yHtNjk9Q&usqp=CAU',
            details: _descriptionController.text,
            type: selectedCategory,
          ),
        );
      });
      Navigator.pop(context);
    }
  }

  String? _validateLatitude(String value) {
    if (value.isEmpty) {
      return 'Введите координаты';
    } else if (double.parse(value) > 90) {
      return 'Неправельные координаты';
    } else {
      return null;
    }
  }

  String? _validateLongitude(String value) {
    if (value.isEmpty) {
      return 'Введите координаты';
    } else if (double.parse(value) > 180) {
      return 'Неправельные координаты';
    } else {
      return null;
    }
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        content.toUpperCase(),
        style: appTypography.textGreyInactive14Regular,
      ),
    );
  }
}
