<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Registration</title>

        <link type="text/css" rel="stylesheet"
              href="${pageContext.request.contextPath}/css/user_home.css">

    </head>

    <body>
        <h1>User Registration Success</h1>

        <div class="main">
                <span class="menu"> <a href="${pageContext.request.contextPath}/login"> Login</a>
                </span>
        </div>

        <%-- Check if registrationMessage is not empty --%>
        <c:if test="${not empty registrationMessage}">
            <h3>${registrationMessage}</h3>
        </c:if>

        <h2>User Details:</h2>
        <p>First Name: ${userRegResult.firstName}</p>
        <p>Last Name: ${userRegResult.lastName}</p>
        <p>Email: ${userRegResult.emailAddress}</p>
        <p>username: ${userRegResult.username}</p>
    </body>

</html>