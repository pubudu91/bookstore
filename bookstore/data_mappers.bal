function mapToBook(RowType book) returns Book => {
    id: book.book_id,
    name: book.title,
    author: book.first_name + " " + book.last_name
};
