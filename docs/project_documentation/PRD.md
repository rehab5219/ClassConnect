# ClassConnect

## Product Requirements Document (PRD)

**Version:** 1.0
**Product:** ClassConnect
**Platform:** Mobile Application
**Technology:** Flutter

---

# 1. Product Overview

ClassConnect is a mobile educational application that connects students and teachers.

The application provides role-based experiences. After onboarding, users select whether they are a Student or Teacher. The selected role determines the dashboard and features available to them.

---

# 2. Product Vision

To provide a simple and organized digital environment where students and teachers can manage their educational activities and communicate effectively.

---

# 3. Product Goals

### Primary Goals

- Create an easy onboarding experience.
- Provide secure authentication.
- Support student and teacher roles.
- Provide role-specific dashboards.
- Support class management.
- Support assignment management.
- Support educational content.
- Provide notifications.
- Provide profile management.

---

# 4. User Personas

## Persona 1 — Student

**Goal:** Communication with teachers and school easily.

### Needs

- View Feedbacks.
- View Today's lessons.
- View assignments.

---

## Persona 2 — Teacher

**Goal:** Manage classes and provide educational content.

### Needs

- Teachers select Students.
- Create Today's Lessons.
- Create assignments.
- Communicate with students.

---

# 5. Application Navigation

## Initial Flow

```text
Splash Screen
      ↓
Onboarding
      ↓
Welcome Screen
      ↓
Role Selection
   ↙          ↘
Student      Teacher
   ↓            ↓
Authentication
   ↓            ↓
Teacher / Student Layout
```

---

# 6. Feature Requirements

## 6.1 Splash Screen

### Description

The splash screen is the first screen displayed when the application starts.

### Requirements

- Display ClassConnect logo.
- Display application branding.
- Check whether the user has an existing session.
- Navigate to the appropriate screen.

### Navigation

New user:

```text
Splash → Onboarding
```

Existing user:

```text
Splash → Teacher / Student Layout
```

---

# 7. Onboarding

### Description

The onboarding introduces users to ClassConnect.

### Requirements

The onboarding should contain multiple informational screens explaining:

- What ClassConnect is.
- How students use the application.
- How teachers use the application.

### Actions

- Next
- Skip
- Get Started

---

# 8. Welcome Screen

### Description

The Welcome screen introduces the user to the application and allows them to select their role.

### UI

```text
Welcome to ClassConnect

How do you want to use ClassConnect?

[ Student ]

[ Teacher ]
```

### Functional Requirement

Selecting Student:

```text
Student → Student Authentication
```

Selecting Teacher:

```text
Teacher → Teacher Authentication
```

---

# 9. Authentication

## 9.1 Student Registration

### Required Fields

- Full Name
- Email
- Password
- Confirm Password
- Optional profile information

### Validation

- Name cannot be empty.
- Email must be valid.
- Password must meet security requirements.
- Password confirmation must match.

---

## 9.2 Teacher Registration

### Required Fields

- Full Name
- Email
- Password
- Confirm Password
- Optional professional information

### Optional Information

- Subject
- School
- Years of experience

---

## 9.3 Login

Users should be able to log in using their credentials.

### Requirements

- Email/username
- Password
- Login button
- Forgot Password
- Registration navigation

### States

```text
Idle
 ↓
Loading
 ↓
Success → Dashboard

or

Error → Display error message
```

---

# 10. Student Layout

The Student is the main screen for students.

### Suggested Sections

```text

[ Student ]

[ Today's Lessons ]

[ Assignments ]

[ Advises ]

[ Profile ]
```

### Bottom Navigation

```text
Home | Today's Lessons | Assignments | Advises | Profile
```

---

# 11. Teacher Layout

The Teacher's students is the main screen for teachers.

### Suggested Sections

```text

[ Students ]

[Today's Lessons]

[ Assignments ]

[ Search ]

[ Profile ]
```

### Bottom Navigation

