<?php

    if(isset($_POST["hasta_eposta"]) && isset($_POST["hasta_adi"]) && isset($_POST["hasta_soyadi"])
     && isset($_POST["hasta_TC"])&& isset($_POST["hasta_sifre"])&& isset($_POST["dogum_tarihi"])
     && isset($_POST["kan"])&& isset($_POST["cinsiyet"])){
        
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
        $gelen_hasta_adi = test_input($_POST["hasta_adi"]);
        $gelen_hasta_soyadi = test_input($_POST["hasta_soyadi"]);
        $gelen_hasta_TC = test_input($_POST["hasta_TC"]);
        $gelen_hasta_sifre = test_input($_POST["hasta_sifre"]);
        $gelen_dogum_tarihi = test_input($_POST["dogum_tarihi"]);
        $gelen_kan = test_input($_POST["kan"]);
        $gelen_cinsiyet = test_input($_POST["cinsiyet"]);
        // ------------------------------------------------------------------------------------
        $hashliSifre = hash('sha512', $gelen_hasta_sifre);

        // ------------------------------------------------------------------------------------
        $sql = "INSERT INTO hastalar (`hasta_adi`, `hasta_soyadi`, `hasta_eposta`, `hasta_TC`, `hasta_sifre`,
        `hasta_dogum_tarihi`,`hasta_kan`,`hasta_cinsiyet`) VALUES
            (?,?,?,?,?,?,?,?)";
        
        $sql2 = "Select * from hastalar";
        $hastaKayitlar = mysqli_query($conn,$sql2);

        $stmt = mysqli_prepare($conn,$sql);
        // sorgumuzda çalıştırılacak parametreleri gönderiyoruz  is -> i = int ve s = string
        mysqli_stmt_bind_param($stmt, "sssssssi", $gelen_hasta_adi, $gelen_hasta_soyadi,$gelen_hasta_eposta,$gelen_hasta_TC
        ,$hashliSifre, $gelen_dogum_tarihi, $gelen_kan,$gelen_cinsiyet);
        // sorgu çalıştır
        
        $kayitlar = mysqli_stmt_get_result($stmt);


        $kayitMevcut = false;

        $response = array();

    if(mysqli_num_rows($hastaKayitlar) > 0){
        while($row = mysqli_fetch_assoc($hastaKayitlar)){
            $kullaniciEmail = $row["hasta_eposta"];
            $kullaniciTC = $row["hasta_TC"];

            if($kullaniciEmail == $gelen_hasta_eposta || $kullaniciTC == $gelen_hasta_TC){
                $kayitMevcut = true;
            }
        }
    }

    if($kayitMevcut == false){
        $result = mysqli_stmt_execute($stmt);
        if($result){    
            $response["Message"] = "Kayıt Başarılı.";
            $response["Result"] = 1;

            echo json_encode($response);
        }
        else{
            $response["Message"] = "Bir Hata Meydana Geldi";
            $response["Result"] = 0;

            echo json_encode($response);
        }
    }else{
        $response["Message"] = "Böyle Bir Kayıt Mevcut.(TC veya Email)";
        $response["Result"] = 0;

        echo json_encode($response);
    }

    }else{
        header('X-PHP-Response-Code: 404', true, 404);
    }

?>