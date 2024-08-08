import java.util.Arrays;

public class LibraryManagementSystem {
    static class Book {
        private String bookId;
        private String title;
        private String author;
        public Book(String bookId, String title, String author) {
            this.bookId = bookId;
            this.title = title;
            this.author = author;
        }
        public String getBookId() {
            return bookId;
        }
        public void setBookId(String bookId) {
            this.bookId = bookId;
        }
        public String getTitle() {
            return title;
        }
        public void setTitle(String title) {
            this.title = title;
        }
        public String getAuthor() {
            return author;
        }
        public void setAuthor(String author) {
            this.author = author;
        }
        @Override
        public String toString() {
            return "BookID: " + bookId + ", Title: " + title + ", Author: " + author;
        }
    }
    public static Book linearSearch(Book[] books, String title) {
        for (Book book : books) {
            if (book.getTitle().equalsIgnoreCase(title)) {
                return book;
            }
        }
        return null; 
    }
    public static Book binarySearch(Book[] books, String title) {
        int low = 0;
        int high = books.length - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            int comparison = books[mid].getTitle().compareToIgnoreCase(title);
            if (comparison == 0) {
                return books[mid];
            } else if (comparison < 0) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return null;
    }
    public static void main(String[] args) {
        Book[] books = {
            new Book("B003", "The Great Gatsby", "F. Scott Fitzgerald"),
            new Book("B001", "To Kill a Mockingbird", "Harper Lee"),
            new Book("B002", "1984", "George Orwell")
        };
        Arrays.sort(books, (b1, b2) -> b1.getTitle().compareToIgnoreCase(b2.getTitle()));
        System.out.println("All Books:");
        for (Book book : books) {
            System.out.println(book);
        }
        String searchTitle = "1984";
        System.out.println("\nPerforming Linear Search for title: " + searchTitle);
        Book linearSearchResult = linearSearch(books, searchTitle);
        System.out.println(linearSearchResult != null ? linearSearchResult : "Book not found");
        System.out.println("\nPerforming Binary Search for title: " + searchTitle);
        Book binarySearchResult = binarySearch(books, searchTitle);
        System.out.println(binarySearchResult != null ? binarySearchResult : "Book not found");
    }
}
