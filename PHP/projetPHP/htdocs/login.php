<?php
    if (isset($_GET['source'])) die(highlight_file(__FILE__, 1));
    require_once 'php.php';
    DBServer();

    // Process the form submission
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $username = $_POST["username"];
        $password = $_POST["password"];

        $hashedPassword = hash('sha512', $password);

        $Compte = getUser(null, $username, $hashedPassword, null)[0];

        if ($Compte != null) {
            $_SESSION["Compte"] = $Compte;
            header('Location: ./Main.php');
            exit();
        } else {
            echo "<p>Compte pas trouvé</p>";
        }
    }
?>

<!DOCTYPE html>
<?php if (isset($_GET['source'])) die(highlight_file(__FILE__, 1)); ?>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title>Projet2</title>
        <link rel="stylesheet" type="text/css" href="Home_Page.css">
        <link rel="stylesheet" href="/bootstrap-5.3.0-alpha3-dist/css/bootstrap-grid.min.css">
        <script src="/bootstrap-5.3.0-alpha3-dist/js/bootstrap.bundle.min.js"></script>

    </head>
    <body>
    <form  action="<?php echo $_SERVER['PHP_SELF']; ?>" method="POST">
    <h2>BIENVENU!</h2>
    <div class="container">
         
        <div class="form-group">
            <label for="username">Courriel :</label>
            <input type="text" id="username" name="username" class="form-control" required>
        </div>
        <div class="form-group">
             <label for="password">Mot de passe :</label>
             <input type="password" id="password" name="password" class="form-control" required>
        </div>     
      
        <input type="submit" value="Se connecter" class="btn btn-primary">
     </div>    
    </form>
    <a href="./signup.php">Sign Up Here!</a>


    </body>
    <?php
        session_unset();

        session_destroy();
        closeConn()
    ?>
</html>