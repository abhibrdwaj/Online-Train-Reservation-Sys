package com.login.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


import com.login.model.User;
import com.login.repository.UserRepository;

@Service
public class LoginService {
	
	@Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
	
	public User authenticateUser(String username, String password) {
		Optional<User> userOpt = userRepository.findByUsername(username);

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            boolean isPwdMatching = isPwdMatching(password, user.getPassword());
            if(isPwdMatching) {
                return user;
            }
        }

        return null;
    }

    private boolean isPwdMatching(String plainPassword, String hashedPassword) {
        return passwordEncoder.matches(plainPassword, hashedPassword);
    }

    public String hashPassword(String plainPassword) {

        return passwordEncoder.encode(plainPassword);
    }

}

