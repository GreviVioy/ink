import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ink/pages/body_text.dart';

class PageNavigatorProvider extends ChangeNotifier {
  int index = 0;
  List<Widget> page = const [BodyText()];

  void geToPage(int newIndex) {
    index = newIndex;
    notifyListeners();
  }
}

class DataProvider extends ChangeNotifier {
  List<BookSample> library = [];
  //Editor var
  List<String> textEdit = [];

  void editing(int i, {String char = 'null'}) {
    i == 0
        ? textEdit.isEmpty
            ? null
            : textEdit.removeLast()
        : textEdit.add(char);
    notifyListeners();
  }
}

class BookSample {
  late String name;
  late int id;
  List<ChapterSample> chapters = [];
  late File? cover;

  BookSample({
    required this.name,
    required this.id,
    required this.chapters,
    required this.cover,
  });
}

class ChapterSample {
  late String title;
  late int numberChapter;
  late String bodyText;

  ChapterSample({
    required this.title,
    required this.numberChapter,
    required this.bodyText,
  });
}
