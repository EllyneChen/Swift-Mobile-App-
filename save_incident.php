<?php
// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "hope_special_care";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed"]));
}

// Get JSON input from iOS app
$data = json_decode(file_get_contents("php://input"), true);

if ($data) {
    $category = $conn->real_escape_string($data['category']);
    $description = $conn->real_escape_string($data['description']);
    $timestamp = $conn->real_escape_string($data['timestamp']);

    $sql = "INSERT INTO incidents (category, description, timestamp) VALUES ('$category', '$description', '$timestamp')";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(["status" => "success", "message" => "Incident recorded successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => $conn->error]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid input"]);
}

$conn->close();
?>
