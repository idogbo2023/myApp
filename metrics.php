<!DOCTYPE html>
<html>
<head>
    <title>System Metrics</title>
</head>
<body>
    <h1>System Metrics</h1>
    <pre>
    <?php
    $metrics = file_get_contents('/var/log/Metrics.txt');
    echo nl2br($metrics);
    ?>
    </pre>
</body>
</html>
