<?php 

include("conn.php");

if(isset($_POST["hasta_eposta"])) {

    function test_input($data){ 
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    $gelen_hasta_eposta = test_input($_POST["hasta_eposta"]);

    
    
    $queryResult = $connection->query("SELECT doktor_adi,doktor_soyadi,hasta_soru,poliklinik,cevap from doktor_cevap dc, doktor d where dc.hasta_eposta='$gelen_hasta_eposta' and dc.doktor_id =  d.doktor_id");


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