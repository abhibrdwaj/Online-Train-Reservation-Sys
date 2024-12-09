package com.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.login.model.User;
import com.login.repository.UserRepository;
import com.login.constants.Roles;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User registerNewCustomer(User user) {
        user.setRole(Roles.CUSTOMER);
        User result = userRepository.save(user);
        return result;
    }
}
