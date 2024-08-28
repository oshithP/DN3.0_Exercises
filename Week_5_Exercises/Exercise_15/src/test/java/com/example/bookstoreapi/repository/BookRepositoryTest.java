package com.example.bookstoreapi.repository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.example.bookstoreapi.entity.Book;

import static org.junit.jupiter.api.Assertions.assertEquals;

@DataJpaTest
public class BookRepositoryTest {

    @Autowired
    private BookRepository bookRepository;

    @Test
    public void testFindById() {
        Book book = new Book();
        book.setTitle("The Book Title");
        book.setAuthor("The Author Name");
        bookRepository.save(book);

        Book foundBook = bookRepository.findById(book.getId()).orElse(null);
        assertEquals("The Book Title", foundBook.getTitle());
    }
}
