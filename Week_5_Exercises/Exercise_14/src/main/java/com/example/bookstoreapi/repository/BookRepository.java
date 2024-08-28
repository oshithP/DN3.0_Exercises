package com.example.bookstoreapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
import org.springframework.stereotype.Repository;

import com.example.bookstoreapi.entity.Book;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {

}








