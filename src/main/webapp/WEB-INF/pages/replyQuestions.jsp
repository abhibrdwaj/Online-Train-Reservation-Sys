<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Questions</title>
</head>
<body>

<h1>Questions</h1>

<form action="/submitAnswer" method="post">
    <c:forEach var="question" items="${questions}">
        <div>
            <h3>${question.questionText}</h3>
            <input type="hidden" name="questionId" value="${question.questionId}" />
            <textarea name="answerText" placeholder="Type your answer here..." required></textarea>
        </div>
        <hr />
    </c:forEach>
    
    <button type="submit">Submit Answers</button>
</form>

</body>
</html>