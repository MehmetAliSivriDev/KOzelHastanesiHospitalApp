<?php

    if(isset($_POST["hasta_eposta"]) && isset($_POST["poliklinik"]) && isset($_POST["soru"])){
        
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
        $gelen_poliklinik = test_input($_POST["poliklinik"]);
        $gelen_soru = test_input($_POST["soru"]);
        // ------------------------------------------------------------------------------------
        $sql = "INSERT INTO hasta_soru (`hasta_eposta`, `poliklinik`, `soru`) VALUES
        (?,?,?)";
                
        $stmt = mysqli_prepare($conn,$sql);

        mysqli_stmt_bind_param($stmt, "sss", $gelen_hasta_eposta ,$gelen_poliklinik,$gelen_soru);

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