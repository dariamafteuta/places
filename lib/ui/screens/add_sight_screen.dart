import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/domain/coordinate.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screens/new_place_category.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppTypography appTypography = AppTypography();

class AddSightScreen extends StatefulWidget {
  final Function(Sight) newSight;

  const AddSightScreen({Key? key, required this.newSight}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
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
                          keyboardType: TextInputType.number,
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
                    backgroundColor: _color(),
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

  Color _color() {
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
}

class Content extends StatelessWidget {
  final String content;

  const Content({Key? key, required this.content}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onEditingComplete: () =>
          FocusScope.of(context).requestFocus(widget.onEditingComplete),
      cursorWidth: 1,
      cursorColor: themeProvider.appTheme.mainWhiteColor,
      style: appTypography.text14Regular
          .copyWith(color: themeProvider.appTheme.mainWhiteColor),
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
                  color: themeProvider.appTheme.mainWhiteColor,
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
        Navigator.push<AddSightScreen>(
          context,
          MaterialPageRoute(
            builder: (context) => Categories(
              updateSelectedCategory: widget.updateSelectedCategory,
            ),
          ),
        );
      },
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: themeProvider.appTheme.greenColor),
        ),
        hintText: AppStrings.unSelected,
        hintStyle: appTypography.textGreyInactive18Bold,
        suffixIcon: CupertinoButton(
          onPressed: () {
            Navigator.push<AddSightScreen>(
              context,
              MaterialPageRoute(
                builder: (context) => Categories(
                  updateSelectedCategory: widget.updateSelectedCategory,
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
      validator: (val) => widget.validate(val!),
    );
  }
}
