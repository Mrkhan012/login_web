# dummy

A new Flutter project.

## Getting Started
 Firebase Integration
This project utilizes Firebase Authentication and Firebase Realtime Database to manage user accounts and store user information securely.

⚙️ Features Implemented
User Authentication:

Sign up and login using email and password.
Authentication state is managed with GetX for seamless navigation between screens.
User Data Storage:

User information such as email, date of birth, and registration time is stored in Firebase Realtime Database under the user’s unique ID.
Ensures that all user-related data is securely saved and easily retrievable.
Automatic Screen Navigation:

Based on the authentication state, users are automatically redirected to either the login screen or home screen.
This is managed using GetX's ever listener to track authentication status.
Registration Time Tracking:

Captures the exact time when a user registers and saves it in the database as registrationTime in ISO 8601 format.
Helps in analyzing user sign-up patterns and managing user data effectively.