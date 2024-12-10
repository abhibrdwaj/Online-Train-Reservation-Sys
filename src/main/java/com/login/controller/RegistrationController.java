package com.login.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;

import com.login.model.User;
import com.login.service.UserService;
import com.login.service.LoginService;
import com.login.utils.UserUtils;

import com.login.constants.endpoints.RegistrationEndpoints;

@Controller
@RequestMapping(RegistrationEndpoints.REGISTRATION_BASE_URI)
public class RegistrationController {

    @Autowired
    UserService userService;

    @Autowired
    LoginService loginService;

    @GetMapping(RegistrationEndpoints.SHOW_REGISTRATION_FORM)
    public String showRegistarionForm() {

        return "user/register_user";
    }


    /**
     * Registers a new customer based on the provided registration data.
     *
     * @param firstName   The first name of the user.
     * @param lastName    The last name of the user.
     * @param username    The username of the user.
     * @param password    The password of the user.
     * @param address     The address of the user.
     * @param phoneNumber The phone number of the user.
     * @param image       The profile image of the user (optional).
     * @param model       The model object to pass data to the view.
     * @return The view name for the user registration success page.
     */

    @PostMapping(RegistrationEndpoints.REGISTER_NEW_CUSTOMER)
    public String registerUser(
            @ModelAttribute("user") User userRegistered,
            Model model) {

        // Create a User object with the registration data
        User user = UserUtils.createUser(
                userRegistered.getFirstName(),
                userRegistered.getLastName(),
                userRegistered.getUsername(),
                loginService.hashPassword(userRegistered.getPassword()),
                userRegistered.getEmailAddress());

        // Register the new customer
        User userRegistrationResult = userService.registerNewCustomer(user);

        // Pass the registration result to the view
        model.addAttribute("userRegResult", userRegistrationResult);

        return "user/user_registration_success";
    }
}
