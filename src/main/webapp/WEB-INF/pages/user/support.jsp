<%@ include file="../header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forum - Questions and Answers</title>
    <style>
        .question {
            margin-bottom: 20px;
            border: 1px solid #ddd;
            padding: 10px;
        }
        .answer {
            margin-left: 20px;
            border-left: 2px solid #007bff;
            padding-left: 10px;
        }
        .search-form, .ask-form {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<h1>Forum - Questions and Answers</h1>

<!-- Search form -->
<div class="search-form">
    <form action="/user/support" method="get">
        <input type="text" name="keyword" value="${keyword}" placeholder="Search questions...">
        <input type="submit" value="Search">
    </form>
</div>

<!-- Ask question form -->
<div class="ask-form">
    <h2>Ask a New Question</h2>
    <form action="/user/support/ask" method="post">
        <textarea name="questionText" rows="3" cols="50" placeholder="Type your question here..."></textarea>
        <br>
        <input type="submit" value="Ask Question">
    </form>
</div>

<!-- Display questions and answers -->
<c:forEach items="${questions}" var="question">
    <div class="question">
        <h2>Question: ${question[2]}</h2>
        <p>Asked by: ${question[1]} on ${question[3]}</p>

        <c:if test="${not empty question[5]}">
            <div class="answer">
                <h3>Answer:</h3>
                <p>${question[5]}</p>
                <p>Answered by: ${question[4]} on ${question[6]}</p>
            </div>
        </c:if>

        <c:if test="${empty question[5]}">
            <p>This question has not been answered yet.</p>
        </c:if>
    </div>
</c:forEach>

<c:if test="${empty questions}">
    <p>No questions found.</p>
</c:if>
</body>
</html>
