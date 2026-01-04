# Backend API Code - Submission Guide

## What to Submit to Your Instructor

### 1. Backend API Code

**Submit the entire `backend/` folder** which contains all the PHP backend code.

The `backend/` folder includes:

#### Authentication API Endpoints:
- `backend/auth/login.php` - Handles user login
- `backend/auth/register.php` - Handles user registration  
- `backend/auth/forgot_password.php` - Handles password reset requests
- `backend/auth/logout.php` - Handles user logout

#### Habits Management API Endpoints:
- `backend/habits/index.php` - Handles all habit CRUD operations (Create, Read, Update, Delete)

#### Configuration Files:
- `backend/config/config.php` - Main configuration (CORS headers, JWT settings)
- `backend/config/database.php` - Database connection settings
- `backend/config/jwt.php` - JWT token generation and verification functions

#### Database:
- `backend/database/schema.sql` - Complete database schema (users, habits, habit_completions tables)

#### Additional Files:
- `backend/.htaccess` - Apache server configuration for CORS
- `backend/README.md` - Backend documentation

---

### 2. Backend Services URL

**Current Status:** 
- Local Development URL: `http://localhost:8081/habit_tracker_api`

**To Get a Published URL:**
The backend needs to be deployed to a web hosting service. Common free options:
- 000webhost.com
- InfinityFree.net
- FreeHosting.com

After deployment, you'll get a URL like:
- `https://your-site.000webhostapp.com/habit_tracker_api`

---

## How to Package for Submission

### Option 1: Zip the Backend Folder
1. Right-click on the `backend` folder
2. Select "Send to" → "Compressed (zipped) folder"
3. Name it: `habit_tracker_backend_api.zip`
4. Submit this zip file

### Option 2: Submit Folder Structure
If your instructor accepts folders, submit the entire `backend/` folder as-is.

---

## Backend API Summary

**Total Files:** 11 PHP files + 1 SQL file + 2 config/documentation files

**API Endpoints:**

**Authentication:**
- POST `/auth/register.php` - Register new user
- POST `/auth/login.php` - User login
- POST `/auth/forgot_password.php` - Password reset
- POST `/auth/logout.php` - User logout

**Habits:**
- GET `/habits/index.php?user_id={id}` - Get all user habits
- GET `/habits/index.php?id={id}` - Get single habit
- POST `/habits/index.php` - Create new habit
- PUT `/habits/index.php?id={id}` - Update habit
- DELETE `/habits/index.php?id={id}` - Delete habit

**Authentication:** Bearer token (JWT) required for habits endpoints

**Response Format:** All responses are JSON with `success`, `data`, and `message` fields

---

## Quick Submission Checklist

- [ ] `backend/` folder contains all PHP files
- [ ] `backend/database/schema.sql` is included
- [ ] `backend/README.md` documentation is included
- [ ] If deployed: Published backend URL
- [ ] If local: Note that it's ready for deployment (see README.md)

---

## File Locations

All backend code is in: `C:\Users\user\Desktop\Mobile Project2\backend\`

