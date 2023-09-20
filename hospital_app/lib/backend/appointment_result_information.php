<?php 

include("conn.php");

if(isset($_POST["doktor_id"]) && isset($_POST["hasta_id"]) && isset($_POST["randevu_tarihi"]) && isset($_POST["randevu_saati"])) {

    function test_input($data){ 
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    $gelen_doktor_id = test_input($_POST["doktor_id"]);    
    $gelen_hasta_id = test_input($_POST["hasta_id"]);  
    $gelen_randevu_saati = test_input($_POST["randevu_saati"]);
    $gelen_randevu_tarihi =  test_input($_POST["randevu_tarihi"]);

    $queryResult = $connection->query( "SELECT d.doktor_adi, d.doktor_soyadi, h.hasta_adi, h.hasta_soyadi, h.hasta_TC,p.polikilinik_adi, hst.hastane_adi, r.randevu_saati, r.randevu_tarihi 
    FROM randevu_alma r JOIN doktor d ON r.doktor_id = d.doktor_id JOIN hastalar h ON r.hasta_id = h.hasta_id 
    JOIN polikilinik p ON d.polikilinik_id = p.polikilinik_id JOIN hastaneler hst ON d.hastane_id = hst.hastane_id 
    WHERE r.doktor_id = '$gelen_doktor_id' AND r.hasta_id = '$gelen_hasta_id' AND r.randevu_saati = '$gelen_randevu_saati' AND r.randevu_tarihi= '$gelen_randevu_tarihi'" );

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