<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Questions and Answers</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<h1>Questions and Answers</h1>

<form id="questionForm">
    <div id="questionsContainer"></div>
</form>
<form action="/customerRep" method="get">
    <button type="submit" class="menu-item">Home Page</button>
</form>

<script>
$(document).ready(function() {
    // Fetch questions using Ajax
    $.ajax({
        url: '/questions',
        method: 'GET',
        dataType: 'json',
        success: function(questions) {
            var container = $('#questionsContainer');
            questions.forEach(function(question) {
                var questionHtml = '<div class="question-container">' +
                '<h3>' + question.question_text + '</h3>' +
                '<p>Username: ' + question.username + '</p>' +
                '<p>Timestamp: ' + new Date(question.timestamp).toLocaleString() + '</p>' +
                '<input type="hidden" name="question_id" value="' + question.question_id + '" />' +
                '<input type="hidden" name="username" value="' + question.username + '" />' +
                '<textarea name="answer_text" placeholder="Type your answer here..." required></textarea>' +
                '<button type="button" class="submit-answer" data-question-id="' + question.question_id + '">Submit Answer</button>' +
                '</div><hr />';
                container.append(questionHtml);
            });

            $('.submit-answer').on('click', function() {
            var questionContainer = $(this).closest('.question-container');
            var answer = {
                question_id: questionContainer.find('input[name="question_id"]').val(),
                username: questionContainer.find('input[name="username"]').val(),
                answer_text: questionContainer.find('textarea[name="answer_text"]').val()
            };
            // submitAnswer(answer);
            $.ajax({
        url: '/submitAnswer',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(answer),
        success: function(response) {
            alert('Answer submitted successfully!');
            location.reload();
            questionContainer.find('textarea[name="answer_text"]').val('');
        },
        error: function(xhr, status, error) {
            console.error("Error submitting answer:", error);
            alert('Error submitting answer. Please try again.');
        }
    });
        });
        },
        error: function(xhr, status, error) {
            console.error("Error fetching questions:", error);
            $('#questionsContainer').html('<p>Error loading questions. Please try again later.</p>');
        }
    });

    // // Handle form submission
    // $(document).on('click', '.submit-answer', function() {
    // var questionContainer = $(this).closest('.question-container');
    // var answer = {
    //     question_id: questionContainer.find('input[name="question_id"]').val(),
    //     username: questionContainer.find('input[name="username"]').val(),
    //     answer_text: questionContainer.find('textarea[name="answer_text"]').val()
    // };

    // $.ajax({
    //     url: '/submitAnswer',
    //     method: 'POST',
    //     contentType: 'application/json',
    //     data: JSON.stringify(answer),
    //     success: function(response) {
    //         alert('Answer submitted successfully!');
    //         questionContainer.find('textarea[name="answer_text"]').val('');
    //     },
    //     error: function(xhr, status, error) {
    //         console.error("Error submitting answer:", error);
    //         alert('Error submitting answer. Please try again.');
    //     }
    // });
});

// });

// });
</script>

</body>
</html>
