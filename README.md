# Placement Preparation Portal
## 📸 Project Screenshots
### Student Dashboard
<img width="1892" height="977" alt="Screenshot 2026-07-06 191825" src="https://github.com/user-attachments/assets/f34d3b75-fb46-4970-8bf0-2be569bf4e54" />
### Coding Module
<img width="1919" height="1021" alt="Screenshot 2026-07-04 194008" src="https://github.com/user-attachments/assets/ae2a5b78-d549-45ad-844e-4e4b7fac4700" />



## Overview

The Placement Preparation Portal is a web-based platform designed to help students prepare effectively for campus placements. The system provides aptitude practice, interview experience sharing, progress tracking, and placement-related resources through a centralized platform.

The project aims to improve placement readiness by helping students identify their strengths and weaknesses, track their preparation progress, and learn from the experiences of peers.

---

## Problem Statement

Students preparing for placements often rely on multiple websites and resources for aptitude preparation, interview experiences, and study materials. This fragmented approach makes preparation difficult to organize and track. The Placement Preparation Portal addresses this problem by providing a single platform for structured placement preparation.

---

## Objectives

* Provide a centralized placement preparation platform.
* Enable aptitude practice and performance assessment.
* Facilitate sharing of interview experiences.
* Track student progress and readiness.
* Improve placement preparation through structured learning.

---
## Functional Modules

### Student Module

- Registration
- Login
- Dashboard
- Aptitude Practice
- Coding Practice
- Study Materials
- Community Discussion
- Profile Management

### Admin Module

- Admin Login
- Manage Students
- Manage Aptitude Questions
- Manage Coding Questions
- Upload Study Materials
- Manage Discussions
- Dashboard

## Features

### Student Features

* User Registration and Login
* Profile Management
* Aptitude Practice Tests
* Performance Tracking
* Interview Experience Sharing
* Community Discussions

### Admin Features

* User Management
* Question Management
* Content Moderation
* Performance Monitoring

---
## Key Features

✔ Secure Login Authentication

✔ Session Management

✔ Responsive User Interface

✔ Company-wise Aptitude Questions

✔ Coding Practice

✔ Study Material Repository

✔ Community Discussion Forum

✔ Admin Dashboard

✔ CRUD Operations

✔ MySQL Database Integration

✔ GitHub Version Control

✔ Modular Architecture

## Technology Stack

### Frontend

* HTML
* CSS
* JavaScript

### Backend


- Java
- JSP (JavaServer Pages)
- Java Servlets

### Database

* MySQL

### Tools

* Git
* GitHub
* Postman
* MySQL Workbench

---

## System Architecture


                Placement Preparation Portal
                          │
        ┌─────────────────┴─────────────────┐
        │                                   │
   Student Portal                     Admin Portal
        │                                   │
        └─────────────────┬─────────────────┘
                          │
                JSP Pages + Java Servlets
                          │
                    Business Logic Layer
                          │
                         JDBC
                          │
                      MySQL Database

## Database Schema

The database consists of multiple relational tables connected through primary and foreign keys.

Major Tables:

- Users
- Admin
- Categories
- Questions
- Coding Questions
- Companies
- Study Materials
- Discussion Posts
- Comments
- Quiz Attempts

The schema follows normalization principles to reduce redundancy and maintain data integrity.

## 🔄 Project Workflow

1. Student/Admin Login
2. Authentication using Java Servlets
3. Dashboard Access
4. Aptitude Practice
5. Coding Practice
6. Study Material Access
7. Community Discussions
8. Performance Tracking
9. Logout

## Installation

1. Clone the repository

git clone https://github.com/yourusername/Placement-Portal.git

2. Import the project into Eclipse.

3. Install Apache Tomcat 11.

4. Install MySQL Server.

5. Import aptitude.sql into MySQL.

6. Update database credentials inside the Java source files.

7. Run the project on Apache Tomcat.

8. Open:

http://localhost:8080/Placement/

## Project Structure

Placement Portal
│
├── src/
│   ├── servlet/
│   ├── dao/
│   ├── model/
│
├── WebContent/
│   ├── css/
│   ├── js/
│   ├── images/
│   ├── uploads/
│   ├── student/
│   ├── admin/
│
├── build/
│
└── database/
    └── aptitude.sql

---

## Database Design

The project uses MySQL as the backend database.

Main Tables:

- users
- admin
- companies
- categories
- questions
- coding_questions
- study_materials
- discussion_posts
- comments
- quiz_attempts

The database is normalized to reduce redundancy and maintain data integrity.

## Software Requirements

- Java JDK 21
- Eclipse IDE
- Apache Tomcat 11
- MySQL 8.x
- MySQL Workbench
- Git
- GitHub

---

## Hardware Requirements

### Minimum

- Intel Core i3
- 4 GB RAM
- 2 GB Storage

### Recommended

- Intel Core i5/i7
- 8 GB RAM
- SSD Storage
  
## Future Scope

- AI-based Placement Recommendation
- Online Code Compiler
- Resume Builder
- Placement Readiness Score
- Personalized Study Plans
- Company-wise Roadmaps
- Resume Evaluation
- Mock Interview System
- Company Recruitment Dashboard
- Mobile Application
- Email Notifications
- Performance Analytics
- Cloud Deployment
- AI Chatbot
---

## Author

Developed by

Shivendu Bhonge

B.Tech Computer Science & Engineering (Cyber Security & Forensics)

MIT Art, Design and Technology University, Pune

## Support

For suggestions or queries, feel free to create an issue or contact the project maintainer through GitHub.

## License

This project is developed as part of an academic internship/project and is intended for educational purposes.
