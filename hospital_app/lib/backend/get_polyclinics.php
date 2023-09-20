
<?php 

  include("conn.php");
  
  
  
  $queryResult = $connection->
      query("SELECT * FROM polikilinik");

  $result = array();

  while ($fetchdata=$queryResult->fetch_assoc()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);
 ?>