import ballerinax/mysql;
import ballerina/sql;
import ballerina/http;
import ballerina/io;

listener http:Listener ep0 = new (9090);

configurable string dbUser = ?;
configurable string dbPassword = ?;

string listBooksQuery = "SELECT first_name, last_name, title, book_id from authors, books where authors.author_id = books.author_id;";

mysql:Client db;

function init() {
    var cl = new mysql:Client("localhost", dbUser, dbPassword, "bookstore", 3306);
    if (cl is error) {
        panic cl;
    } else {
        db = cl;
    }
}

service /v1 on ep0 {

    resource function get books(int? 'limit) returns Books|Error {
        stream<record {}, sql:Error> result = db->query(listBooksQuery);
        Book[] books = [];
        sql:Error? forEach = result.forEach(function (record{} row) {
            io:println(row);
            books.push(mapToBook(<record { int book_id?; string title?; string first_name?; string last_name?; }>row));
        });
        return {bookslist: books};
    }

    // resource function post books() returns http:Created|Error {

    // }

    // resource function get books/[string bookId]() returns Book|Error {

    // }
}
