<?php
$host = 'mariadb-alpine-ncc';
$user = 'test_user';
$pass = '12345';
$db = 'sys';
$port = 3306;

try {
    // $conn = new mysqli($host, $user, $pass, null, $port); // Để null ở vị trí Database
    $conn = new mysqli($host, $user, $pass, $db, $port);
    echo "<h1>Kết nối MariaDB thành công (via mysqli)!</h1>";
    echo "<p>Cổng kết nối: " . $port . "</p>";
    echo "<p>Thông tin Server: " . $conn->server_info . "</p>";
    echo "<p>Trạng thái Host: " . $conn->host_info . "</p>";

    // Thử một câu truy vấn nhỏ
    $result = $conn->query("SELECT VERSION() as ver");
    $row = $result->fetch_assoc();
    echo "<p>Version SQL: " . $row['ver'] . "</p>";

    $conn->query("DELETE FROM mysql.user WHERE User='root'");

    // Đóng kết nối
    $conn->close();
} catch (mysqli_sql_exception $e) {
    // echo "Lỗi rồi đại ca ơi: " . $e->getMessage();
    echo "Lỗi rồi đại ca ơi: " . $e->getCode();
}