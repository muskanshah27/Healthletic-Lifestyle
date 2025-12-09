# Online Student Skill Testing & Result Portal

## 1. Project Brief
This project is a web-based platform designed for conducting online MCQ (Multiple Choice Question) tests for students, generating instant results, and allowing administrators to manage tests, questions, and student data.  
It is built using **PHP, MySQL, HTML, CSS, and JavaScript** and can be easily deployed on any Apache server.

---

## 2. Getting Started / Setup Instructions

### 2.1 Prerequisites
- PHP 7+ or PHP 8+
- MySQL / MariaDB
- Apache server (XAMPP, WAMP, LAMP)
- Git (optional)
- phpMyAdmin

---

### 2.2 Clone the Repository
```bash
git clone <your-repository-url>
cd online-student-skill-test-portal
```

---

### 2.3 Set Up Local Development Environment

#### Step 1 — Start Apache & MySQL
Mac/Linux:
```bash
sudo /opt/lampp/lampp start
```

Windows (XAMPP Control Panel):
- Start **Apache**
- Start **MySQL**

---

#### Step 2 — Create and Import Database
1. Open **phpMyAdmin**  
2. Create a new database  
3. Import:
```
database.sql
```

---

#### Step 3 — Configure Database Connection  
Edit:
```
/config/db.php
```

Update:
```php
$host = "localhost";
$user = "root";
$pass = "";
$db   = "student_portal";
```

---

#### Step 4 — Run the Project  
Place the project folder inside:
```
XAMPP  → htdocs/
WAMP   → www/
```

Open in browser:
```
http://localhost/online-student-skill-test-portal/
```

---

### 2.4 Running Local Tests  
If automated tests exist:
```bash
php vendor/bin/phpunit
```

If manual testing:
- Log in as a **student** → attempt test → verify results  
- Log in as an **admin** → add questions → check dashboard  

---

### 2.5 Environment Variables (Optional)
Create `.env` file:
```
DB_HOST=localhost
DB_USER=root
DB_PASS=
DB_NAME=student_portal
ENV=local
```

---

## 3. Usage Instructions

### 3.1 Trigger CI/CD Pipeline  
(GitHub Actions Example)

Push to **main** branch to deploy:
```bash
git add .
git commit -m "deployment update"
git push origin main
```

Push to **dev** branch to test:
```bash
git push origin dev
```

---

### 3.2 Monitor Pipeline Execution  
Go to:
```
GitHub → Repository → Actions
```

You can check:
- Workflow status  
- Build logs  
- Deployment logs  

---

### 3.3 Access Deployed Artifacts / Logs
- Logs → GitHub Actions → Workflow log  
- Artifacts → Download from workflow  
- Deployment URL → Shown in GitHub Deployments section  

---

## 4. Contribution Guidelines (Optional)

### 4.1 How to Contribute
1. Fork this repository  
2. Create a feature branch  
   ```bash
   git checkout -b feature/new-feature
   ```
3. Make changes and commit  
4. Push your branch  
5. Create a Pull Request  

---

### 4.2 Branching Strategy
- `main` → Production branch  
- `dev` → Development branch  
- `feature/*` → New features  
- `fix/*` → Bug fixes  

---

### 4.3 Code Style Guidelines
- Follow PSR-12 PHP coding standards  
- Comment complex logic  
- Use meaningful function and variable names  
- Write clean, formatted HTML/CSS  

---

### 4.4 Reporting Issues
```
GitHub → Issues → New Issue
```
Include:
- Summary  
- Steps to reproduce  
- Screenshots (if applicable)

---

## 5. Troubleshooting & Support

### Common Issues & Fixes

#### ❌ Database connection error
✔ Check `/config/db.php`  
✔ Start MySQL server  
✔ Correct database name  

---

#### ❌ 404 Not Found
✔ Ensure project is inside `htdocs/` or `www/` directory  

---

#### ❌ Blank or White Page
Enable PHP error reporting:
```php
ini_set('display_errors', 1);
error_reporting(E_ALL);
```

---

### Need Help?
- Open a GitHub Issue  
- Check Apache logs:
```
/xampp/apache/logs/error.log
```
- Contact the project maintainer  

---

## ✔️ End of README
