<?php

    if(isset($_POST["hasta_eposta"]) && isset($_POST["telefon"]) && isset($_POST["adres"])
     && isset($_POST["dogum_yeri"])&& isset($_POST["dogum_tarihi"])&& isset($_POST["kan"])&& isset($_POST["cinsiyet"])){
        
        function test_input($data){ 
            $data = trim($data);
            $data = stripcslashes($data);
            $data = htmlspecialchars($data);
            return $data;
        }
        
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "hastaneveritabani";
        
        $conn = mysqli_connect($servername,$username,$password,$dbname);
        $new = mysqli_set_charset($conn, "utf8");
        if($conn->connect_error){
            die("Bağlantı hatası: ".$conn->connect_error);
        }

        $gelen_hasta_eposta= test_input($_POST["hasta_eposta"]);
        $gelen_telefon = test_input($_POST["telefon"]);
        $gelen_adres = test_input($_POST["adres"]);
        $gelen_dogum_yeri = test_input($_POST["dogum_yeri"]);
        $gelen_dogum_tarihi = test_input($_POST["dogum_tarihi"]);
        $gelen_kan = test_input($_POST["kan"]);
        $gelen_cinsiyet = test_input($_POST["cinsiyet"]);
        // ------------------------------------------------------------------------------------
        $sql ="UPDATE hastalar SET `hasta_cinsiyet` = '$gelen_cinsiyet', `hasta_telefon` = '$gelen_telefon', `hasta_dogum_tarihi` = '$gelen_dogum_tarihi',
        `hasta_dogum_yeri` = '$gelen_dogum_yeri', `hasta_adress` = '$gelen_adres', `hasta_kan` = '$gelen_kan' WHERE `hasta_eposta` = '$gelen_hasta_eposta'";
    
                

    $result = mysqli_query($conn,$sql);


        if($result == true){
                    
            echo json_encode(1);
               
        }
        else{
            echo json_encode(0);
        }

    }else{
        header('X-PHP-Response-Code: 404', true, 404);
    }

?>