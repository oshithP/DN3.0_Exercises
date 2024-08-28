package com.example.bookstoreapi.controller;

import com.example.bookstoreapi.entity.Book;
import com.example.bookstoreapi.resource.BookResource;
import com.example.bookstoreapi.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/books")
public class BookController {

    @Autowired
    private BookService bookService;

    @PostMapping
    public ResponseEntity<BookResource> createBook(@Valid @RequestBody Book book) {
        BookResource bookResource = bookService.createBook(book);
        return new ResponseEntity<>(bookResource, HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<BookResource> getBook(@PathVariable Long id) {
        Optional<BookResource> bookResource = bookService.getBook(id);
        return bookResource.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<BookResource> updateBook(@PathVariable Long id, @Valid @RequestBody Book book) {
        BookResource bookResource = bookService.updateBook(id, book);
        return new ResponseEntity<>(bookResource, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBook(@PathVariable Long id) {
        bookService.deleteBook(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping
    public ResponseEntity<List<BookResource>> getAllBooks() {
        List<BookResource> books = bookService.getAllBooks();
        return ResponseEntity.ok(books);
    }
}
