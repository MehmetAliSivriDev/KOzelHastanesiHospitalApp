<?php 

include("conn.php");

if(isset($_POST["poliklinik"])) {

    function test_input($data){ 
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    $gelen_poliklinik = test_input($_POST["poliklinik"]);
    
    
    $queryResult = $connection->query("SELECT * from hasta_soru where poliklinik='$gelen_poliklinik'");


    $result = array();

    while ($fetchdata=$queryResult->fetch_assoc()) {
        $result[] = $fetchdata;
    }

    echo json_encode($result);
    
}
else{
    header('X-PHP-Response-Code: 404', true, 404);
}

?>