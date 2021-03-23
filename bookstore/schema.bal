type Book record {
    int id;
    string name;
    string author;
};

type Books record {
    Book[] bookslist;
};

type Error record {
    int code;
    string message;
};
