import 'package:flutter/material.dart';
import 'package:news_flutter/res/res.dart';

class AppTheme {
  static get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary, background: Colors.grey.shade100),
        appBarTheme: AppBarTheme(
            color: Colors.white,
            foregroundColor: Colors.black,
            surfaceTintColor: Colors.white),
        cardTheme: CardTheme(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.zero,
            surfaceTintColor: Colors.transparent),
        tabBarTheme: TabBarTheme(
          tabAlignment: TabAlignment.start,
          /*indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2, color: Color(0xFFE11B22)),
          ),*/
          labelPadding: const EdgeInsets.symmetric(horizontal: Dimens.dp4x3),
          labelColor: Color(0xFF555A66),
          unselectedLabelColor: const Color(0xFF555A66).withOpacity(0.8),
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF555A66)),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: const Color(0xFF555A66).withOpacity(0.8),
          ),
        ),
      );
}
