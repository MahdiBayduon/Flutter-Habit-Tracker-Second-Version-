# Backend API Submission

## Backend Services URL

**Current Status:** The backend is currently running locally at:
- Local Development: `http://localhost:8081/habit_tracker_api`
- Android Emulator: `http://10.0.2.2:8081/habit_tracker_api`

**⚠️ IMPORTANT:** To submit a published backend URL, you need to deploy the PHP backend to a web hosting service. See deployment instructions below.

---

## Backend API Code Structure

The complete backend code is located in the `backend/` folder with the following structure:

```
backend/
├── auth/
│   ├── login.php
│   ├── register.php
│   ├── forgot_password.php
│   └── logout.php
├── habits/
│   └── index.php
├── config/
│   ├── config.php
│   ├── database.php
│   └── jwt.php
├── database/
│   └── schema.sql
└── README.md
```

---

## API Endpoints

### Authentication Endpoints

1. **Register User**
   - `POST /auth/register.php`
   - Body: `{ "email": "user@example.com", "password": "password123", "display_name": "User Name" }`
   - Returns: `{ "success": true, "token": "...", "user": {...} }`

2. **Login**
   - `POST /auth/login.php`
   - Body: `{ "email": "user@example.com", "password": "password123" }`
   - Returns: `{ "success": true, "token": "...", "user": {...} }`

3. **Forgot Password**
   - `POST /auth/forgot_password.php`
   - Body: `{ "email": "user@example.com" }`
   - Returns: `{ "success": true, "message": "..." }`

4. **Logout**
   - `POST /auth/logout.php`
   - Headers: `Authorization: Bearer {token}`
   - Returns: `{ "success": true, "message": "Logged out successfully" }`

### Habits Endpoints

1. **Get All Habits**
   - `GET /habits/index.php?user_id={userId}`
   - Headers: `Authorization: Bearer {token}`
   - Returns: `{ "success": true, "data": [...] }`

2. **Get Single Habit**
   - `GET /habits/index.php?id={habitId}`
   - Headers: `Authorization: Bearer {token}`
   - Returns: `{ "success": true, "data": {...} }`

3. **Create Habit**
   - `POST /habits/index.php`
   - Headers: `Authorization: Bearer {token}`
   - Body: `{ "user_id": "...", "title": "...", "description": "...", "color": "#6366F1", "icon": "📝", ... }`
   - Returns: `{ "success": true, "data": {...} }`

4. **Update Habit**
   - `PUT /habits/index.php?id={habitId}`
   - Headers: `Authorization: Bearer {token}`
   - Body: `{ "title": "...", ... }`
   - Returns: `{ "success": true, "data": {...} }`

5. **Delete Habit**
   - `DELETE /habits/index.php?id={habitId}`
   - Headers: `Authorization: Bearer {token}`
   - Returns: `{ "success": true, "message": "..." }`

---

## Database Schema

The database schema is defined in `backend/database/schema.sql`. It creates:
- `users` table - for user accounts
- `habits` table - for habit data
- `habit_completions` table - for tracking completed dates

---

## Deployment Instructions

To publish your backend and get a public URL, you can use one of these services:

### Option 1: Free PHP Hosting (Recommended for Testing)

1. **000webhost** (https://www.000webhost.com)
   - Free PHP hosting with MySQL
   - Upload backend folder via File Manager or FTP
   - Import schema.sql via phpMyAdmin
   - Update database.php with provided credentials

2. **InfinityFree** (https://www.infinityfree.net)
   - Free hosting with PHP and MySQL
   - Upload files via File Manager
   - Database setup via Control Panel

3. **FreeHosting** (https://www.freehosting.com)
   - Free PHP hosting
   - FTP access included

### Option 2: Cloud Hosting (For Production)

1. **Heroku** (with ClearDB addon for MySQL)
2. **AWS EC2** (with RDS for MySQL)
3. **DigitalOcean** (with LAMP stack)

### After Deployment:

1. Upload the entire `backend/` folder to your hosting
2. Rename it to `habit_tracker_api` or keep structure as `backend/`
3. Import `schema.sql` to your database
4. Update `backend/config/database.php` with your hosting database credentials
5. Update `backend/config/config.php` JWT_SECRET
6. Update Flutter app's `lib/config/api_config.dart` with your published URL

---

## Configuration Files

**Important:** Before deploying, update these configuration values:

1. `backend/config/database.php`:
   ```php
   define('DB_HOST', 'your-database-host');
   define('DB_USER', 'your-database-user');
   define('DB_PASS', 'your-database-password');
   define('DB_NAME', 'habit_tracker');
   ```

2. `backend/config/config.php`:
   ```php
   define('JWT_SECRET', 'your-random-secret-key-here');
   ```

---

## Testing the API

After deployment, test your API endpoints using:
- Postman
- cURL
- Browser (for GET requests)

Example test:
```bash
curl -X POST https://your-domain.com/habit_tracker_api/auth/login.php \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

---

## Files to Submit

Submit the entire `backend/` folder containing all PHP files and the database schema.

