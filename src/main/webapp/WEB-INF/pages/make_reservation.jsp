<jsp:include page="header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Make Reservation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 10px auto;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
        }
        input, select, button {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Search Trains</h2>
        <form action="/train-schedules/search" method="post">
        <div class="form-group">
            <label for="origin">Origin:</label>
            <select id="originDropdown" name="origin" required>
                <option value="">Select origin station</option>
            </select>
        </div>
        <div class="form-group">
            <label for="destination">Destination:</label>
            <select id="destinationDropdown" name="destination" required>
                <option value="">Select destination station</option>
            </select>
        </div>
        <div class="form-group">
            <label for="tripType">Trip Type:</label>
            <select id="tripType" name="tripType" onchange="toggleReturnDate()" required>
                <option value="one-way">One Way</option>
                <option value="round-trip">Round Trip</option>
            </select>
        </div>
        <div class="form-group">
            <label for="travelDate">Travel Date:</label>
            <input type="date" id="travelDate" name="travelDate" required>
        </div>
        <div class="form-group" id="returnDateGroup" style="display: none;">
            <label for="returnDate">Return Date:</label>
            <input type="date" id="returnDate" name="returnDate">
        </div>
        <div class="form-group">
            <label for="adults">Number of Adults:</label>
            <input type="number" id="adults" name="adults" value="0" min="0">
        </div>
        <div class="form-group">
            <label for="children">Number of Children:</label>
            <input type="number" id="children" name="children" value="0" min="0">
        </div>
        <div class="form-group">
            <label for="seniors">Number of Senior Citizens:</label>
            <input type="number" id="seniors" name="seniors" value="0" min="0">
        </div>
        <div class="form-group">
            <label for="disabled">Disabled:</label>
            <input type="number" id="disabled" name="disabled" value="0" min="0">
        </div>
        <div class="form-group">
            <button type="submit" value="search">Search Trains</button>
        </div>
        
    </form>
</div>

<script>
    function toggleReturnDate() {
        const tripType = document.getElementById("tripType").value;
        const returnDateGroup = document.getElementById("returnDateGroup");
        if (tripType === "round-trip") {
            returnDateGroup.style.display = "block";
        } else {
            returnDateGroup.style.display = "none";
        }
    }
    // function refreshPage() {
    //     location.reload();
    // }
    // function fetchStationNames() {
    //     fetch('/station/names')
    //         .then(response => {
    //             if (!response.ok) {
    //                 throw new Error("Failed to fetch station names.");
    //             }
    //             return response.json();
    //         })
    //         .then(stations => {
    //             const originDropdown = document.getElementById('origin');
    //             const destinationDropdown = document.getElementById('destination');

    //     
    //             originDropdown.innerHTML = '<option value="" disabled selected>Select Origin</option>';
    //             destinationDropdown.innerHTML = '<option value="" disabled selected>Select Destination</option>';

    //            
    //             stations.forEach(station => {
    //                 const option1 = document.createElement('option');
    //                 option1.value = station;
    //                 option1.textContent = station;

    //                 const option2 = document.createElement('option');
    //                 option2.value = station;
    //                 option2.textContent = station;

    //                 originDropdown.appendChild(option1);
    //                 destinationDropdown.appendChild(option2);
    //             });
    //         })
    //         .catch(error => {
    //             console.error("Error fetching station names:", error);
    //             alert("Unable to load stations. Please try again later.");
    //         });
    // }
    // window.onload = fetchStationNames;

    document.addEventListener('DOMContentLoaded', function() {
    function populateDropdown(dropdownId) {
        fetch('/station/names')
            .then(response => response.json())
            .then(data => {
                const dropdown = document.getElementById(dropdownId);
                data.forEach(stationName => {
                    const option = document.createElement('option');
                    option.value = stationName;
                    option.textContent = stationName;
                    dropdown.appendChild(option);
                });
            })
            .catch(error => console.error('Error fetching station names:', error));
    }

    populateDropdown('originDropdown');
    populateDropdown('destinationDropdown');
});

// document.addEventListener('DOMContentLoaded', function() {
//     const travelDate = document.getElementById('travelDate');
//     const returnDate = document.getElementById('returnDate');
//     const returnDateGroup = document.getElementById('returnDateGroup');


//     const today = new Date().toISOString().split('T')[0];
//     travelDate.min = today;
//     returnDate.min = today;

//     document.querySelector('form').addEventListener('submit', function(e) {
//         const travelValue = new Date(travelDate.value);
//         const returnValue = new Date(returnDate.value);
//         const currentDate = new Date();

//         if (travelValue < currentDate) {
//             e.preventDefault();
//             alert('Travel date cannot be in the past');
//         } else if (returnDateGroup.style.display !== 'none' && returnValue <= travelValue) {
//             e.preventDefault();
//             alert('Return date must be after Travel date');
//         }
//     });

//     travelDate.addEventListener('change', function() {
//         returnDate.min = travelDate.value;
//     });
// });

document.addEventListener('DOMContentLoaded', function() {
    const travelDate = document.getElementById('travelDate');
    const returnDate = document.getElementById('returnDate');
    const returnDateGroup = document.getElementById('returnDateGroup');

    const today = new Date().toISOString().split('T')[0];
    travelDate.min = today;
    returnDate.min = today;

    const twoYearsFromNow = new Date();
    twoYearsFromNow.setFullYear(twoYearsFromNow.getFullYear() + 2);
    const maxDate = twoYearsFromNow.toISOString().split('T')[0];
    travelDate.max = maxDate;
    returnDate.max = maxDate;

    document.querySelector('form').addEventListener('submit', function(e) {
        const travelValue = new Date(travelDate.value);
        const returnValue = new Date(returnDate.value);
        const currentDate = new Date();

        if (travelValue < currentDate) {
            e.preventDefault();
            alert('Travel date cannot be in the past');
        } else if (returnDateGroup.style.display !== 'none' && returnValue <= travelValue) {
            e.preventDefault();
            alert('Return date must be after Travel date');
        }
    });

    travelDate.addEventListener('change', function() {
        returnDate.min = travelDate.value;
    });
});

</script>

</body>
</html>
