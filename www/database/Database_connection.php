<?php
// Database_connection.php

class Database_connection
{
	function connect()
	{
		$connect = new PDO("mysql:host=mysql; dbname=chat_application", "root", "0000");

		return $connect;
	}
}

?>
