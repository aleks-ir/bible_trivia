import 'package:i18n_extension/i18n_extension.dart';


const homeAppBar = "homeAppBar";
const triviaAppBar = "triviaAppBar";
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
const show = "show";
const go = "go";
const infoTitle = "infoTitle";
const infoCard = "infoCard";
const infoDialog = "infoDialog";
const close = "close";
const editProfile = "editProfile";
const about = "aboutApp";

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

extension Localization on String {
  static final _t = Translations.from("en_us", {
    homeAppBar: {
      "en": "Weekly Trivia",
      "ru": "Недельная викторина",
    },
    triviaAppBar: {
      "en": "Trivia",
      "ru": "Викторина",
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
    show: {
      "en": "Show",
      "ru": "Показать",
    },
    go: {
      "en": "Go",
      "ru": "Вперед",
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
    editProfile: {
      "en": "Edit profile",
      "ru": "Изменить профиль",
    },
    about: {
      "en": "About application",
      "ru": "О приложении",
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
      "en": "\t\tThis app will help you read your Bible step by step in its entirety. \n\n\t\tParticipate in a weekly quiz. All you have to do is read a few chapters from one book and answer the questions. It\'s easy and doesn\'t take much time.",
      "ru": "\t\tЭто приложение поможет тебе шаг за шагом полностью прочитать Библию. \n\n\t\tПрими участие в еженедельной викторине. Все что нужно будет - это прочитать несколько глав из одной книги и ответить на вопросы. Это просто и не займет много времени.",
    },
    top: {
      "en": "Top",
      "ru": "Рейтинг",
    },
    save: {
      "en": "Save changes",
      "ru": "Сохранить изменения",
    },
  });

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);
}
