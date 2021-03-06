import 'package:i18n_extension/i18n_extension.dart';

const homeAppBar = "homeAppBar";
const authorization = "authorization";
const signIn = "signIn";
const signOut = "signOut";
const signUp = "signUp";
const name = "name";
const email = "email";
const password = "password";
const verify = "verify";
const createAccount = "createAccount";
const create = "create";
const home = "home";
const bible = "bible";
const trivia = "trivia";
const more = "more";
const results = "results";
const result = "result";
const start = "start";
const infoTitle = "infoTitle";
const infoCard = "infoCard";
const infoDialog = "infoDialog";
const close = "close";
const continueTo = "continueTo";
const profile = "profile";
const about = "about";
const book = "book";
const questions = "questions";
const minutes = "minutes";
const notAuthError = "notAuthError";
const answeredError = "answeredError";
const otherDateError = "otherDateError";
const notQuestionsError = "notQuestionsError";
const nameError = "nameError";
const emailError = "emailError";
const passwordError = "passwordError";
const passwordMatchError = "passwordMatchError";
const createAccountError = "createAccountError";
const userNotFoundError = "userNotFoundError";
const wrongPasswordError = "wrongPasswordError";
const manyRequestsError = "manyRequestsError";

const infoAbout = "infoAbout";
const top = "top";
const save = "save";
const translation = "translation";
const search = "search";
const oldTestament = "oldTestament";
const newTestament = "newTestament";

const chooseChapter = "chooseChapter";
const completeTrivia = "completeTrivia";
const yes = "yes";
const no = "no";
const next = "next";
const exit = "exit";
const complete = "complete";
const question = "question";
const correct = "correct";
const wrong = "wrong";
const skipped = "skipped";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    homeAppBar: {
      "en": "Weekly Trivia",
      "ru": "Недельная викторина",
    },
    authorization: {
      "en": "Sign In",
      "ru": "Авторизация",
    },
    signIn: {
      "en": "Sign In",
      "ru": "Войти",
    },
    signOut: {
      "en": "Sign Out",
      "ru": "Выйти",
    },
    signUp: {
      "en": "Sign Up",
      "ru": "Регистрация",
    },
    name: {
      "en": "Name",
      "ru": "Имя",
    },
    email: {
      "en": "Email",
      "ru": "Email",
    },
    password: {
      "en": "Password",
      "ru": "Пароль",
    },
    verify: {
      "en": "Verify",
      "ru": "Подтвердить",
    },
    createAccount: {
      "en": "Create Account",
      "ru": "Создать аккаунт",
    },
    create: {
      "en": "Create",
      "ru": "Создать",
    },
    home: {
      "en": "Home",
      "ru": "Дом",
    },
    bible: {
      "en": "Bible",
      "ru": "Библия",
    },
    trivia: {
      "en": "Trivia",
      "ru": "Викторина",
    },
    more: {
      "en": "More",
      "ru": "Еще",
    },
    results: {
      "en": "Results",
      "ru": "Результаты",
    },
    result: {
      "en": "Result",
      "ru": "Результат",
    },
    start: {
      "en": "Start",
      "ru": "Начать",
    },
    infoTitle: {
      "en": "Info about trivia",
      "ru": "Информация о викторине",
    },
    infoCard: {
      "en": "Book: %s\nChapters: %s\nDate: %s\nQuestion: %s\nTime: %s min",
      "ru": "Книга: %s\nГлавы: %s\nДата: %s\nВопросов: %s\nВремя: %s мин",
    },
    infoDialog: {
      "en": "Sign in to begin the trivia, please.",
      "ru": "Чтобы начать викторину, пожалуйста, авторизируйтесь.",
    },
    close: {
      "en": "Close",
      "ru": "Закрыть",
    },
    continueTo: {
      "en": "Continue",
      "ru": "Продолжить",
    },
    profile: {
      "en": "Profile",
      "ru": "Профиль",
    },
    about: {
      "en": "About trivia",
      "ru": "О Викторине",
    },
    book: {
      "en": "Book",
      "ru": "Книга",
    },
    questions: {
      "en": "questions",
      "ru": "вопросов",
    },
    minutes: {
      "en": "min",
      "ru": "мин",
    },
    notAuthError: {
      "en": "Please sign in",
      "ru": "Пожалуйста, авторизируйтесь",
    },
    answeredError: {
      "en": "Good job. Try it in a week",
      "ru": "Хорошая работа. Попробуйте через неделю",
    },
    otherDateError: {
      "en": "Now is not the time to do that",
      "ru": "Сейчас не время это делать",
    },
    notQuestionsError: {
      "en": "Please restart the application",
      "ru": "Пожалуйста, перезапустите приложение",
    },
    nameError: {
      "en": "Name can not be empty",
      "ru": "Имя не может быть пустым",
    },
    emailError: {
      "en": "Email is not valaid",
      "ru": "Некорректный email",
    },
    passwordError: {
      "en": "Password should be at least 6 symbols long",
      "ru": "Длина пароля должна быть более 6 символов",
    },
    passwordMatchError: {
      "en": "Passwords are not match",
      "ru": "Пароли не совпадают",
    },
    createAccountError: {
      "en": "This email is already in use",
      "ru": "Этот email уже используется",
    },
    userNotFoundError: {
      "en": "No user found for that email",
      "ru": "Неверный email",
    },
    wrongPasswordError: {
      "en": "Wrong password provided for that user",
      "ru": "Неверный пароль",
    },
    manyRequestsError: {
      "en": "Try again later...",
      "ru": "Попробуйте позже...",
    },
    infoAbout: {
      "en": "",
      "ru": "",
    },
    top: {
      "en": "Top",
      "ru": "Рейтинг",
    },
    save: {
      "en": "Save changes",
      "ru": "Сохранить изменения",
    },
    translation: {
      "en": "Translation",
      "ru": "Перевод",
    },
    search: {
      "en": "Search",
      "ru": "Поиск",
    },
    oldTestament: {
      "en": "Old",
      "ru": "Ветхий",
    },
    newTestament: {
      "en": "New",
      "ru": "Новый",
    },
    chooseChapter: {
      "en": "Choose a chapter",
      "ru": "Выбирите главу",
    },
    completeTrivia: {
      "en": "Complete the trivia?",
      "ru": "Завершить викторину?",
    },
    yes: {
      "en": "Yes",
      "ru": "Да",
    },
    no: {
      "en": "No",
      "ru": "Нет",
    },
    next: {
      "en": "Next",
      "ru": "След.",
    },
    exit: {
      "en": "Exit",
      "ru": "Выход",
    },
    complete: {
      "en": "Complete",
      "ru": "Завершить",
    },
    question: {
      "en": "Question",
      "ru": "Вопрос",
    },
    correct: {
      "en": "Correct",
      "ru": "Верно",
    },
    wrong: {
      "en": "Wrong",
      "ru": "Неверно",
    },
    skipped: {
      "en": "Skipped",
      "ru": "Пропущено",
    }
  });

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);
}
