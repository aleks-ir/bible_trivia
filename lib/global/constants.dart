const String ASV = "ASV";
const String KJV = "KJV";
const String NRT = "NRT";
const String RST = "RST";

const String TITLE_BIBLE = "Title Bible";

const String ENGLISH = "ENGLISH";
const String RUSSIAN = "RUSSIAN";

const String LIGHT = "LIGHT";
const String DARK = "DARK";

const String TEST_URL = "https://aleks-ir.github.io/data/test.json";
const String ASV_URL = "https://aleks-ir.github.io/data/bible/asv.json";
const String KJV_URL = "https://aleks-ir.github.io/data/bible/kjv.json";
const String NRT_URL = "https://aleks-ir.github.io/data/bible/nrt.json";
const String RST_URL = "https://aleks-ir.github.io/data/bible/rst.json";
const String EMAIL_PATTERN =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

const String FONT_SIZE = "font size";
const String THEME = "theme";
const String LANGUAGE = "language";
const String BOOK_NAME = "book_name";
const String DISPLAY_BOOK_NAME = "display_book_name";
const String CHAPTER = "chapter";
const String TRARSLATION_ID = "translation";
const String DB_HAS_DATA = "database has data";

const String DEFAULT_BOOK_NAME = "Genesis";
const String DEFAULT_DISPLAY_BOOK_NAME = "Genesis";
const int DEFAULT_CHAPTER = 1;
const String DEFAULT_TRARSLATION_ID = "ASV";
const double DEFAULT_FONT_SIZE = 20;
const String DEFAULT_PHOTO_URL =
    "https://firebasestorage.googleapis.com/v0/b/teatauth.appspot.com/o/default_user.jpg?alt=media&token=3c7374ab-a750-4cbb-a5f8-24d8a08fb799";

const List<String> TEST_BOOKS = [
  "Genesis",
  "Exodus",
  "Leviticus",
  "Numbers",
  "Deuteronomy"
];
const String TEST_TEXT =
    "A run of text with a single style. The Text widget displays a string of text with single style. The string might break across multiple lines or might all be displayed on the same line depending on the layout constraints. The style argument is optional. When omitted, the text will use the style from the closest enclosing DefaultTextStyle. If the given style's TextStyle.inherit property is true (the default), the given style will be merged with the closest enclosing DefaultTextStyle. This merging behavior is useful, for example, to make the text bold while using the default font family and size.";

const listTranslationsId = ["ASV", "KJV", "NRT", "RST"];

const listTranslationsName = [
  "American Standard Version",
  "King James Version",
  "Новый русский перевод",
  "Синодальный перевод"
];

const listBooksOldTestamentRu = [
  "Бытие",
  "Исход",
  "Левит",
  "Числа",
  "Второзаконие",
  "Книга Иисуса Навина",
  "Книга Судей",
  "Книга Руфь",
  "1-ая Царств",
  "2-ая Царств",
  "3-яя Царств",
  "4-ая Царств",
  "1-ая Паралипоменон",
  "2-ая Паралипоменон",
  "Книга Ездры",
  "Книга Неемии",
  "Книга Есфирь",
  "Книга Иова",
  "Псалтирь",
  "Книга Притчей",
  "Книга Екклесиаста",
  "Книга Песни Песний",
  "Книга Исаии",
  "Книга Иеремии",
  "Плач Иеремии",
  "Книга Иезекииля",
  "Книга Даниила",
  "Книга Осии",
  "Книга Иоиля",
  "Книга Амоса",
  "Книга Авдия",
  "Книга Ионы",
  "Книга Михея",
  "Книга Наума",
  "Книга Аввакума",
  "Книга Софонии",
  "Книга Аггея",
  "Книга Захарии",
  "Книга Малахии"
];

