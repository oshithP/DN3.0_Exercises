package com.example.bookstoreapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.bookstoreapi.entity.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
}
