import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/containers/bars/simple_appbar.dart';
import 'package:weekly_bible_trivia/containers/table_results_container.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';


class TableResultsScreen extends StatelessWidget {
  const TableResultsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar(results.i18n, NavigateFromTableResultsToHomeScreenAction()),
          body: TableResultsContainer(),
      );
}
