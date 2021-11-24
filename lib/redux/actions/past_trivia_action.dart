
class SelectBookAction {
  final int newBook;
  SelectBookAction(this.newBook);
}

class UpdateListBooksAction {
  final List<String> newBooks;
  UpdateListBooksAction(this.newBooks);
}
