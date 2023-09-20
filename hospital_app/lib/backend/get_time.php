<?php 

include("conn.php");

if(isset($_POST["doktor_id"]) && isset($_POST["calisma_tarihi"])) {

    function test_input($data){ 
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    $gelen_doktor_id = test_input($_POST["doktor_id"]);    
    $gelen_calisma_tarihi = test_input($_POST["calisma_tarihi"]);   

    $queryResult = $connection->query( "SELECT * from calisma_saati where doktor_id='$gelen_doktor_id' and calisma_tarihi ='$gelen_calisma_tarihi'" );

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