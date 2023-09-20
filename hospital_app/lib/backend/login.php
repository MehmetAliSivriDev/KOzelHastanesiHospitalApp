<?php 

include("conn.php");

if(isset($_POST["hasta_eposta"]) && isset($_POST["hasta_sifre"])) {

    function test_input($data){ 
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    $gelen_email = test_input($_POST["hasta_eposta"]);
    $gelen_sifre = test_input($_POST["hasta_sifre"]);
    
    
    $queryResult = $connection->query("SELECT * FROM hastalar");


    $girisKontrol = false;
    


    if(mysqli_num_rows($queryResult) > 0){
        while($row = mysqli_fetch_assoc($queryResult)){
            $kullaniciEmail = $row["hasta_eposta"];
            $kullaniciSifre = $row["hasta_sifre"];
            
            $girilenSifre = hash('sha512', $gelen_sifre);
            
            if($gelen_email == $kullaniciEmail && $girilenSifre == $kullaniciSifre){
                
               $girisKontrol = true; 
               $response = $kullaniciEmail;
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