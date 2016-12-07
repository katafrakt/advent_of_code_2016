<?php
$filename = $argv[1];
$file = fopen($filename, 'r');
$sum_of_sector_ids = 0;

function shift($string, $distance) {
    $array = str_split($string);
    $distance = $distance % 26;

    foreach($array as $idx => $char) {
        if (ord($char) > 97 && ord($char) < 97 + 26) {
            $new_char_ord = ord($char) + $distance;
            while ($new_char_ord >= 97 + 26) $new_char_ord -= 26;
            $array[$idx] = chr($new_char_ord);
        } else {
            $array[$idx] = ' ';
        }
    }
    return implode($array, "");
}

while(!feof($file)) {
    $line = fgets($file);
    preg_match('/([a-z-]+)-([0-9]+)\[([a-z]+)\]/', $line, $matches);
    $room_name = $matches[1];
    $room_sum = (int)$matches[2];

    $result = shift($room_name, $room_sum);
    if (strpos($result, "pole") !== false) echo "[$room_sum] $result\n";
}