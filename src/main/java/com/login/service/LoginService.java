package com.login.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.login.model.User;
import com.login.repository.LoginRepository;

@Service
public class LoginService {
	
	@Autowired
    private LoginRepository loginRepository;
	
	public User authenticateUser(String username, String password) {
		Optional<User> userOpt = loginRepository.findByUsername(username);

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if(user.getPassword().equals(password)) {
                return user;
            }
        }

        return null;
    }

}

