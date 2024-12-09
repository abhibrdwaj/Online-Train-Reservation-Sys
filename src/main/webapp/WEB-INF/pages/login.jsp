<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Railway Booking System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/login.css">
</head>
<body>
<div class="header">
    <img src="../images/trainline-logo.png" alt="Trainline Logo" class="logo">
</div>
<div class="container">
    <div class="login-container">
        <h3 class="text-center">Sign in</h3>
        <form action="login" method="post">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <div class="form-group">
                <label for="name">Username</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password" required>
                    <div class="input-group-append">
                        <button type="button" class="btn btn-outline-secondary" onclick="togglePasswordVisibility()">
                            <i id="toggleIcon" class="fa fa-eye"></i>
                        </button>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Sign in</button>

            <div class="social-login">
                <p>Or sign in with</p>
                <button class="btn btn-light"><img src="${pageContext.request.contextPath}/static/image/apple-icon.png" alt="Apple"></button>
                <button class="btn btn-light"><img src="${pageContext.request.contextPath}/static/image/facebook-icon.png" alt="Facebook"></button>
                <button class="btn btn-light"><img src="${pageContext.request.contextPath}/static/image/google-icon.png" alt="Google"></button>
            </div>
            <div class="register-link">
                <p>New customer? <a href="${pageContext.request.contextPath}/appUsers/register">Register now</a></p>
            </div>
        </form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function togglePasswordVisibility() {
        var passwordField = document.getElementById("password");
        var toggleIcon = document.getElementById("toggleIcon");
        if (passwordField.type === "password") {
            passwordField.type = "text";
            toggleIcon.classList.remove("fa-eye");
            toggleIcon.classList.add("fa-eye-slash");
        } else {
            passwordField.type = "password";
            toggleIcon.classList.remove("fa-eye-slash");
            toggleIcon.classList.add("fa-eye");
        }
    }
</script>
</body>
</html>
