<?php

    $connection = new mysqli("localhost", "root", "", "hastaneveritabani");

    if (!$connection) {
        echo "connection failed!";
        exit();
    }
?>