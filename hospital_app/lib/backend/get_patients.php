
<?php 

  include("conn.php");

  $queryResult = $connection->
      query("SELECT * FROM hastalar");

  $result = array();

  while ($fetchdata=$queryResult->fetch_assoc()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);
 ?>