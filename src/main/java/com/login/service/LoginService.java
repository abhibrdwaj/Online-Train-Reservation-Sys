package com.login.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.login.model.Users;
import com.login.repository.LoginRepository;

@Service
public class LoginService {
	
	@Autowired
    private LoginRepository loginRepository;
	
	public boolean validateUser(String username, String password) {
		Optional<Users> userOpt = loginRepository.findByUsername(username);

        if (userOpt.isPresent()) {
            Users user = userOpt.get();
            return user.getPassword().equals(password);
        }

        return false;
    }

}

