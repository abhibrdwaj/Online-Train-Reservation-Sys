package com.login.model;


import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Column;

@Entity
@Table(name = "users")  // Specifies the table name in the database
public class User {

	@Id
	@Column(name = "username", length = 50, nullable = false)
	private String username;  // Primary key - mapped to 'username' column

	@Column(name = "first_name", length = 50, nullable = false)
	private String firstName;

	@Column(name = "last_name", length = 50, nullable = false)
	private String lastName;

	@Column(name = "email_address", length = 100, nullable = false, unique = true)
	private String emailAddress;

	@Column(name = "password", length = 255, nullable = false)
	private String password;  // Hashed password

	@Column(name = "social_security_number", length = 11, unique = true)
	private String socialSecurityNumber;  // Nullable for customers

	// Getters and Setters
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
    
}
