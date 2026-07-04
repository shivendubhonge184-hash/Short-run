<!DOCTYPE html>
<html>
<head>
<title>Student Registration</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',sans-serif;
}

body{
    min-height:100vh;
    background:linear-gradient(135deg,#0f172a,#1e293b);
    display:flex;
    justify-content:center;
    align-items:center;
    padding:30px;
}

.form-box{
    width:100%;
    max-width:1000px;
    background:#fff;
    border-radius:20px;
    box-shadow:0 25px 70px rgba(0,0,0,.35);
    padding:45px;
}

.header{
    text-align:center;
    margin-bottom:35px;
}

.header h1{
    color:#111827;
    font-size:32px;
    margin-bottom:10px;
}

.header p{
    color:#6b7280;
    font-size:15px;
}

.grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:20px;
}

input,select{
    width:100%;
    padding:14px 16px;
    border:1px solid #d1d5db;
    border-radius:12px;
    background:#f9fafb;
    font-size:15px;
    outline:none;
    transition:.3s;
}

input:focus,
select:focus{
    border-color:#2563eb;
    background:#fff;
    box-shadow:0 0 0 4px rgba(37,99,235,.15);
}

button{
    width:100%;
    margin-top:30px;
    padding:15px;
    border:none;
    border-radius:12px;
    background:#2563eb;
    color:white;
    font-size:17px;
    font-weight:600;
    cursor:pointer;
    transition:.3s;
}

button:hover{
    background:#1d4ed8;
    transform:translateY(-2px);
}

.login-link{
    text-align:center;
    margin-top:20px;
    color:#6b7280;
}

.login-link a{
    text-decoration:none;
    color:#2563eb;
    font-weight:600;
}

.login-link a:hover{
    text-decoration:underline;
}

@media(max-width:768px){

    .grid{
        grid-template-columns:1fr;
    }

    .form-box{
        padding:25px;
    }

}

</style>

</head>

<body>

<div class="form-box">

    <div class="header">
        <h1>Create Student Account</h1>
        <p>
            Register to access aptitude tests, track progress,
            and prepare effectively for campus placements.
        </p>
    </div>

    <form action="saveStudent.jsp" method="post">

        <div class="grid">

            <input type="text"
                   name="full_name"
                   placeholder="Full Name"
                   required>

            <input type="email"
                   name="email"
                   placeholder="Email Address"
                   required>

            <input type="password"
                   name="password"
                   placeholder="Password"
                   required>

            <input type="password"
                   name="confirmPassword"
                   placeholder="Confirm Password"
                   required>

            <input type="tel"
                   name="mobile"
                   placeholder="Mobile Number"
                   pattern="[0-9]{10}"
                   required>

            <select name="gender" required>
                <option value="">Select Gender</option>
                <option>Male</option>
                <option>Female</option>
                <option>Other</option>
            </select>

            <input type="date"
                   name="dob"
                   required>

            <input type="text"
                   name="college"
                   placeholder="College Name"
                   required>

            <select name="branch" required>
                <option value="">Select Branch</option>
                <option>CSE</option>
                <option>IT</option>
                <option>ECE</option>
                <option>EEE</option>
                <option>Mechanical</option>
                <option>Civil</option>
                <option>AIML</option>
                <option>Data Science</option>
            </select>

            <select name="study_year" required>
                <option value="">Select Year of Study</option>
                <option>1st Year</option>
                <option>2nd Year</option>
                <option>3rd Year</option>
                <option>4th Year</option>
            </select>

            <input type="number"
                   name="semester"
                   placeholder="Semester"
                   min="1"
                   max="8"
                   required>

            <input type="number"
                   step="0.01"
                   min="0"
                   max="10"
                   name="cgpa"
                   placeholder="CGPA"
                   required>

            <input type="text"
                   name="city"
                   placeholder="City"
                   required>

            <input type="text"
                   name="skills"
                   placeholder="Skills (Java, SQL, DSA)"
                   required>

            <input type="url"
                   name="linkedin"
                   placeholder="LinkedIn Profile URL">

            <input type="url"
                   name="github"
                   placeholder="GitHub Profile URL">

        </div>

        <button type="submit">
            Create Account
        </button>

    </form>

    <div class="login-link">
        Already have an account?
        <a href="studentLogin.jsp">Login Here</a>
    </div>

</div>

</body>
</html>