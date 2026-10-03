<?php
// Muestra qué servidor web atiende la petición
echo "<h1>Servidor: " . gethostname() . "</h1>";
echo "<p>Dirección IP del servidor: " . $_SERVER['SERVER_ADDR'] . "</p>";
echo "<p>Dirección IP del cliente: " . $_SERVER['REMOTE_ADDR'] . "</p>";
echo "<p>Fecha y hora: " . date('Y-m-d H:i:s') . "</p>";
?>
