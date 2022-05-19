import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/app_colors.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/constants_list.dart';
import 'package:weekly_bible_trivia/global/constants_map.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/models/app_theme.dart';

AppTheme selectTheme(String themeType) {
  switch (themeType) {
    case DARK:
      return AppTheme(
          primaryColor: AppColors.greyDark,
          secondaryColor: Colors.grey.shade800.value,
          cardColor: Colors.grey.shade800.value,
          appBarColor: AppColors.greyDark,
          shadowColor: Colors.white54.value,
          textColor: AppColors.whiteDefault,
          iconColor: Colors.teal.value);
    default:
      return AppTheme(
          primaryColor: AppColors.whiteDefault,
          secondaryColor: Colors.grey.shade100.value,
          cardColor: AppColors.whiteDefault,
          appBarColor: AppColors.whiteDefault,
          shadowColor: Colors.black38.value,
          textColor: AppColors.blackDefault,
          iconColor: Colors.lightBlueAccent.value);
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

Icon selectIconBottomBar(NavigationTab tab, Color color) {
  if (tab == NavigationTab.home) {
    return Icon(Icons.home, color: color);
  } else if (tab == NavigationTab.reader) {
    return Icon(Icons.auto_stories, color: color);
  } else if (tab == NavigationTab.pastTrivia) {
    return Icon(Icons.library_books_sharp, color: color);
  } else if (tab == NavigationTab.more) {
    return Icon(Icons.person, color: color);
  }
  return const Icon(Icons.error);
}

String selectBackgroundImage(String theme, bool isPortrait) {
  if (theme == DARK) {
    if (isPortrait) {
      return HOME_DV_IMG;
    } else {
      return HOME_DH_IMG;
    }
  } else {
    if (isPortrait) {
      return HOME_LV_IMG;
    } else {
      return HOME_LH_IMG;
    }
  }
}

Map<int, String> selectMapMonths(String language) {
  if (language == RUSSIAN) {
    return mapMonthsRu;
  } else {
    return mapMonthsEn;
  }
}
