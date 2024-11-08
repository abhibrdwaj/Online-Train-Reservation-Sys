package com.login.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.login.model.Users;

public interface LoginRepository extends JpaRepository<Users, Long> {
    Optional<Users> findByUsername(String username);
}

