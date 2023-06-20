import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/mwwm/add_place_widget_model.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/content.dart';
import 'package:flutter_job/ui/screens/new_place_screen/new_place_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

class AddSightScreen extends CoreMwwmWidget {

  AddSightScreen({Key? key})
      : super(
    key: key,
    widgetModelBuilder: (context) => AddPlaceWidgetModel(
      const WidgetModelDependencies(),
    ),
  );

  @override
  State<StatefulWidget> createState() => _AddSightScreenState();
}

List<String> list = [];

class _AddSightScreenState extends WidgetState<AddPlaceWidgetModel> {
  final category = FocusNode();
  final name = FocusNode();
  final latitude = FocusNode();
  final longitude = FocusNode();
  final description = FocusNode();



  final _formKey = GlobalKey<FormState>();

  String selectedCategory = '';
  final greenColor = themeProvider.appTheme.greenColor;

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
                controller: wm.categoryState,
                validate: wm.validateCategory,
                updateSelectedCategory: updateSelectedCategory,
              ),
              sizedBox24H,
              const Content(content: AppStrings.name),
              sizedBox12H,
              TextFields(
                focusNode: name,
                controller: wm.nameState,
                onEditingComplete: latitude,
                validate: wm.validateName,
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
                          controller: wm.latitudeState,
                          onEditingComplete: longitude,
                          validate: wm.validateLatitude,
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
                          controller: wm.longitudeState,
                          onEditingComplete: description,
                          validate: wm.validateLongitude,
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
                controller: wm.descriptionState,
                onEditingComplete: description,
                validate: wm.validateDescription,
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
                  onPressed: () {
                    wm.submitForm();
                    Navigator.pop(context);
                  },
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
      wm.categoryState.accept(category);
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
  final StreamedState<String> controller;
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
      onChanged: widget.controller.accept,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        errorBorder: errorBorder,
        enabledBorder: enableBorder,
        focusedBorder: focusBorder,
        suffixIcon: widget.controller.value.isNotEmpty
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    widget.controller.value;
                  });
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
  final StreamedState<String> controller;
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
      controller: TextEditingController(text: widget.controller.value),
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