```text
Home | Today's Lessons | Assignments | Search | Profile
```

---

## Teacher

Teachers can:

- Select Students.
- Create Feedback.
- Create Today's lessons.
- Create Assignments.
- Search about any student.

## Student

Students can:

- View feedback.
- View Today's Lessons.
- View Assignments.

---

# 12. Functional Requirements

| ID    | Requirement                    | Priority |
| ----- | ------------------------------ | -------- |
| FR-01 | User can register              | High     |
| FR-02 | User can login                 | High     |
| FR-03 | User can select role           | High     |
| FR-04 | Student can access dashboard   | High     |
| FR-05 | Teacher can access dashboard   | High     |
| FR-06 | Teacher can create classes     | High     |
| FR-07 | Student can view classes       | High     |
| FR-08 | Teacher can create assignments | High     |
| FR-09 | Student can view assignments   | High     |
| FR-10 | Student can submit assignments | High     |
| FR-11 | Teacher can view submissions   | High     |
| FR-12 | Teacher can upload materials   | Medium   |
| FR-13 | Student can access materials   | Medium   |
| FR-14 | Users receive notifications    | Medium   |
| FR-15 | Users can edit profiles        | Medium   |

---

# 13. Non-Functional Requirements

## Performance

- Screens should load quickly.
- API requests should display loading indicators.
- Images should be optimized.
- Large files should not block the UI.

## Security

- Passwords must not be stored as plain text.
- Authentication tokens should be securely stored.
- APIs should use HTTPS.
- Users must only access authorized resources.

## Usability

- Navigation should be simple.
- Forms should provide clear validation messages.
- Buttons should have clear labels.
- The application should support responsive layouts.

## Reliability

- API errors should be handled gracefully.
- The application should provide retry mechanisms where appropriate.
- Empty states should be handled.

---

# 14. Error Handling

The application should handle:

### Network Error

```text
Unable to connect to the server.
Please check your internet connection and try again.
```

### Authentication Error

```text
Invalid email or password.
```

### Validation Error

```text
Please complete all required fields.
```

### Server Error

```text
Something went wrong.
Please try again later.
```

### Empty State

```text
No assignments available.
```

---

# 15. Loading States

Every API-based screen should provide a loading state.

Example:

```text
Loading
   ↓
Success → Display Data

Loading
   ↓
Error → Display Error
```

Skeleton loaders can be used for dashboard and list screens.

---

# 16. Technical Architecture

A feature-based architecture is recommended.

```text
lib/
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── networking/
│   ├── routing/
│   ├── theme/
│   └── widgets/
│
├── features/
│   │
│   ├── splash/
│   │
│   ├── onboarding/
│   │
│   ├── authentication/
│   │   ├── data/
│   │   ├── presentation/
│   │   └── models/
│   │
│   ├── student/
│   │   ├── home/
│   │   ├── today's lessons/
│   │   ├── assignments/
│   │   ├── advises/
│   │   └── profile/
│   │
│   ├── teacher/
│   │   ├── students/
│   │   ├── today's lessons/
│   │   ├── assignments/
│   │   ├── search/
│   │   └── profile/
└── main.dart
```

---

# 17. State Management

Flutter Bloc/Cubit can be used for application state management.

Example:

```text
UI
 ↓
Cubit / Bloc
 ↓
Firebase
```

Example authentication flow:

```text
LoginScreen
     ↓
AuthCubit
     ↓
Firebase Authentication
```

---

# 18. Firebase Requirements

ClassConnect will use Firebase as its backend infrastructure to manage authentication, user data, classes, assignments, educational materials, and notifications.

## 18.1 Firebase Authentication

Firebase Authentication will handle user registration, login, and logout.

**Requirements:**

- Register users using email and password.
- Authenticate users securely.
- Support Student and Teacher roles.
- Maintain user authentication sessions.
- Sign out users securely.

**Firebase Service:** Firebase Authentication

## 18.2 Cloud Firestore — Users

