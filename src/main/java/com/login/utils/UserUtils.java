package com.login.utils;

import com.login.model.User;

import org.springframework.stereotype.Component;


@Component
public class UserUtils {

    public static User createUser(
            String firstName,
            String lastName,
            String username,
            String password,
            String emailAddress) {

        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setUsername(username);
        user.setPassword(password);
        user.setEmailAddress(emailAddress);

        return user;

    }

}
