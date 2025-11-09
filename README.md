# BookSwap App

BookSwap is a mobile marketplace where students can list textbooks they want to exchange, browse available listings, and initiate swap offers in real-time.  
It’s built with **Flutter** and powered by **Firebase**, demonstrating full-stack mobile development — from authentication to CRUD operations and real-time state management.

---

## Features

### Authentication
- User registration and login using Firebase Authentication.
- Email verification before login.
- Profile creation and management.

### Book Listings (CRUD)
- **Create:** Post a new book with title, author, condition, and cover image.
- **Read:** Browse all available book listings from all users.
- **Update:** Edit your own listings.
- **Delete:** Remove listings when books are no longer available.

### Swap Functionality
- Initiate a swap offer by tapping a “Swap” button.
- Swap requests appear in “My Offers.”
- Swap states update in real-time (Pending → Accepted → Rejected).
- Both sender and recipient see live updates via Firebase sync.

### Chat (Bonus)
- After a swap request, users can chat with each other.
- Messages are stored and updated live in Firebase Firestore.

### Settings
- Toggle notification preferences (simulated locally).
- View profile information.
- Logout functionality.

---

## Tech Stack
| Category | Technology |
|-----------|-------------|
| Frontend | Flutter |
| Backend | Firebase (Auth, Firestore, Storage) |
| State Management | Riverpod |
| IDE | Visual Studio Code |
| Version Control | Git + GitHub |
| Platform | Android / iOS Emulator |

---

## Architecture & State Management

The app follows a **clean architecture**:
- **Presentation layer:** UI widgets and screens  
- **Domain layer:** Business logic, providers, and models  
- **Data layer:** Firestore services and repositories  

State is handled using **Riverpod** — ensuring reactive UI updates whenever Firestore data changes. No global `setState` is used for shared states.

---

## Database Design

### Firestore Collections:
- `users` → `{ uid, name, email, verified, preferences }`
- `books` → `{ title, author, condition, imageURL, ownerId, createdAt }`
- `swaps` → `{ senderId, receiverId, bookId, status (pending/accepted/rejected) }`
- `chats` → `{ swapId, messages: [ { senderId, text, timestamp } ] }`

### Swap State Flow
`Pending → Accepted → Rejected`  
Each transition updates in Firestore and triggers UI changes through Riverpod listeners.

---

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/bookswap.git
   cd bookswap
Install dependencies

bash
Copy code
flutter pub get
Firebase Configuration

Add google-services.json (Android) and GoogleService-Info.plist (iOS).

Enable Firebase Authentication (Email/Password).

Create Firestore collections according to the schema above.

Run the app

bash
Copy code
flutter run
  Firebase Integration Summary
Feature	Firebase Service	Description
Login/Signup	Authentication	Secure user management
Listings	Firestore	Real-time data sync for CRUD
Swaps	Firestore	Tracks offer state and updates
Images	Firebase Storage	Saves book cover images
Chats	Firestore	Real-time chat messages

  Example Flows Demonstrated in Demo Video
User registration, login & email verification

Adding, editing & deleting book listings

Viewing shared listings

Initiating & updating swap offers

Real-time Firestore reflection (console shown)

(Bonus) Two-user chat after swap initiation

Navigation and settings toggles

**Developer
**Name: Hephzibah Ofomi
Institution: African Leadership University
Course: Skills Immersion 2025J
Project: Individual Assignment 2 — BookSwap
Duration: October–November 2025

**License**
This project was developed for academic purposes only under the African Leadership University Skills Immersion program.

