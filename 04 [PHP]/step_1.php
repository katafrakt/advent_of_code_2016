<?php
$filename = $argv[1];
$file = fopen($filename, 'r');
$sum_of_sector_ids = 0;

while(!feof($file)) {
    $line = fgets($file);
    preg_match('/([a-z-]+)-([0-9]+)\[([a-z]+)\]/', $line, $matches);
    $room_name = str_replace("-", "", $matches[1]);
    $room_sum = (int)$matches[2];
    $checksum = $matches[3];

    $frequency = array_count_values(str_split($room_name));
    arsort($frequency);
    $letters = [];

    foreach($frequency as $letter => $num) {
        if (!array_key_exists($num, $letters))
            $letters[$num] = [];
        array_push($letters[$num], $letter);
    }

    $calculated_checksum = "";

    foreach($letters as $freq => $letters) {
        $num_of_letters = 5 - strlen($calculated_checksum);
        asort($letters);
        $slice = array_slice($letters, 0, $num_of_letters);
        $calculated_checksum .= implode($slice, "");
        if (strlen($calculated_checksum) >= 5) break;
    }

    if ($calculated_checksum == $checksum) {
        $sum_of_sector_ids += $room_sum;
    }
}
echo $sum_of_sector_ids;