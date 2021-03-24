import ballerina/http;
import ballerina/io;
import ballerina/sql;

listener http:Listener ep0 = new (9090);

service /v1 on ep0 {

    resource function get books(int? 'limit) returns Books|Error {
        int limitOrAll = 'limit ?: 'int:MAX_VALUE;
        sql:ParameterizedQuery query = `SELECT first_name, last_name, title, book_id FROM authors, books 
                                        WHERE authors.author_id = books.author_id 
                                        LIMIT ${limitOrAll};`;
        stream<RowType, sql:Error> result = <stream<RowType, sql:Error>> db->query(query, RowType);
        Book[] books = [];

        sql:Error? forEach = result.forEach(function (record{} row) {
            io:println(row);
            books.push(mapToBook(<RowType>row));
        });

        if (forEach is sql:Error) {
            return {code: 100, message: "Failed to fetch the book catalogue"};
        }

        return {bookslist: books};
    }

    // resource function post books() returns http:Created|Error {

    // }

    // resource function get books/[string bookId]() returns Book|Error {

    // }
}
