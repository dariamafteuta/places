import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/ui/res/app_colors.dart';
import 'package:flutter_job/ui/res/app_typography.dart';

class SightCardPlan extends StatelessWidget {
  final Sight? sight;

  const SightCardPlan({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: Image.network(
                      sight!.url,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : const CupertinoActivityIndicator(),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 17,
                    right: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 25,
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.close_rounded,
                        size: 30,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 19,
                  left: 18,
                  child: Text(
                    sight!.type,
                    style: AppTypography.textWhite14Regular,
                  ),
                ),
              ],
            ),
            Positioned(
              height: 200,
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.lightGrayColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                height: 100,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        sight!.name,
                        style: AppTypography.textTitle17Bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 5,
                        right: 16,
                      ),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Запланировано на 12 окт. 2022',
                        style: AppTypography.textGreen14Regular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
