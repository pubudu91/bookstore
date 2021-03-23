function mapToBook(record { int book_id?; string title?; string first_name?; string last_name?; } book) returns Book => {
    id: book?.book_id ?: -1,
    name: book?.title ?: "",
    author: (book?.first_name ?: "") + " " + (book?.last_name ?: "")
};
