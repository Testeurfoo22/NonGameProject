<?php
    if (isset($_GET['source'])) die(highlight_file(__FILE__, 1));
    require_once 'php.php';
    DBServer();

    if (isset($_GET['ID_COM'])) {
        $ID_COM = $_GET['ID_COM'];
    } else {
        header("Location: ./Main.php");
        exit;
    }

    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        
        $nom = $_POST['nom'];
        $cat = $_POST['cat2'];
        $description = $_POST['description'];

        addTache($ID_COM, $nom, $cat, $description);
        header('Location: ./Main.php');
        exit();
    }

    if (($_SESSION["Compte"]) == NULL){
        header('location: ./login.php');
        exit();
    }
    else{
        $Compte = $_SESSION["Compte"];
        $Id_Compte = $Compte["ID_COM"];
        $compte = getUser(null, $Compte["MAIL"], $Compte["MDP"], null)[0];
        if ($compte == null){
            header('location: ./login.php');
            exit();
        }
    }
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="Home_Page.css"/>
    <title>Add</title>
</head>
<body>
    <div id="nav">
        <?php
            if ($Id_Compte > 0){
                echo "<a href='./main.php'>Page d'accueil</a>";
            }
            else{
                echo "<p>Compte Invite</p>";
            }
        ?>
        <form method="post">
            <input type="submit" name="DECO" class="button" value="DECONNECTION" />
        </form>
        <button onclick="toggleNotification()" class="button-notification">Notification</button>
        <a href="./account.php">Compte</a>
        <form action="search.php" method="GET">
            <input type="text" name="Nom" placeholder="Recherche" onkeydown="if(event.keyCode===13) {this.form.submit(); event.preventDefault();}">
            <select id="cat" name="Cat">
                <option value="">tous</option>
            </select>
            <input type="date" name="Day">
            <input type="text" name="Creator" placeholder="Créateur">
            <select name="Actif">
                <option value="">Tout</option>
                <option value="1">Actif</option>
                <option value="0">Terminé</option>
            </select>
            <button type="submit">Rechercher</button>
        </form>
    </div>
    <h1>Ajouter des tâches</h1>

    <form id="addForm" action="<?php echo $_SERVER['PHP_SELF'] . '?ID_COM=' . $ID_COM; ?>" method="POST">
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" required>

        <label for="cat2">Catégorie :</label>
        <select id="cat2" name="cat2" required></select>

        <label for="description">Description :</label>
        <textarea id="description" name="description" required></textarea>

        <input type="submit" value="Ajouter">
    </form>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Fetch the categories
            $.ajax({
                url: "php.php",
                type: "GET",
                data: {
                    action: "getCat",
                    ID_CAT: null
                },
                success: function(data) {
                    var categories = JSON.parse(data);
                    console.log(categories);
                    
                    // Populate the categories in the select element
                    categories.forEach(function(category) {
                        $('#cat').append('<option value="' + category.ID_CAT + '">' + category.NOM + '</option>');
                        $('#cat2').append('<option value="' + category.ID_CAT + '">' + category.NOM + '</option>');
                    });
                },
                error: function() {
                    console.log("Erreur fonction Ajax.");
                }
            });
        });
    </script>
</body>
</html>