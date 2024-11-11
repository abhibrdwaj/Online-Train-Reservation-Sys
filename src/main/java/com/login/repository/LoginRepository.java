package com.login.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.login.model.User;

public interface LoginRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
}

