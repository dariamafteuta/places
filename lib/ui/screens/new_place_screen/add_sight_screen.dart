import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/data/store/add_place_store_base.dart';
import 'package:flutter_job/data/store/places_store_base.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/content.dart';
import 'package:flutter_job/ui/screens/new_place_screen/new_place_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

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
  List<String> list = [];
  final greenColor = themeProvider.appTheme.greenColor;

  void _submitForm() {
    final addPlaceStore = Provider.of<AddPlaceStore>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      final place = Place(
        id: placeFromNet.length + 1,
        lat: double.parse(_latController.text),
        lon: double.parse(_lonController.text),
        name: _nameController.text,
        urls: list,
        placeType: selectedCategory,
        description: _descriptionController.text,
      );

      try {
        Navigator.pop(context);

        addPlaceStore.addNewPlace(place);
      } catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  String? _validateCategory(String value) {
    return value.isEmpty ? 'Выберите категорию' : null;
  }

  String? _validateName(String value) {
    return value.isEmpty ? 'Введите название' : null;
  }

  String? _validateDescription(String value) {
    return value.isEmpty ? 'Введите описание' : null;
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
    final orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

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
              NewPlaceImage(
                images: images,
              ),
              sizedBox24H,
              const Content(content: AppStrings.category),
              sizedBox12H,
              TextFieldOnlyReade(
                focusNode: category,
                controller: selectedCategory,
                validate: _validateCategory,
                updateSelectedCategory: updateSelectedCategory,
              ),
              sizedBox24H,
              const Content(content: AppStrings.name),
              sizedBox12H,
              TextFields(
                focusNode: name,
                controller: _nameController,
                onEditingComplete: latitude,
                validate: _validateName,
                keyboardType: TextInputType.multiline,
              ),
              sizedBox24H,
              Row(
                mainAxisAlignment: orientationPortrait
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Content(content: AppStrings.latitude),
                      sizedBox12H,
                      SizedBox(
                        width: 162,
                        child: TextFields(
                          focusNode: latitude,
                          controller: _latController,
                          onEditingComplete: longitude,
                          validate: _validateLatitude,
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ],
                  ),
                  if (!orientationPortrait) sizedBox24W,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Content(content: AppStrings.longitude),
                      sizedBox12H,
                      SizedBox(
                        width: 162,
                        child: TextFields(
                          focusNode: longitude,
                          controller: _lonController,
                          onEditingComplete: description,
                          validate: _validateLongitude,
                          keyboardType: TextInputType.datetime,
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
                    style: appTypography.text16Bold.copyWith(color: greenColor),
                  ),
                  onPressed: () {},
                ),
              ),
              sizedBox24H,
              const Content(content: AppStrings.description),
              sizedBox12H,
              TextFields(
                focusNode: description,
                controller: _descriptionController,
                onEditingComplete: description,
                validate: _validateDescription,
                keyboardType: TextInputType.multiline,
              ),
              sizedBox24H,
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
                    backgroundColor: greenColor,
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

  void updateSelectedCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void images(List<String> image) {
    setState(() {
      list = image;
    });
  }
}

class TextFields extends StatefulWidget {
  final FocusNode focusNode;
  final FocusNode onEditingComplete;
  final TextEditingController controller;
  final String? Function(String) validate;
  final TextInputType keyboardType;

  const TextFields({
    Key? key,
    required this.focusNode,
    required this.controller,
    required this.onEditingComplete,
    required this.validate,
    required this.keyboardType,
  }) : super(key: key);

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  final mainWhiteColor = themeProvider.appTheme.mainWhiteColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onEditingComplete: () =>
          FocusScope.of(context).requestFocus(widget.onEditingComplete),
      cursorWidth: 1,
      cursorColor: mainWhiteColor,
      style: appTypography.text14Regular.copyWith(color: mainWhiteColor),
      controller: widget.controller,
      onChanged: (value) => setState(() {}),
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        errorBorder: errorBorder,
        enabledBorder: enableBorder,
        focusedBorder: focusBorder,
        suffixIcon: widget.controller.text.isNotEmpty
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(widget.controller.clear);
                },
                child: SvgPicture.asset(
                  AppAssets.clear,
                  color: mainWhiteColor,
                ),
              )
            : null,
      ),
      inputFormatters: [
        if (widget.keyboardType == TextInputType.number)
          FilteringTextInputFormatter.digitsOnly,
      ],
      validator: (val) => widget.validate(val!),
    );
  }
}

class TextFieldOnlyReade extends StatefulWidget {
  final FocusNode focusNode;
  final String controller;
  final String? Function(String) validate;
  final Function(String) updateSelectedCategory;

  const TextFieldOnlyReade({
    Key? key,
    required this.focusNode,
    required this.controller,
    required this.validate,
    required this.updateSelectedCategory,
  }) : super(key: key);

  @override
  State<TextFieldOnlyReade> createState() => _TextFieldOnlyReadeState();
}

class _TextFieldOnlyReadeState extends State<TextFieldOnlyReade> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      readOnly: true,
      controller: TextEditingController(text: widget.controller),
      onTap: () {
        AppNavigation.goToCategories(context, widget.updateSelectedCategory);
      },
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: themeProvider.appTheme.greenColor),
        ),
        hintText: AppStrings.unSelected,
        hintStyle: appTypography.textGreyInactive18Bold,
        suffixIcon: CupertinoButton(
          onPressed: () {
            AppNavigation.goToCategories(
              context,
              widget.updateSelectedCategory,
            );
          },
          child: SvgPicture.asset(
            AppAssets.view,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
        ),
      ),
      validator: (val) => widget.validate(val!),
    );
  }
}
