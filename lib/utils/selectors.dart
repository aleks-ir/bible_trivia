import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/app_colors.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/app_theme.dart';

AppTheme selectTheme(String themeType) {
  switch (themeType) {
    case DARK:
      return AppTheme(
          primaryColor: AppColors.greyDark,
          secondaryColor: Colors.black12.value,
          appBarColor: AppColors.greyDark,
          shadowColor: Colors.white54.value,
          textColor: AppColors.whiteDefault,
          iconColor: Colors.teal.value);
    default:
      return AppTheme(
          primaryColor: AppColors.whiteDefault,
          secondaryColor: Colors.black12.value,
          appBarColor: AppColors.whiteDefault,
          shadowColor: Colors.black54.value,
          textColor: AppColors.blackDefault,
          iconColor: Colors.teal.value);
  }
}

String selectTranslationUrl(String translationId) {
  switch (translationId) {
    case ASV:
      return ASV_URL;
    case KJV:
      return KJV_URL;
    case NRT:
      return NRT_URL;
    case RST:
      return RST_URL;
    default:
      return ASV_URL;
  }
}

int selectIndexTranslation(String translationId) {
  switch (translationId) {
    case ASV:
      return 0;
    case KJV:
      return 1;
    case NRT:
      return 2;
    case RST:
      return 3;
    default:
      return 0;
  }
}

List<String> selectListDisplayBooks(bool isOldTestament, bool isEnglish) {
  if (isOldTestament) {
    if (!isEnglish) {
      return listBooksOldTestamentRu;
    } else {
      return listBooksOldTestamentEn;
    }
  } else {
    if (!isEnglish) {
      return listBooksNewTestamentRu;
    } else {
      return listBooksNewTestamentEn;
    }
  }
}

Icon selectIconBottomBar(NavigationTab tab) {
  if (tab == NavigationTab.home) {
    return Icon(Icons.home);
  } else if (tab == NavigationTab.reader) {
    return Icon(Icons.book);
  } else if (tab == NavigationTab.pastTrivia) {
    return Icon(Icons.library_books_sharp);
  } else if (tab == NavigationTab.more) {
    return Icon(Icons.list);
  }
  return Icon(Icons.error);
}

String selectLabelBottomBar(NavigationTab tab) {
  if (tab == NavigationTab.home) {
    return home.i18n;
  } else if (tab == NavigationTab.reader) {
    return bible.i18n;
  } else if (tab == NavigationTab.pastTrivia) {
    return trivia.i18n;
  } else if (tab == NavigationTab.more) {
    return more.i18n;
  } else {
    return "";
  }
}

