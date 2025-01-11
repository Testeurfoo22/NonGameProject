<?php
    if (isset($_GET['source'])) die(highlight_file(__FILE__, 1));
    require_once 'php.php';
    DBServer();

    // Process the form submission
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $mail = $_POST["username"];
        $mdp = $_POST["password"];
        $phone = $_POST["phone"];
        $name = $_POST["name"];
        $surname = $_POST["surname"];

        if (!filter_var($mail, FILTER_VALIDATE_EMAIL)) {
            echo "Invalid email address";
        }
        else{
            $hashedPassword = hash('sha512', $mdp);

            $Compte = getUser(null, $mail, null, null)[0];
            if ($Compte == null) {
                $Compte = addUser($mail, $hashedPassword, $phone, $name, $surname);
                if ($Compte != null){
                    $_SESSION["Compte"] = $Compte;
                    header('Location: ./Main.php');
                    exit();
                }
                else {
                    echo "Error Occured";
                }
            } else {
                echo "Compte Existant";
            }
        }
    }
?>

<!DOCTYPE html>
<?php if (isset($_GET['source'])) die(highlight_file(__FILE__, 1)); ?>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" type="text/css" href="Home_Page.css" /> 
        <title>Projet2</title>
    </head>
    <body>

        <form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="POST">
        <div class="container">
            <h3>Inscription</h3>
            <label for="username">Courriel:</label>
            <input type="text" id="username" name="username" required><br><br>
            
            <label for="password">Mot de passe:</label>
            <input type="password" id="password" name="password" required><br><br>

            <label for="phone">Numéro de téléphone:</label>
            <input type="tel" id="phone" name="phone" placeholder="1234567890" pattern="[0-9]{10}"><br><br>

            <label for="name">Nom:</label>
            <input type="text" id="name" name="name" required><br><br>

            <label for="surname">Prénom:</label>
            <input type="text" id="surname" name="surname" required><br><br>
            
            <input type="submit" value="S'inscrire" class="btn btn-primary">
            <a href="./login.php">Connectez-vous ici!</a>
        </div>    
        </form>
    </body>
    <?php
        session_unset();

        session_destroy();
        closeConn()
    ?>
</html>