Cloud Firestore will store user profiles and role-specific information.

**Collection:** `users`

**Document ID:** Firebase Authentication UID

**User Fields:**

- `uid`: String
- `fullName`: String
- `email`: String
- `role`: String (`student` or `teacher`)
- `profileImage`: String
- `createdAt`: Timestamp
- `updatedAt`: Timestamp

**Requirements:**

- Create a user profile after registration.
- Retrieve user profile information.
- Update profile information.
- Retrieve users according to authorized access and role.

## 18.3 Cloud Firestore — Feedbacks

**Collection:** `feedbacks`

**Feedbacks Fields:**

- `message`: String
- `stage`: String
- `feedbackType`: String
- `subjectName`: String
- `teacherId`: String
- `day`: String
- `Date`: Timestamp

**Requirements:**

- Teachers can create feedbacks for each students, today's lessons and assignments.
- Students can view today's lessons.
- Students can view assignments.

## 18.4 Cloud Firestore — selected_students

**Collection:** `selected_students`

**selected_students Fields:**

- `email`: String
- `firstName`: String
- `image`: String
- `phone1`: String
- `secondName`: String
- `teacherIds`: String
- `uid`: String

**Requirements:**

- Teachers can select student.

## 18.5 Cloud Firestore — students

**Collection:** `students`

**students Fields:**

- `email`: String
- `firstName`: String
- `image`: String
- `phone1`: String
- `secondName`: String
- `teacherIds`: String
- `uid`: String
- `userType`: String

**Requirements:**

- Students can view image and name.

## 18.6 Cloud Firestore — teachers

**Collection:** `teachers`

**teachers Fields:**

- `email`: String
- `bio`: String
- `firstName`: String
- `image`: String
- `phone1`: String
- `secondName`: String
- `specialization`: String
- `teacherIds`: String
- `uid`: String
- `userType`: String

**Requirements:**

- Teachers can view students that selected.

## 18.7 Firebase Security Rules

Firebase Security Rules will protect user data and enforce role-based access control.

**Requirements:**

- Only authenticated users can access protected data.
- Students can access their own profiles and authorized class information.
- Teachers can manage only their own classes and related assignments.
- Students can submit and access only their own submissions.
- Users cannot modify their role or access privileges without authorized backend logic.
- Cloud Storage rules must restrict file access to authorized users.

## 18.8 Firebase Services Summary

| Firebase Service         | Purpose                                                 |
| ------------------------ | ------------------------------------------------------- |
| Firebase Authentication  | Registration, login, logout, password reset             |
| Cloud Firestore          | Users, classes, assignments, submissions                |
| Firebase Storage         | Profile images, educational materials, assignment files |
| Firebase Cloud Messaging | Push notifications                                      |
| Cloud Functions          | Trusted backend operations and automated notifications  |
| Firebase Security Rules  | Data access control and authorization                   |

---

# 19. MVVM

The first version should focus on the core experience.

### MVVM Features

```text
✓ Splash
✓ Onboarding
✓ Welcome
✓ Role Selection
✓ Student Registration/Login
✓ Teacher Registration/Login
✓ Home Student
✓ Home Teacher
✓ Today's Lessons
✓ Assignments
✓ Search
✓ Advises
✓ Profile
```

Advanced features can be introduced after the MVVM.

---

# 20. Future Features

Possible future releases may include:

- Live classes
- Video calls
- Online exams
- AI learning assistant
- Parent accounts
- Attendance
- Payments
- Certificates
- Gamification
- Student analytics
- Teacher analytics
- School administration dashboard

---

# 21. Acceptance Criteria

The product can be considered ready for the initial release when:

- A new user can complete onboarding.
- A user can select Student or Teacher.
- A user can register successfully.
- A registered user can log in.
- Teachers can select students.
- Teachers can feedbacks, todays lessons and assignments.
- Teachers can search about any students.
- Students can view feedbacks, todays lessons and assignments .
- Unauthorized users cannot access restricted features.
