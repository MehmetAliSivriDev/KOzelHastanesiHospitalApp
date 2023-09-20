<?php 

include("conn.php");

if(isset($_POST["poliklinik_id"]) && isset($_POST["hastane_id"])) {

    function test_input($data){ 
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    $gelen_hastane_id = test_input($_POST["hastane_id"]);
    $gelen_poliklinik_id = test_input($_POST["poliklinik_id"]);
    
    
    $queryResult = $connection->query("SELECT * from doktor where polikilinik_id='$gelen_poliklinik_id' and hastane_id =  '$gelen_hastane_id'");


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