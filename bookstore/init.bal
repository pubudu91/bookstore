import ballerinax/mysql;

configurable string dbUser = ?;
configurable string dbPassword = ?;

mysql:Client db;

function init() {
    var cl = new mysql:Client("localhost", dbUser, dbPassword, "bookstore", 3306);
    if (cl is error) {
        panic cl;
    } else {
        db = cl;
    }
}
