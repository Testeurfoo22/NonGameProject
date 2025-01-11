<!DOCTYPE html>
<?php
    if (isset($_GET['source'])) die(highlight_file(__FILE__, 1));
    require_once 'php.php';
    DBServer();

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

    if (array_key_exists('DECO', $_POST)) {
        $_SESSION["Compte"] = null;
        header('location: ./login.php');
        exit();
    }

    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        
        $NOM = $_POST['NOM'];

        addCat($NOM);
        header('Location: ./account.php');
        exit();
    }
?>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" type="text/css" href="Home_Page.css" /> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <title>Projet2</title>
    </head>
    <body>
        <script>
            function toggleNotification() {
                var notification = document.getElementById("notification");
                if (notification.style.display === "block") {
                    notification.style.display = "none";
                } else {
                    notification.style.display = "block";
                    fetchNotifications();
                }
            }
            function deleteNotification(ID) {
                $.ajax({
                    url: "php.php",
                    type: "GET",
                    data: {
                        action: "deleteNotif", 
                        ID_COM: ID 
                    },
                    success: function(data) {
                        console.log(data);
                        fetchNotifications();
                    },
                    error: function() {
                        console.log("Erreur fonction Ajax.");
                    }
                })
            }

            function fetchNotifications() {
                var ID_COM = <?php echo $Id_Compte; ?>; 
                $.ajax({
                    url: "php.php",
                    type: "GET",
                    data: {
                        action: "getNotif", 
                        ID_COM: ID_COM  
                    },
                    success: function(data) {
                        var notifications = JSON.parse(data);
                        var notificationHtml = "";

                        if (notifications && notifications.length > 0) {
                            notifications.forEach(function(notification) {
                                notificationHtml += 
                                "<div><span>" + notification.MESSAGE  + 
                                    " </span><button onclick=deleteNotification(" + notification.ID_NOTIF + ")>X</button></div>";
                            });
                        } else {
                            notificationHtml = "<p>Pas de notification.</p>";
                        }
                        $("#notification").html(notificationHtml);
                    },
                    error: function() {
                        console.log("Erreur fonction Ajax.");
                    }
                });
            }

            $(document).ready(function(){
                LNavBar();
                showContent("account")
            });

            function showContent(content) {
                var ID_COM = <?php echo $Id_Compte; ?>; 
                if (content === 'account') {
                    $.ajax({
                    url: "php.php",
                    type: 'GET',
                    data: {action: "getUser",
                            ID_COM: ID_COM, 
                            MAIL: null,
                            MDP: null,
                            ADMIN: null
                            },
                    success: function(response) {
                        var User = JSON.parse(response);
                        var htmlR = "<p id=\"name\">Nom: " + User[0].NOM + "</p>" +
                            "<p id=\"surname\">Prenom: " + User[0].PRENOM + "</p>" +
                            "<p id=\"mail\">Mail: " + User[0].MAIL + "</p>" +
                            "<p id=\"tel\">Telephone: " + User[0].TEL + "</p>";
                        if (User[0].ADMIN == 0){
                            htmlR += "<p>User</p>";
                        }
                        else{
                            htmlR += "<p>ADMIN</p>";
                        }
                        htmlR += "<button class='edit-account-button' onclick=\"editAccount()\">Modifier compte</button>";
                        $('#content').html(htmlR);
                    },
                    error: function(xhr, status, error) {
                        console.log(error);
                    }
                    });
                } else if (content === 'admins') {
                    $.ajax({
                        url: "php.php",
                        type: 'GET',
                        data: {
                            action: "getUser",
                            ID_COM: null,
                            MAIL: null,
                            MDP: null,
                            ADMIN: null
                        },
                        success: function(response) {
                            var Users = JSON.parse(response);
                            var htmlR = "";
                            Users.forEach(function(User) {
                                var role = User.ADMIN == 0 ? "USER" : "ADMIN";
                                var formId = "form_" + User.ID_COM;
                                htmlR += "<span>" + User.NOM + " " + User.PRENOM + "  </span>";
                                htmlR += "<span id='role_" + User.ID_COM + "'>" + role + "  </span>";
                                htmlR += "<form id='" + formId + "' class='adminForm' style='display: none;'>";
                                htmlR += "<input type='hidden' name='ID_COM' value='" + User.ID_COM + "'>";
                                htmlR += "<label for='role_" + User.ID_COM + "'></label>";
                                htmlR += "<select id='select_role_" + User.ID_COM + "' name='ADMIN'>";
                                htmlR += "<option value='0' " + (User.ADMIN == 0 ? "selected" : "") + ">USER</option>";
                                htmlR += "<option value='1' " + (User.ADMIN == 1 ? "selected" : "") + ">ADMIN</option>";
                                htmlR += "</select>";
                                htmlR += "<button type='submit'>Submit</button>";
                                htmlR += "<button type='button' class='cancelBtn'>Cancel</button>";
                                htmlR += "</form>";
                                htmlR += "<button type='button' class='editBtn' id='editBtn_" + User.ID_COM + "' data-form-id='" + formId + "'>Edit</button><p></p>";
                            });
                            $('#content').html(htmlR);
                        },
                        error: function(xhr, status, error) {
                            console.log(error);
                        }
                    });
                } else if (content === 'categorie') {
                    $.ajax({
                        url: "php.php",
                        type: "GET",
                        data: {
                            action: "getCat",
                            ID_CAT: null
                        },
                        success: function(data) {
                            var cats = JSON.parse(data);
                            htmlR = "";
                            if (cats === null) {
                                htmlR += "<p>Pas de catégories</p>";
                            } else {
                                cats.forEach(function(cat) {
                                    htmlR += "<p>" + cat.NOM + " <button onclick=deleteCat(" + cat.ID_CAT + ")>X</button></p>";
                                });
                            }
                            htmlR += "<form method='POST'><input type='text' name='NOM' placeholder='Nouvelle Catégorie' onkeydown='if(event.keyCode===13) {this.form.submit(); event.preventDefault();}' required>"+
                                "<button type='submit'>Ajouter</button></form>"
                            $('#content').html(htmlR);
                        },
                        error: function() {
                            console.log("Erreur fonction Ajax.");
                        }
                    });
                }
            }

            $(document).on('click', '.editBtn', function() {
                var formId = $(this).data('form-id');
                $('#' + formId).show();
                $(this).hide(); // Hide the "Edit" button
                $('#role_' + formId.replace('form_', '')).hide(); // Hide the admin span
            });

            $(document).on('click', '.cancelBtn', function() {
                var formId = $(this).closest('form').attr('id');
                $('#' + formId).hide();
                var userId = formId.replace('form_', '');
                $('#role_' + userId).show(); // Show the admin span
                $('#editBtn_' + userId).show(); // Show the "Edit" button
            });

            $(document).on('submit', '.adminForm', function(event) {
                event.preventDefault();
                var formData = $(this).serialize();
                var serializedValues = formData.split('&');
                var ID_COM = null;
                var ADMIN = null;
                
                for (var i = 0; i < serializedValues.length; i++) {
                    var pair = serializedValues[i].split('=');
                    if (pair[0] === 'ID_COM') {
                        ID_COM = pair[1];
                    } else if (pair[0] === 'ADMIN') {
                        ADMIN = pair[1];
                    }
                }
                var formId = $(this).attr('id');
                var userId = formId.replace('form_', '');
                
                $.ajax({
                    url: "php.php",
                    type: "GET",
                    data: {
                        action: "updateUser",
                        ID_COM: ID_COM,
                        MAIL: null,
                        MDP: null,
                        TEL: null,
                        NOM: null,
                        PRENOM: null,
                        ADMIN: ADMIN,
                    },
                    success: function(response) {
                        console.log(response);
                        $('#' + formId).hide();
                        $('#role_' + userId).text($('#select_role_' + userId + ' option:selected').text());
                        $('#role_' + userId).show(); // Show the admin span
                        $('#editBtn_' + userId).show(); // Show the "Edit" button
                    },
                    error: function(xhr, status, error) {
                        console.log(error);
                    }
                });
            });

            function deleteCat(ID_CAT){
                $.ajax({
                    url: "php.php",
                    type: "GET",
                    data: {
                        action: "deleteCat",
                        ID_CAT: ID_CAT
                    },
                    success: function(data) {
                        console.log(data);
                        showContent("categorie");
                    },
                    error: function() {
                        console.log("Erreur fonction Ajax.");
                    }
                });
            }

            function LNavBar(){
                var ID_COM = <?php echo $Id_Compte; ?>; 
                $.ajax({
                    url: "php.php",
                    type: "GET",
                    data: {
                        action: "getUser",
                        ID_COM: ID_COM, 
                        MAIL: null,
                        MDP: null,
                        ADMIN: null
                    },
                    success: function(data) {
                        var User = JSON.parse(data);
                        if (User[0].ADMIN == 1){
                            htmlR = "<li><a href='#' onclick=\"showContent('admins')\">ADMINS</a></li>" + 
                            "<li><a href='#' onclick=\"showContent('categorie')\">CATEGORIE</a></li>"
                            $('#navbarACCOUNT>ul').append(htmlR);
                        }
                    },
                    error: function() {
                        console.log("Erreur fonction Ajax.");
                    }
                });
            }

            function editAccount() {
                var name = $('#name').text();
                var surname = $('#surname').text();
                var mail = $('#mail').text();
                var tel = $('#tel').text();
                var htmlR = "<form class='AccountForm'>" +
                            "<p>Nom <input type='text' name='name' value='" + name + "'  required></p>" +
                            "<p>Prénom <input type='text' name='surname' value='" + surname + "' required></p>" +
                            "<p>Courriel <input type='text' name='mail' value='" + mail + "' required></p>" +
                            "<p>Téléphone <input type='text' name='tel' value='" + tel + "' required> </p>" +
                            "<p>Ancien Mot de passe<input type='password' name='currentPassword' placeholder='Current Password'></p>" +
                            "<p>Nouveau Mot de passe<input type='password' name='newPassword' placeholder='New Password'></p>" +
                            "<p>Confirmer nouveau Mot de passe<input type='password' name='confirmPassword' placeholder='Confirm Password'></p>" +
                            "<button type='button'  onclick='cancelEdit()'>Cancel</button>" +
                            "<button type='submit' id='updateUser' class='updateUser'>Submit</button>" +
                            "</form>";
                $('#content').html(htmlR);
            }

            $(document).on('submit', '.AccountForm', function(event) {
                event.preventDefault();
                
                var NOM = $('input[name="name"]').val();
                var PRENOM = $('input[name="surname"]').val();
                var MAIL = $('input[name="mail"]').val();
                var TEL = $('input[name="tel"]').val();
                var CMDP = $('input[name="currentPassword"]').val();
                var NMDP = $('input[name="newPassword"]').val();
                var CNMDP = $('input[name="confirmPassword"]').val();

                $.ajax({
                    url: "php.php",
                    type: 'POST',
                    data: {
                        action: "getHash",
                        currentPassword: CMDP,
                        newPassword: NMDP,
                        confirmPassword: CNMDP
                    },
                    success: function(response) {
                        response = JSON.parse(response);
                        console.log(response)
                        CMDP = response[0];
                        NMDP = response[1];
                        CNMDP = response[2];
                        console.log(CMDP);
                        console.log(NMDP);
                        console.log(CNMDP);
                        // Validate form inputs
                        var password = '<?php echo $Compte["MDP"]; ?>';
                        if(CMDP !== '' && CMDP !== password){
                            alert("Ancien mdp errone.");
                            return;
                        }
                        if ((NMDP !== '' && CMDP === '') || (CMDP !== '' && CNMDP === '') || (NMDP !== '' && CNMDP === '')
                            || (NMDP === '' && CMDP !== '') || (CMDP === '' && CNMDP !== '') || (NMDP === '' && CNMDP !== '')) {
                            alert("Vous avez oublie une case du formulaire");
                            return;
                        }
                        if (NMDP === CNMDP){
                            $.ajax({
                                url: "php.php",
                                type: 'GET',
                                data: {
                                    action: "updateUser",
                                    ID_COM: <?php echo $Id_Compte; ?>,
                                    MAIL: MAIL,
                                    MDP: CNMDP,
                                    TEL: TEL,
                                    NOM: NOM,
                                    PRENOM: PRENOM,
                                    ADMIN: null,

                                },
                                success: function(response) {
                                    console.log(response)
                                    showContent('account');

                                },
                                error: function(xhr, status, error) {
                                    console.log(error);
                                }
                            });
                        }
                        else{
                            alert("Les mots de passes ne sont pas les memes.");
                            return;
                        }
                    },
                    error: function(xhr, status, error) {
                        console.log(error);
                    }
                });
            });

            function cancelEdit() {
                showContent('account');
            }
        </script>
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
            <a href="./account.php" class="link-account logo-container">
                <img src="logo-compte.jpg" alt="Logo de compte">
            </a>

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
        <div class="main">
            <div class="sidebar">
                <div id="navbarACCOUNT" class="navbarACCOUNT">
                <ul>
                    <li><a href="#" onclick="showContent('account')">ACCOUNT</a></li>
                </ul>
                </div>
            </div>
            <div id="content" class="content">
            </div>
        </div>
        <div id="notification" class="notification"></div>
    </body>
    <?php
        //session_write_close();

        //session_destroy();
        closeConn()
    ?>
</html>