<%@ include file="../header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Representatives</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            margin: 20px auto;
            width: 80%;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .add-rep-form {
            display: none;
            background: #f9f9f9;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .rep-list {
            width: 100%;
            border-collapse: collapse;
        }

        .rep-list th, .rep-list td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .rep-list th {
            background-color: #f2f2f2;
        }

        .actions button {
            margin: 0 5px;
        }

        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Manage Customer Representatives</h2>
            <button onclick="toggleAddForm()">+ Add New</button>
        </div>

        <!-- Add Representative Form -->
        <div id="add-rep-form" class="add-rep-form">
            <form action="/admin/addRep" method="post">
                <label>First Name: <input type="text" name="firstName" required></label><br><br>
                <label>Last Name: <input type="text" name="lastName" required></label><br><br>
                <label>Email: <input type="email" name="emailAddress" required></label><br><br>
                <label>Social Security Number: <input type="text" name="socialSecurityNumber" required></label><br><br>
                <label>Username: <input type="text" name="username" required></label><br><br>
                <button type="submit">Save</button>
                <button type="button" onclick="toggleAddForm()">Cancel</button>
            </form>
        </div>

        <!-- Representative List -->
        <table class="rep-list">
            <thead>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Social Security Number</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="rep" items="${reps}">
                <tr id="rep-${rep.username}">
                    <td>
                        <span class="display-field">${rep.firstName}</span>
                        <input class="edit-field hidden" type="text" value="${rep.firstName}" name="firstName">
                    </td>
                    <td>
                        <span class="display-field">${rep.lastName}</span>
                        <input class="edit-field hidden" type="text" value="${rep.lastName}" name="lastName">
                    </td>
                    <td>
                        <span class="display-field">${rep.emailAddress}</span>
                        <input class="edit-field hidden" type="text" value="${rep.emailAddress}" name="emailAddress">
                    </td>
                    <td>
                        <span class="display-field">${rep.socialSecurityNumber}</span>
                        <input class="edit-field hidden" type="text" value="${rep.socialSecurityNumber}" name="socialSecurityNumber">
                    </td>
                    <td class="actions">
                        <button class="edit-btn" onclick="toggleEdit(`${rep.username}`)">Edit</button>
                        <button class="delete-btn" onclick="location.href='/admin/deleteRep/${rep.username}'">Delete</button>
                        <button class="save-btn hidden" onclick="submitChanges('${rep.username}')">Save</button>
                        <button class="cancel-btn hidden" onclick="toggleEdit(`${rep.username}`)">Cancel</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        function toggleAddForm() {
            const form = document.getElementById('add-rep-form');
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }

        function toggleEdit(repId) {
            const element =  "rep-" + repId;
            const container = document.getElementById(element);
            const editFields = container.querySelectorAll('.edit-field');
            const displayFields = container.querySelectorAll('.display-field');
            const editButton = container.querySelector('.edit-btn');
            const deleteButton = container.querySelector('.delete-btn');
            const saveButton = container.querySelector('.save-btn');
            const cancelButton = container.querySelector('.cancel-btn');

            if (editButton.style.display !== 'none') {
                // Switch to edit mode
                editFields.forEach(field => field.classList.remove('hidden'));
                displayFields.forEach(field => field.classList.add('hidden'));
                editButton.style.display = 'none';
                deleteButton.style.display = 'none';
                saveButton.style.display = 'inline-block';
                cancelButton.style.display = 'inline-block';
            } else {
                // Cancel edit mode
                editFields.forEach(field => field.classList.add('hidden'));
                displayFields.forEach(field => field.classList.remove('hidden'));
                editButton.style.display = 'inline-block';
                deleteButton.style.display = 'inline-block';
                saveButton.style.display = 'none';
                cancelButton.style.display = 'none';
            }
        }

        // Submit changes to the server--%>
        function submitChanges(repId) {
            const element =  "rep-" + repId;
            const container = document.getElementById(element);
            const editables = container.querySelectorAll('.edit-field');
            var payload = {};
            payload.repId = repId;

            // Collect updated values
            editables.forEach((input, index) => {
                if (index === 0) payload.firstName = input.value;
                if (index === 1) payload.lastName = input.value;
                if (index === 2) payload.emailAddress = input.value;
                if (index === 3) payload.socialSecurityNumber = input.value;
            });

            // Example AJAX call to submit changes
            fetch('/admin/updateRep', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(payload),
            })
                .then(response => {
                    if (response.ok) {
                        alert('Changes saved successfully.');
                        location.reload(); // Reload page to show updated data
                    } else {
                        alert('Failed to save changes.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    </script>
</body>
</html>





<%--<%@ include file="../header.jsp" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Manage Customer Representatives</title>--%>
<%--    <style>--%>
<%--        .container {--%>
<%--            width: 90%;--%>
<%--            margin: 20px auto;--%>
<%--        }--%>

<%--        .rep-box {--%>
<%--            border: 1px solid #ddd;--%>
<%--            border-radius: 5px;--%>
<%--            padding: 15px;--%>
<%--            margin-bottom: 15px;--%>
<%--            display: flex;--%>
<%--            justify-content: space-between;--%>
<%--            align-items: center;--%>
<%--        }--%>

<%--        .rep-box:hover {--%>
<%--            border-color: #007BFF;--%>
<%--            box-shadow: 0 2px 8px rgba(0, 0, 255, 0.2);--%>
<%--        }--%>

<%--        .details {--%>
<%--            flex-grow: 1;--%>
<%--        }--%>

<%--        .actions {--%>
<%--            margin-left: 20px;--%>
<%--            display: flex;--%>
<%--            gap: 10px;--%>
<%--        }--%>

<%--        .hidden {--%>
<%--            display: none;--%>
<%--        }--%>

<%--        .editable {--%>
<%--            background-color: #f9f9f9;--%>
<%--            border: 1px solid #ccc;--%>
<%--            border-radius: 4px;--%>
<%--            padding: 5px;--%>
<%--        }--%>

<%--        button {--%>
<%--            background-color: #007BFF;--%>
<%--            color: white;--%>
<%--            border: none;--%>
<%--            padding: 10px 20px;--%>
<%--            border-radius: 5px;--%>
<%--            cursor: pointer;--%>
<%--        }--%>

<%--        button:hover {--%>
<%--            background-color: #0056b3;--%>
<%--        }--%>

<%--        .cancel-btn {--%>
<%--            background-color: #FF5733;--%>
<%--        }--%>

<%--        .cancel-btn:hover {--%>
<%--            background-color: #C70039;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <h2>Manage Customer Representatives</h2>--%>
<%--    <div>--%>
<%--        <c:forEach var="rep" items="${reps}">--%>
<%--            <div class="rep-box" id="rep-${rep.username}">--%>
<%--                <div class="details">--%>
<%--                    <p><strong>Username:</strong> <span class="static">${rep.username}</span></p>--%>
<%--                    <p><strong>Name:</strong>--%>
<%--                        <span class="static">${rep.firstName} ${rep.lastName}</span>--%>
<%--                        <input class="editable hidden" type="text" value="${rep.firstName}" />--%>
<%--                        <input class="editable hidden" type="text" value="${rep.lastName}" />--%>
<%--                    </p>--%>
<%--                    <p><strong>Email:</strong>--%>
<%--                        <span class="static">${rep.emailAddress}</span>--%>
<%--                        <input class="editable hidden" type="email" value="${rep.emailAddress}" />--%>
<%--                    </p>--%>
<%--                    <p><strong>SSN:</strong>--%>
<%--                        <span class="static">${rep.socialSecurityNumber}</span>--%>
<%--                        <input class="editable hidden" type="text" value="${rep.socialSecurityNumber}" />--%>
<%--                    </p>--%>
<%--                </div>--%>
<%--                <div class="actions">--%>
<%--                    <button onclick="enableEdit('${rep.username}')">Edit</button>--%>
<%--                    <button class="hidden save-btn" onclick="submitChanges('${rep.username}')">Save</button>--%>
<%--                    <button class="hidden cancel-btn" onclick="discardChanges('${rep.username}')">Cancel</button>--%>
<%--                    <button onclick="enableEdit('${rep.username}')">Delete</button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </c:forEach>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script>--%>
<%--    // Enable editing for a specific representative--%>
<%--    function enableEdit(repId) {--%>
<%--        var container = document.getElementById(`rep-${repId}`);--%>
<%--        var statics = container.querySelectorAll('.static');--%>
<%--        var editables = container.querySelectorAll('.editable');--%>
<%--        var buttons = container.querySelectorAll('button');--%>

<%--        // Hide static fields and show editable inputs--%>
<%--        statics.forEach(element => element.classList.add('hidden'));--%>
<%--        editables.forEach(element => element.classList.remove('hidden'));--%>

<%--        // Show save and cancel buttons, hide edit button--%>
<%--        buttons[0].classList.add('hidden'); // Edit button--%>
<%--        buttons[1].classList.remove('hidden'); // Save button--%>
<%--        buttons[2].classList.remove('hidden'); // Cancel button--%>
<%--        buttons[3].classList.add('hidden'); // Delete button--%>
<%--    }--%>

<%--    // Discard changes and revert to static fields--%>
<%--    function discardChanges(repId) {--%>
<%--        var container = document.getElementById(`rep-${repId}`);--%>
<%--        var statics = container.querySelectorAll('.static');--%>
<%--        var editables = container.querySelectorAll('.editable');--%>
<%--        var buttons = container.querySelectorAll('button');--%>

<%--        // Show static fields and hide editable inputs--%>
<%--        statics.forEach(element => element.classList.remove('hidden'));--%>
<%--        editables.forEach(element => {--%>
<%--            element.classList.add('hidden');--%>
<%--            element.value = element.defaultValue; // Reset values to original--%>
<%--        });--%>

<%--        // Hide save and cancel buttons, show edit button--%>
<%--        buttons[0].classList.remove('hidden'); // Edit button--%>
<%--        buttons[1].classList.add('hidden'); // Save button--%>
<%--        buttons[2].classList.add('hidden'); // Cancel button--%>
<%--        buttons[3].classList.remove('hidden');--%>
<%--    }--%>

<%--    // Submit changes to the server--%>
<%--    function submitChanges(repId) {--%>
<%--        var container = document.getElementById(`rep-${repId}`);--%>
<%--        var editables = container.querySelectorAll('.editable');--%>
<%--        var payload = {};--%>

<%--        // Collect updated values--%>
<%--        editables.forEach((input, index) => {--%>
<%--            if (index === 0) payload.firstName = input.value;--%>
<%--            if (index === 1) payload.lastName = input.value;--%>
<%--            if (index === 2) payload.emailAddress = input.value;--%>
<%--            if (index === 3) payload.socialSecurityNumber = input.value;--%>
<%--        });--%>

<%--        // Example AJAX call to submit changes--%>
<%--        fetch(`/admin/updateRep/${repId}`, {--%>
<%--            method: 'POST',--%>
<%--            headers: {--%>
<%--                'Content-Type': 'application/json',--%>
<%--            },--%>
<%--            body: JSON.stringify(payload),--%>
<%--        })--%>
<%--            .then(response => {--%>
<%--                if (response.ok) {--%>
<%--                    alert('Changes saved successfully.');--%>
<%--                    location.reload(); // Reload page to show updated data--%>
<%--                } else {--%>
<%--                    alert('Failed to save changes.');--%>
<%--                }--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error:', error);--%>
<%--            });--%>
<%--    }--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>
