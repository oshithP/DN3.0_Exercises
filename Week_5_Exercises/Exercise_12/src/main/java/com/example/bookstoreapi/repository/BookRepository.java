package com.example.bookstoreapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.bookstoreapi.entity.Book;

import java.util.Optional;

public interface BookRepository extends JpaRepository<Book, Long> {

}


