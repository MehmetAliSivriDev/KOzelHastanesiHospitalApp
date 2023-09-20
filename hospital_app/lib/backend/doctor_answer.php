<?php

    if(isset($_POST["doktor_id"]) && isset($_POST["hasta_eposta"]) && isset($_POST["poliklinik"])
     && isset($_POST["soru"]) && isset($_POST["cevap"])){
        
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
        
        $gelen_doktor_id= test_input($_POST["doktor_id"]);
        $gelen_hasta_eposta= test_input($_POST["hasta_eposta"]);
        $gelen_poliklinik = test_input($_POST["poliklinik"]);
        $gelen_soru = test_input($_POST["soru"]);
        $gelen_cevap = test_input($_POST["cevap"]);

        // ------------------------------------------------------------------------------------
        $sql = "INSERT INTO doktor_cevap (`doktor_id`,`cevap`,`hasta_eposta`,`hasta_soru`,poliklinik) VALUES
                (?,?,?,?,?)";
            
            
        $stmt = mysqli_prepare($conn,$sql);

        mysqli_stmt_bind_param($stmt, "issss", $gelen_doktor_id ,$gelen_cevap,$gelen_hasta_eposta,$gelen_soru,$gelen_poliklinik);

        mysqli_stmt_execute($stmt);

        $result = mysqli_stmt_get_result($stmt);


        if($result == false){
                    
            echo json_encode(1);
               
        }
        else{
            echo json_encode(0);
        }

    }else{
        header('X-PHP-Response-Code: 404', true, 404);
    }

?>