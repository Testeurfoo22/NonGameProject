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

    $Nom = isset($_GET['Nom']) ? $_GET['Nom'] : null;
    $Creator = isset($_GET['Creator']) ? $_GET['Creator'] : null;
    $Day = isset($_GET['Day']) ? $_GET['Day'] : null;
    $Cat = isset($_GET['Cat']) ? $_GET['Cat'] : null;
    $Actif = isset($_GET['Actif']) ? $_GET['Actif'] : null;
?>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" type="text/css" href="Home_Page.css" /> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <title>Projet2</title>
        <link rel="stylesheet" type="text/css" href="bootstrap-5.3.0-alpha3-dist/css/bootstrap-grid.min.css" />
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

            $(document).ready(function() {
                $.ajax({
                    url: "php.php",
                    type: "GET",
                    data: {
                        action: "getCat",
                        ID_CAT: null
                    },
                    success: function(data) {
                        var categories = JSON.parse(data);
                        var selectElement = $('#cat');
                        
                        // Populate the categories in the select element
                        categories.forEach(function(category) {
                            selectElement.append('<option value="' + category.ID_CAT + '">' + category.NOM + '</option>');
                        });
                    },
                    error: function() {
                        console.log("Erreur fonction Ajax.");
                    }
                });
                getTacheData();
            });

            function getTacheData() {
                var USER = <?php echo json_encode($Compte); ?>; 
                var Nom = '<?php echo isset($Nom) ? $Nom : ""; ?>';
                var Creator = '<?php echo isset($Creator) ? $Creator : ""; ?>';
                var Day = '<?php echo isset($Day) ? $Day : ""; ?>';
                var Cat = '<?php echo isset($Cat) ? $Cat : ""; ?>';
                var Actif = '<?php echo isset($Actif) ? $Actif : ""; ?>';

                $.ajax({
                    url: 'php.php',
                    type: 'GET',
                    data: {
                        action: "getTache",
                        ID_TCH: null,
                        CREATOR: Creator,
                        NOM: Nom,
                        DAY: Day,
                        CAT: Cat,
                        ACTIF: Actif,
                        MESTACHES: 1
                    },
                    success: function(data) {
                    var TacheData = JSON.parse(data);
                    var TacheDataHtml = '';

                    if (TacheData && TacheData.length > 0) {
                        TacheData.forEach(function(TacheDT) {
                        $.ajax({
                            url: 'php.php',
                            type: 'GET',
                            data: {
                            action: "getUser",
                            ID_COM: TacheDT.CREATOR,
                            MAIL: null,
                            MDP: null,
                            ADMIN: null
                            },
                            success: function(userData) {
                            var Creator = JSON.parse(userData);
                            var creatorInfo = Creator[0].NOM + " " + Creator[0].PRENOM;

                            TacheDataHtml = "<div class='tacheInd'><p>Titre: " + TacheDT.NOM + "</p><span>Date / Createur: " 
                                + TacheDT.DAY + " / " + creatorInfo + "    </span><p></p><button class='view-more' onclick=toggleTache(" + TacheDT.ID_TCH + ")>Voir Plus</Button>";
                            if (Creator[0].ID_COM == USER.ID_COM && TacheDT.ACTIF == 1){
                                TacheDataHtml += "<button class='update' onclick=update(" + TacheDT.ID_TCH + ")>Modifier</Button>";
                            }
                            if (Creator[0].ID_COM == USER.ID_COM || USER.ADMIN == 1){
                                TacheDataHtml += "<button class='delete' onclick=deleteTache(" + TacheDT.ID_TCH + ")>Supprimer</Button>";
                            }
                            var followButtonHtml = "<button class='follow' onclick='toggleFollow(" + TacheDT.ID_TCH + ")' id='followButton_" + TacheDT.ID_TCH + "'";
                            if (TacheDT.isFollowing) {
                                followButtonHtml += " class='following'>Unfollow</button>";
                            } else {
                                followButtonHtml += ">Follow</button>";
                            }

                            TacheDataHtml += followButtonHtml;                            
                            TacheDataHtml += "</div>";
                            $('#tachessearch').append(TacheDataHtml);
                            },
                            error: function(xhr, status, error) {
                            console.log(error);
                            }
                        });
                        });
                    }
                    },
                    error: function(xhr, status, error) {
                    console.log(error);
                    }
                });
            }
            function toggleFollow(ID_TCH) {
                var isFollowing = $('#followButton_' + ID_TCH).hasClass('following');

                if (isFollowing) {
                    deleteFollow(ID_TCH);
                } else {
                    addFollow(ID_TCH);
                }
            }

            function addFollow(ID_TCH) {
                $.ajax({
                    url: 'php.php',
                    type: 'GET',
                    data: {
                        action: 'addFollow',
                        ID_TCH: ID_TCH,
                        ID_COM: <?php echo ($Id_Compte); ?>
                    },
                    success: function(response) {
                        console.log(response)
                        $('#followButton_' + ID_TCH).addClass('following').text('Unfollow');
                    },
                    error: function(xhr, status, error) {
                        console.log(error);
                    }
                });
            }

            function deleteFollow(ID_TCH) {
                $.ajax({
                    url: 'php.php',
                    type: 'GET',
                    data: {
                        action: 'deleteFollow',
                        ID_TCH: ID_TCH,
                        ID_COM: <?php echo ($Id_Compte); ?>
                    },
                    success: function(response) {
                        console.log(response)
                        $('#followButton_' + ID_TCH).removeClass('following').text('Follow');
                    },
                    error: function(xhr, status, error) {
                        console.log(error);
                    }
                });
            }
            function deleteTache(ID) {
                $.ajax({
                    url: "php.php",
                    type: "GET",
                    data: {
                        action: "deleteTache", 
                        ID_TCH: ID 
                    },
                    success: function(data) {
                        console.log(data);
                        location.reload();
                    },
                    error: function() {
                        console.log("Erreur fonction Ajax.");
                    }
                })
            }
            function toggleTache(TACHE) {
                var tachePlus = document.getElementById("VoirPlusTache");
                var buttons = document.getElementsByTagName("button");
                var vptOffButton = document.getElementById("VPTOff");

                if (tachePlus.style.display === "block") {
                    tachePlus.style.display = "none";

                    for (var i = 0; i < buttons.length; i++) {
                        if (buttons[i] != vptOffButton) {
                            buttons[i].disabled = false;
                        }
                    }

                } else {
                    tachePlus.style.display = "block";

                    for (var i = 0; i < buttons.length; i++) {
                        if (buttons[i] != vptOffButton) {
                            buttons[i].disabled = true;
                        }
                    }

                    fetchTache(TACHE);
                }
            }

            function fetchTache(TACHE) {
                $.ajax({
                    url: "php.php",
                    type: "GET",
                    data: {
                        action: "getTache",
                        ID_TCH: TACHE,
                        CREATOR: null,
                        NOM: null,
                        DAY: null,
                        CAT: null,
                        ACTIF: null,
                        MESTACHES: null
                    },
                    success: function(data) {
                        var Tache = JSON.parse(data);
                        $.ajax({
                            url: 'php.php',
                            type: 'GET',
                            data: {
                                action: "getUser",
                                ID_COM: Tache[0].CREATOR,
                                MAIL: null,
                                MDP: null,
                                ADMIN: null
                            },
                            success: function(userData) {
                                var Creator = JSON.parse(userData);
                                var creatorInfo = Creator[0].NOM + " " + Creator[0].PRENOM;

                                $.ajax({
                                    url: 'php.php',
                                    type: 'GET',
                                    data: {
                                        action: "getCat",
                                        ID_CAT: Tache[0].CAT
                                    },
                                    success: function(categoryData) {
                                        var category = JSON.parse(categoryData);
                                        $('#VoirPlusTache').empty();

                                        var TacheDataHtml = "<button id='VPTOff' onclick=toggleTache(null)>X</button>";
                                        TacheDataHtml += "<p>Titre: " + Tache[0].NOM + "</p>" +
                                            "<p>Categorie: " + category[0].NOM + "</p>" +
                                            "<span>Date/Createur: " + Tache[0].DAY + " / " + creatorInfo + "</span>" +
                                            "<p>Description: " + Tache[0].DESCRIPTION + "</p>";
                                        if (Tache[0].ID_COM == 1) {
                                            TacheDataHtml += "<p>TERMINE</p>";
                                        } else {
                                            TacheDataHtml += "<p>A COMPLETER</p>";
                                        }

                                        $.ajax({
                                            url: 'php.php',
                                            type: 'GET',
                                            data: {
                                                action: "getFil",
                                                TACHE: Tache[0].ID_TCH,
                                            },
                                            success: function(FilData) {
                                                var Fils = JSON.parse(FilData);
                                                if (Fils && Fils.length > 0) {
                                                    Fils.forEach(function(Fil) {
                                                        $.ajax({
                                                            url: 'php.php',
                                                            type: 'GET',
                                                            data: {
                                                                action: "getUser",
                                                                ID_COM: Fil.CREATOR,
                                                                MAIL: null,
                                                                MDP: null,
                                                                ADMIN: null
                                                            },
                                                            success: function(filCreatorData) {
                                                                var filCreator = JSON.parse(filCreatorData);
                                                                var filCreatorInfo = filCreator[0].NOM + " " + filCreator[0].PRENOM;

                                                                $.ajax({
                                                                    url: 'php.php',
                                                                    type: 'GET',
                                                                    data: {
                                                                        action: "getCommentaire",
                                                                        ID_FIL: Fil.ID_FIL,
                                                                        MAIL: null,
                                                                        MDP: null,
                                                                    },
                                                                    success: function(DataComm) {
                                                                        var Comms = JSON.parse(DataComm);
                                                                        var commentsDivId = "comments-" + Fil.ID_FIL; 
                                                                        if (Comms && Comms.length > 0) {
                                                                            Comms.forEach(function(Comm) {
                                                                                var commentsHtml = "";
                                                                                $.ajax({
                                                                                    url: 'php.php',
                                                                                    type: 'GET',
                                                                                    data: {
                                                                                        action: "getUser",
                                                                                        ID_COM: Comm.CREATOR,
                                                                                        MAIL: null,
                                                                                        MDP: null,
                                                                                        ADMIN: null
                                                                                    },
                                                                                    success: function(commentCreatorData) {
                                                                                        var commentCreator = JSON.parse(commentCreatorData);
                                                                                        var commentCreatorInfo = commentCreator[0].NOM + " " + commentCreator[0].PRENOM;

                                                                                        commentsHtml += "<li>" + Comm.COMM + " - " + commentCreatorInfo + " - " + Comm.DAY;
                                                                                        if (Tache[0].ACTIF == 1 && Tache[0].CREATOR == <?php echo $Id_Compte; ?>) {
                                                                                            commentsHtml += "<button onclick='deleteComm(" + Tache[0].ID_TCH + "," + Comm.ID_CMT + ")'>Supprimer Comm</button>";
                                                                                        }
                                                                                        commentsHtml += "</li>";
                                                                                        $("#" + commentsDivId).append(commentsHtml);
                                                                                    },
                                                                                    error: function(xhr, status, error) {
                                                                                        console.log(error);
                                                                                    }
                                                                                });
                                                                            });
                                                                        } else {
                                                                            $("#" + commentsDivId).append("Pas de Commentaire.");
                                                                        }

                                                                        var TacheDataHtmlB = "<div class='fil'>" +
                                                                            "<span>" + Fil.NOM + " - " + filCreatorInfo + " - " + Fil.DAY + "</span>" +
                                                                            "<button onclick='afficherCommentaires(this)'>Commentaires</button>";
                                                                            TacheDataHtmlB += "<div id='comments-" + Fil.ID_FIL + "' class='comments' style='display: none;'>";
                                                                            TacheDataHtmlB += "<form class='newCommentaireForm' onsubmit='addComm(" + Tache[0].ID_TCH + ", " + Fil.ID_FIL + "," + <?php echo $Id_Compte; ?> +")'>" +
                                                                                        "<input type='text' name='newComment' placeholder='New Commentaire' required>" +
                                                                                        "<button type='submit'>Nouveau Commentaire</button>" +
                                                                                        "</form></div></div>";
                                                                        if (Tache[0].ACTIF == 1 && Tache[0].CREATOR == <?php echo $Id_Compte; ?>) {
                                                                            TacheDataHtmlB += "<button onclick='deleteFil(" + Tache[0].ID_TCH + "," + Fil.ID_FIL + ")'>Supprimer Fil</button>";
                                                                        }

                                                                        $('#VoirPlusTache').append(TacheDataHtmlB);
                                                                    },
                                                                    error: function(xhr, status, error) {
                                                                        console.log(error);
                                                                    }
                                                                });
                                                            },
                                                            error: function(xhr, status, error) {
                                                                console.log(error);
                                                            }
                                                        });
                                                    });
                                                }
                                                $('#VoirPlusTache').append(TacheDataHtml);
                                                var newFilFormHtml = "<form class='newFilForm' onsubmit='addFil(" + Tache[0].ID_TCH + "," + <?php echo $Id_Compte; ?> + ")'>" +
                                                                            "<input type='text' name='newFilName' placeholder='New Fil' required>" +
                                                                            "<button type='submit'>Nouveau Fil</button>" +
                                                                            "</form>";
                                                $(newFilFormHtml).appendTo('#VoirPlusTache');
                                            },
                                            error: function(xhr, status, error) {
                                                console.log(error);
                                            }
                                        });
                                    },
                                    error: function(xhr, status, error) {
                                        console.log(error);
                                    }
                                });
                            },
                            error: function(xhr, status, error) {
                                console.log(error);
                            }
                        });
                    },
                    error: function() {
                        console.log("Erreur fonction Ajax.");
                    }
                });
            }

            function addFil(ID_TCH, ID_COM) {
                event.preventDefault(); 

                var newFilName = $('.newFilForm input[name="newFilName"]').val();

                $.ajax({
                    url: 'php.php',
                    type: 'GET',
                    data: {
                        action: 'addFil',
                        CREATOR: ID_COM,
                        TACHE: ID_TCH,
                        NOM: newFilName
                    },
                    success: function(response) {
                        console.log(response)
                        fetchTache(ID_TCH);
                    },
                    error: function(xhr, status, error) {
                        console.log(error);
                    }
                });
            }
            function deleteFil(ID_TCH, ID_FIL){
                $.ajax({
                    url: "php.php",
                    type: "GET",
                    data: {
                        action: "deleteFil",
                        ID_FIL: ID_FIL,
                    },
                    success: function(data) {
                        console.log(data)
                        fetchTache(ID_TCH);
                    },
                    error: function() {
                        console.log("Erreur fonction Ajax.");
                    }
                });
            }

            function addComm(ID_TCH, ID_FIL, ID_COM) {
                event.preventDefault(); 

                var newComment = $('.newCommentaireForm input[name="newComment"]').val();

                $.ajax({
                    url: 'php.php',
                    type: 'GET',
                    data: {
                        action: 'addCommentaire',
                        CREATOR: ID_COM,
                        FIL: ID_FIL,
                        COMM: newComment
                    },
                    success: function(response) {
                        console.log(response)
                        fetchTache(ID_TCH);
                    },
                    error: function(xhr, status, error) {
                        console.log(error);
                    }
                });
            }
            function deleteComm(ID_TCH, ID_CMT){
                $.ajax({
                    url: "php.php",
                    type: "GET",
                    data: {
                        action: "deleteCommentaire",
                        ID_CMT: ID_CMT,
                    },
                    success: function(data) {
                        console.log(data)
                        fetchTache(ID_TCH);
                    },
                    error: function() {
                        console.log("Erreur fonction Ajax.");
                    }
                });
            }

            function update(TACHE) {
                $.ajax({
                    url: "php.php",
                    type: "GET",
                    data: {
                        action: "getTache",
                        ID_TCH: TACHE,
                        CREATOR: null,
                        NOM: null,
                        DAY: null,
                        CAT: null,
                        ACTIF: null,
                        MESTACHES: null
                    },
                    success: function(data) {
                        var Tache = JSON.parse(data);
                        window.location.href = "update.php?ID_TCH=" + Tache[0].ID_TCH;
                    },
                    error: function() {
                        console.log("Erreur fonction Ajax.");
                    }
                });
            }
            function add() {
                var ID_COM = <?php echo $Id_Compte; ?>; 
                window.location.href = "addtch.php?ID_COM=" + ID_COM;
            }

            function afficherCommentaires(button) {
                var commentsDiv = button.nextElementSibling;
                if (commentsDiv.style.display === "block") {
                    commentsDiv.style.display = "none";
                } else {
                    commentsDiv.style.display = "block";
                }
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
                    <option value="">Tous</option>
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
            <div id="main">
                <?php
                    echo "<p>Tâches trouvées</p>";
                ?>
                <button onclick=add() class="button-add">Ajouter une tâche</button>
            </div>
            <div class="grid">
                <div id="tachessearch">
                </div>
            </div>
        </div>
        <div id="notification" class="notification"></div>
        <div id="VoirPlusTache" class="VoirPlusTache"></div>
    </body>
    <?php
        //session_write_close();

        //session_destroy();
        closeConn()
    ?>
</html>