<?php

    if(isset($_POST["doktor_id"]) && isset($_POST["hasta_id"]) && isset($_POST["randevu_tarihi"]) && isset($_POST["randevu_saati"])){
        
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

        $randevu_saati= test_input($_POST["randevu_saati"]);
        $randevu_tarihi = test_input($_POST["randevu_tarihi"]);
        $doktorId = test_input($_POST["doktor_id"]);
        $hastaId = test_input($_POST["hasta_id"]);
        // ------------------------------------------------------------------------------------
        $sql = "INSERT INTO randevu_alma (`randevu_saati`,`randevu_tarihi`,`doktor_id`,`hasta_id`) VALUES
            (?,?,?,?)";
                
        $stmt = mysqli_prepare($conn,$sql);

        mysqli_stmt_bind_param($stmt, "ssii", $randevu_saati ,$randevu_tarihi,$doktorId,$hastaId);

        mysqli_stmt_execute($stmt);

        $result = mysqli_stmt_get_result($stmt);


        if($result == false){

            $sql2 = "UPDATE calisma_saati SET `doluMu` = 0 where `calisma_saati` = '$randevu_saati' and `calisma_tarihi` = '$randevu_tarihi' and `doktor_id` = '$doktorId'";

            $result2 = mysqli_query($conn,$sql2);
                    
            echo json_encode(1);
               
        }
        else{
            echo json_encode(0);
        }

    }else{
        header('X-PHP-Response-Code: 404', true, 404);
    }

?>