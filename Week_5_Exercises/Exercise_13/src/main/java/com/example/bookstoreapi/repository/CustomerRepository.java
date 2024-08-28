package com.example.bookstoreapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.bookstoreapi.entity.Customer;

public interface CustomerRepository extends JpaRepository<Customer, Long> {
}