const listBooksNewTestamentRu = [
  "Евангелие от Матфея",
  "Евангелие от Марка",
  "Евангелие от Луки",
  "Евангелие от Иоанна",
  "Деяния Апостолов",
  "Послание к Римлянам ",
  "1-ое к Коринфянам ",
  "2-ое к Коринфянам ",
  "Послание к Галатам",
  "Послание к Ефесянам",
  "Послание к Филиппийцам ",
  "Послание к Колоссянам ",
  "1-ое к Фессалоникийцам ",
  "2-ое к Фессалоникийцам ",
  "1-ое Тимофею",
  "2-ое Тимофею",
  "Послание к Титу",
  "Послание к Филимону",
  "Послание к Евреям",
  "Послание Иакова",
  "1-ое Петра",
  "2-ое Петра",
  "1-ое Иоанна",
  "2-ое Иоанна",
  "3-ее Иоанна",
  "Послание Иуды ",
  "Откровение"
];

const listBooksOldTestamentEn = [
  "Genesis",
  "Exodus",
  "Leviticus",
  "Numbers",
  "Deuteronomy",
  "Joshua",
  "Judges",
  "Ruth",
  "1 Samuel",
  "2 Samuel",
  "1 Kings",
  "2 Kings",
  "1 Chronicles",
  "2 Chronicles",
  "Ezra",
  "Nehemiah",
  "Esther",
  "Job",
  "Psalms",
  "Proverbs",
  "Ecclesiastes",
  "Song of Solomon",
  "Isaiah",
  "Jeremiah",
  "Lamentations",
  "Ezekiel",
  "Daniel",
  "Hosea",
  "Joel",
  "Amos",
  "Obadiah",
  "Jonah",
  "Micah",
  "Nahum",
  "Habakkuk",
  "Zephaniah",
  "Haggai",
  "Zechariah",
  "Malachi"
];

const mapCountChapters = {
  "Genesis": 50,
  "Exodus": 40,
  "Leviticus" : 27,
  "Numbers" : 36,
  "Deuteronomy" : 34,
  "Joshua" : 24,
  "Judges" : 21,
  "Ruth" : 4,
  "1 Samuel" : 31,
  "2 Samuel" : 24,
  "1 Kings" : 22,
  "2 Kings" : 25,
  "1 Chronicles" : 29,
  "2 Chronicles" : 36,
  "Ezra" : 10,
  "Nehemiah" : 13,
  "Esther" : 10,
  "Job" : 42,
  "Psalms" : 150,
  "Proverbs" : 31,
  "Ecclesiastes" : 12,
  "Song of Solomon" : 8,
  "Isaiah" : 66,
  "Jeremiah" : 52,
  "Lamentations" : 5,
  "Ezekiel" : 48,
  "Daniel" : 12,
  "Hosea" : 14,
  "Joel" : 3,
  "Amos" : 9,
  "Obadiah" : 1,
  "Jonah" : 4,
  "Micah" : 7,
  "Nahum" : 3,
  "Habakkuk" : 3,
  "Zephaniah" : 3,
  "Haggai" : 2,
  "Zechariah": 14,
  "Malachi" : 4,

  "Matthew" : 28,
  "Mark" : 16,
  "Luke" : 24,
  "John" : 21,
  "Acts of the Apostles" : 28,
  "Romans": 16,
  "1 Corinthians" : 16,
  "2 Corinthians" : 13,
  "Galatians" : 6,
  "Ephesians" : 6,
  "Philippians" : 4,
  "Colossians" : 4,
  "1 Thessalonians" : 5,
  "2 Thessalonians" : 3,
  "1 Timothy" : 6,
  "2 Timothy" : 4,
  "Titus" : 3,
  "Philemon" : 1,
  "Hebrews" : 13,
  "James" : 5,
  "1 Peter" : 5,
  "2 Peter" : 3,
  "1 John" : 5,
  "2 John" : 1,
  "3 John" : 1,
  "Jude" : 1,
  "Revelation" : 22
};

const listBooksNewTestamentEn = [
  "Matthew",
  "Mark",
  "Luke",
  "John",
  "Acts of the Apostles",
  "Romans",
  "1 Corinthians",
  "2 Corinthians",
  "Galatians",
  "Ephesians",
  "Philippians",
  "Colossians",
  "1 Thessalonians",
  "2 Thessalonians",
  "1 Timothy",
  "2 Timothy",
  "Titus",
  "Philemon",
  "Hebrews",
  "James",
  "1 Peter",
  "2 Peter",
  "1 John",
  "2 John",
  "3 John",
  "Jude",
  "Revelation"
];

const mapCountChaptersNewTestament = {

};
