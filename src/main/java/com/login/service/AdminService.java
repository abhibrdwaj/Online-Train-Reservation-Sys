package com.login.service;

import com.login.model.User;
import com.login.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import static com.login.constants.Common.*;
import static com.login.constants.Roles.*;

@Service
public class AdminService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private LoginService loginService;

    public List<Map<String, Object>> getAllCustomerReps() {
        return userRepository.findAllByRole("CUSTOMER_REP");
    }

    public boolean addCustomerRep(String lastName, String firstName, String username, String email, String ssn) {
        if (userRepository.existsByUsername(username)) {
            return false; // Username already exists
        }
        User custRep = new User(lastName, firstName, username, loginService.hashPassword(DEFAULT_PASSWORD), email, ssn, CUSTOMER_REP);

        userRepository.save(custRep);
        return true;
    }

    public void updateRep(String repId, String firstName, String lastName, String email, String socialSecurityNumber) {
        // Find the representative by ID
        Optional<User> optionalRep = userRepository.findByUsername(repId);
        if (optionalRep.isPresent()) {
            User rep = optionalRep.get();
            // Update the details
            rep.setFirstName(firstName);
            rep.setLastName(lastName);
            rep.setEmailAddress(email);
            rep.setSocialSecurityNumber(socialSecurityNumber);

            // Save the updated representative
            userRepository.save(rep);
        } else {
            throw new RuntimeException("Representative not found with ID: " + repId);
        }
    }

    @Transactional
    public void deleteCustomerRep(String username) {
        userRepository.deleteByUsername(username);
    }
}
