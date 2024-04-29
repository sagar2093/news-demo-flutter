
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_flutter/data/api/api_config.dart';
import 'package:news_flutter/ui/news_category/news_category_tab.dart';

import '../../res/res.dart';

const _buttonHeight = Dimens.dp8x4;
const _buttonMargin = Dimens.dp8x2;

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _buttonHeight + _buttonMargin * 2,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
            vertical: _buttonMargin, horizontal: Dimens.pageHorizontalPadding),
        scrollDirection: Axis.horizontal,
        itemCount: NewsCategory.values.length,
        itemBuilder: (context, index){
          var item = NewsCategory.values[index];
          return SizedBox(
            height: _buttonHeight,
            child: TagButton(toBeginningOfSentenceCase(item.name),onPressed: (){
              Navigator.pushNamed(context, NewsCategoryTab.routeName,arguments: item.name);
            },),
          );
        },
        separatorBuilder: (context, index) =>
        const SizedBox(width: Dimens.dp4x3),
      ),
    );
  }
}

class TagButton extends StatelessWidget {
  const TagButton(
      this.text, {
        this.onPressed,
        this.backgroundColor = Colors.white70,
        this.textColor = AppColors.primary,
        super.key,
      });

  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.only(left: Dimens.dp8x2,right: Dimens.dp8x2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: textColor ?? const Color(0xFFD4D4D4)),
        ),
      ),
      child: Text(text),
    );
  }
}
