<?php 

include("conn.php");

if(isset($_POST["doktor_id"])) {

    function test_input($data){ 
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    $gelen_doktor_id = test_input($_POST["doktor_id"]);    
    
    $queryResult = $connection->query("SELECT DISTINCT calisma_tarihi from calisma_saati where doktor_id='$gelen_doktor_id'");


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