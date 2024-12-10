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
</html>s
