<?php

$client = getenv('CLIENT_NAME', true);
if (!$client) $client = "Bruce";
print("Hello, " . $client . "!\n");
