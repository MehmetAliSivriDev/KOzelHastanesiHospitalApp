<?php 

include("conn.php");

if(isset($_POST["doktor_eposta"]) && isset($_POST["doktor_sifre"])) {

    function test_input($data){ 
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    $gelen_email = test_input($_POST["doktor_eposta"]);
    $gelen_sifre = test_input($_POST["doktor_sifre"]);
    
    
    $queryResult = $connection->query("SELECT * FROM doktor");


    $girisKontrol = false;
    


    if(mysqli_num_rows($queryResult) > 0){
        while($row = mysqli_fetch_assoc($queryResult)){
            $doktorEmail = $row["doktor_eposta"];
            $doktorSifre = $row["doktor_sifre"];
            
            $girilenSifre = hash('sha512', $gelen_sifre);
            
            if($gelen_email == $doktorEmail && $girilenSifre == $doktorSifre){
                
               $girisKontrol = true; 
               $response = $doktorEmail;
            }
            
        }
    }

    if($girisKontrol == true){
        echo json_encode($response);
    }else{
        header('X-PHP-Response-Code: 404', true, 404);
    }
    
}
else{
    header('X-PHP-Response-Code: 404', true, 404);
}

?>