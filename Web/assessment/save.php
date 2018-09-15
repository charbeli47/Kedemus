<?php

$xmldata = isset($_POST['data']) == 1 ? $_POST['data'] : '';

	if($savePassord == $password){
		$fp = fopen('questions.xml', 'w');
		fwrite($fp, $xmldata);
		fclose($fp);
		
		echo '{"status":true, "option":true}';
	}else{
		echo '{"status":false, "option":true}';	
	}	

?>