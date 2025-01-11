<?php
    if (isset($_GET['source'])) die(highlight_file(__FILE__, 1));
    // Start the session
    session_start();

    $conn = null;

    function DBServer(){
        global $conn;
        if ($conn == null){
            $servername = "www-ens";
            $username = "labattes";
            $password = "lab....L";
            $dbname = "labattes_web_deRyckLabatte";
    
            // Create conn
            $conn = new mysqli($servername, $username, $password, $dbname);
            if ($conn->connect_error) {
                die ("conn failed: " . $conn->connect_error);
            }
        }
    }

    function closeConn(){
        global $conn;
        if ($conn != null){        
            $conn->close();
        }

    }



    function foreignKeyExists($conn, $tableName, $foreignKeyName) {
        if ($conn != null) {
            $query = "SELECT CONSTRAINT_NAME
                FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
                WHERE TABLE_NAME = '$tableName' AND CONSTRAINT_SCHEMA = DATABASE() AND CONSTRAINT_NAME = '$foreignKeyName'";
            $result = $conn->query($query);
            return ($result->num_rows > 0);
        }
        return false;
    }
    function updateDB() {
        global $conn;
        if ($conn != null) {
            $tables = array(
                'NOTIFICATION' => 'FK_NOTIFICATION_ID_COM',
                'TACHE' => 'FK_TACHE_CREATOR',
                'FIL' => 'FK_FIL_CREATOR',
                'FIL' => 'FK_FIL_TACHE',
                'COMMENTAIRE' => 'FK_COMMENTAIRE_CREATOR',
                'COMMENTAIRE' => 'FK_COMMENTAIRE_FIL'
            );
    
            foreach ($tables as $tableName => $foreignKeyName) {
                if (!foreignKeyExists($conn, $tableName, $foreignKeyName)) {
                    $query = "DROP TABLE IF EXISTS $tableName";
                    $conn->query($query);
                }
            }
            if (!foreignKeyExists($conn, 'TACHE', 'FK_TACHE_CAT')) {
                $query = "UPDATE TACHE SET CAT = NULL";
                $conn->query($query);
            }
        }
    }




    

    function getUser($ID_COM, $MAIL, $MDP){
        global $conn;
        DBServer();
        if ($conn != null) {
            if (!isset($ID_COM) && (empty($MAIL) || !isset($MAIL))) {
                return null;
            }
            $conds = 0;
            $requestUser = "SELECT * FROM COMPTE";
            
            if (!empty($ID_COM) && isset($ID_COM)) {
                $conds ++;
                if ($conds == 1){
                    $requestUser .= " WHERE";
                }
                else{
                    $requestUser .= " AND";
                }
                $requestUser .= " ID_COM = '$ID_COM'";
            }
            if (!empty($MAIL) && isset($MAIL)) {
                $conds ++;
                if ($conds == 1){
                    $requestUser .= " WHERE";
                }
                else{
                    $requestUser .= " AND";
                }
                $requestUser .= " MAIL = '$MAIL'";
            }
            if (!empty($MDP) && isset($MDP)) {
                $conds ++;
                if ($conds == 1){
                    $requestUser .= " WHERE";
                }
                else{
                    $requestUser .= " AND";
                }
                $requestUser .= " MDP = '$MDP'";
            }
            if ((!empty($ADMIN) && isset($ADMIN)) || $ADMIN = 0) {
                $conds ++;
                if ($conds == 1){
                    $requestUser .= " WHERE";
                }
                else{
                    $requestUser .= " AND";
                }
                $requestUser .= " ADMIN = '$ADMIN'";
            }
            
            $result = $conn->query($requestUser);
            
            if ($result->num_rows > 0) {
                return $result->fetch_all(MYSQLI_ASSOC);
            } else {
                return null;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'getUser') {
        $ID_COM = $_GET['ID_COM'];
        $MAIL = $_GET['MAIL'];
        $MDP = $_GET['MDP'];
        $ADMIN = $_GET['ADMIN'];
        $result = getUser($ID_COM, $MAIL, $MDP, $ADMIN);
        echo json_encode($result);
    }

    function addUser($MAIL, $MDP, $PHONE, $NAME, $SURNAME){
        global $conn;
        if ($conn != null){ 
            $PHONEVALUE = !empty($PHONE) ? $PHONE: "NULL";
            $sql = "INSERT INTO COMPTE (MAIL,MDP,TEL,NOM,PRENOM,ADMIN) VALUES
            ('$MAIL', '$MDP', '$PHONEVALUE', '$NAME', '$SURNAME', False)";
            if ($conn->query($sql)) {
                return getUser(null, $MAIL, $MDP);
            } else {
                return null;
            }
        }
    }

    function deleteUser($ID_COM) {
        global $conn;
        if ($conn != null){ 
            $sql = "DELETE FROM COMPTE WHERE ID_COM = $ID_COM";
            if ($conn->query($sql) === TRUE) {
                echo "Compte Supprimé";
            } else {
                echo "Erreur Suppression : " . $conn->error;
            }
            //updateDB();
        }
    }

    function updateUser($ID_COM, $MAIL, $MDP, $TEL, $NOM, $PRENOM, $ADMIN){
        global $conn;
        DBServer();
        if ($conn != null){ 
            $query = "UPDATE COMPTE SET ";
            $updates = array();

            if (!empty($MAIL) && isset($MAIL)) {
                $updates[] = "MAIL = '$MAIL'";
            }
            if (!empty($MDP) && isset($MDP)) {
                $updates[] = "MDP = '$MDP'";
            }
            if (!empty($TEL) && isset($TEL)) {
                $updates[] = "TEL = '$TEL'";
            }
            if (!empty($NOM) && isset($NOM)) {
                $updates[] = "NOM = '$NOM'";
            }
            if (!empty($PRENOM) && isset($PRENOM)) {
                $updates[] = "PRENOM = '$PRENOM'";
            }
            if (isset($ADMIN)|| $ADMIN == 0) {
                $updates[] = "ADMIN = " . ($ADMIN ? 1 : 0);
            }
            if($ADMIN == null){
                createNotif(null, $ID_COM, "update");
            }
            else{
                createNotif(null, $ID_COM, "admin");
            }

            $query .= implode(", ", $updates);
            $query .= " WHERE ID_COM = $ID_COM";

            if ($conn->query($query) === TRUE) {
                echo "Compte updated successfully";
            } else {
                echo "Error updating : " . $conn->error;
            }
        } 
    }
    if (isset($_GET['action']) && $_GET['action'] === 'updateUser') {
        $ID_COM = $_GET['ID_COM'];
        $MAIL = $_GET['MAIL'];
        $MDP = $_GET['MDP'];
        $TEL = $_GET['TEL'];
        $NOM = $_GET['NOM'];
        $PRENOM = $_GET['PRENOM'];
        $ADMIN = $_GET['ADMIN'];
        $result = updateUser($ID_COM, $MAIL, $MDP, $TEL, $NOM, $PRENOM, $ADMIN);
        echo ($result);
    }







    function getTache($ID_TCH, $CREATOR, $NOM, $DAY, $CAT, $ACTIF, $MESTACHES){
        global $conn;
        DBServer();
        if ($conn != null){
            $conds = 0;
            $requestGetTache = "SELECT * FROM TACHE"; 

            if (!empty($ID_TCH) && isset($ID_TCH)) {
                $conds ++;
                if ($conds == 1){
                    $requestGetTache .= " WHERE";
                }
                else{
                    $requestGetTache .= " AND";
                }
                $requestGetTache .= " ID_TCH = $ID_TCH";
            }
            if (!empty($CREATOR) && isset($CREATOR)) {
                $conds ++;
                if ($conds == 1){
                    $requestGetTache .= " WHERE";
                }
                else{
                    $requestGetTache .= " AND";
                }
                $creatorCondition = $MESTACHES ? "= $CREATOR" : "!= $CREATOR";
                $requestGetTache .= " CREATOR $creatorCondition";
            }
            if (!empty($NOM) && isset($NOM)) {
                $conds ++;
                if ($conds == 1){
                    $requestGetTache .= " WHERE";
                }
                else{
                    $requestGetTache .= " AND";
                }
                $requestGetTache .= " NOM = '$NOM'";
            }
            if (!empty($DAY) && isset($DAY)) {
                $conds ++;
                if ($conds == 1){
                    $requestGetTache .= " WHERE";
                }
                else{
                    $requestGetTache .= " AND";
                }
                $requestGetTache .= " DAY = '$DAY'";
            }
            if (!empty($CAT) && isset($CAT)) {
                $conds ++;
                if ($conds == 1){
                    $requestGetTache .= " WHERE";
                }
                else{
                    $requestGetTache .= " AND";
                }
                $requestGetTache .= " CAT = '$CAT'";
            }
            if ((!empty($ACTIF) && isset($ACTIF)) || $ACTIF == 0) {
                $conds++;
                if ($conds == 1) {
                    $requestGetTache .= " WHERE";
                } else {
                    $requestGetTache .= " AND";
                }
                $ActifCond = ($ACTIF == 1) ? 1 : 0;
                $requestGetTache .= " ACTIF = $ActifCond";
            }

            $result = $conn->query($requestGetTache);
            
            if ($result->num_rows > 0) {
                return $result->fetch_all(MYSQLI_ASSOC);
            } else {
                return null;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'getTache') {
        $ID_TCH = $_GET['ID_TCH'];
        $CREATOR = $_GET['CREATOR'];
        $NOM = $_GET['NOM'];
        $DAY = $_GET['DAY'];
        $CAT = $_GET['CAT'];
        $ACTIF = $_GET['ACTIF'];
        $MESTACHES = $_GET['MESTACHES'];
        $result = getTache($ID_TCH, $CREATOR, $NOM, $DAY, $CAT, $ACTIF, $MESTACHES);
        echo json_encode($result);
    }

    function addTache($ID_COMPTE, $NOM, $CAT, $DESCRIPTION) {
        global $conn;
        DBServer();
        if ($conn != null){
            $timestamp = date("Y-m-d");
            $sql = "INSERT INTO TACHE (CREATOR, NOM, DAY, CAT, DESCRIPTION, ACTIF) VALUES ('$ID_COMPTE', '$NOM', '$timestamp', '$CAT', '$DESCRIPTION', True)";
            if ($conn->query($sql) === TRUE) {
                echo "Tache Crée";
            } else {
                echo "Erreur lors de la creation de la tache: " . $conn->error;
            }
        }
    }

    function deleteTache($ID_TCH) {
        global $conn;
        DBServer();
        if ($conn != null){
            $sql = "DELETE FROM TACHE WHERE ID_TCH = $ID_TCH";
            createNotif($ID_TCH, null, "delete");
            if ($conn->query($sql) === TRUE) {
                //updateDB();
                return "Tache Supprimée";
            } else {
                return "Erreur lors de la suppression de l tache: " . $conn->error;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'deleteTache') {
        $ID_TCH = $_GET['ID_TCH'];
        $result = deleteTache($ID_TCH);
        echo $result;
    }

    function updateTache($ID_TCH, $NOM, $CAT, $DESCRIPTION, $ACTIF){
        global $conn;
        if ($conn != null){ 
            $query = "UPDATE TACHE SET ";
            $updates = array();

            if (!empty($NOM) || isset($NOM)) {
                $updates[] = "NOM = '$NOM'";
            }
            if (!empty($CAT) || isset($CAT)) {
                $updates[] = "CAT = '$CAT'";
            }
            if (!empty($DESCRIPTION) || isset($DESCRIPTION)) {
                $updates[] = "DESCRIPTION = '$DESCRIPTION'";
            }
            if (isset($ACTIF)) {
                $updates[] = "ACTIF = " . ($ACTIF ? "TRUE" : "FALSE");
            }

            $query .= implode(", ", $updates);
            $query .= " WHERE ID_TCH = $ID_TCH";

            // Execute the SQL query
            createNotif($ID_TCH, null, "update");
            if ($conn->query($query) === TRUE) {
                echo "Tache updated successfully";
            } else {
                echo "Error updating Tache : " . $conn->error;
            }
        } 
    }







    function getNotif($ID_COM) {
        global $conn;
        DBServer();
        if ($conn != null){        
            $notifGet = "SELECT * FROM NOTIFICATION WHERE ID_COM = $ID_COM";
            $result = $conn->query($notifGet);
            if ($result->num_rows > 0) {
                return $result->fetch_all(MYSQLI_ASSOC);
            } else {
                return null;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'getNotif') {
        $ID_COM = $_GET['ID_COM'];
        $result = getNotif($ID_COM);
        echo json_encode($result);
    }

    function addNotif($ID_COM, $MESSAGE) {
        global $conn;
        echo $ID_COM;
        echo $MESSAGE;
        if ($conn != null){ 
            $sql = "INSERT INTO NOTIFICATION (ID_COM,MESSAGE) VALUES ('$ID_COM', '$MESSAGE')";
            echo $sql;
            if ($conn->query($sql) === TRUE) {
                return "Notification Created successfully";
            } else {
                echo "false";
                return "Error Creation Notification : " . $conn->error;
            }
        }
    }
    function deleteNotif($ID_NOTIF) {
        global $conn;
        DBServer();
        if ($conn != null){ 
            $sql = "DELETE FROM NOTIFICATION WHERE ID_NOTIF = $ID_NOTIF";
            if ($conn->query($sql) === TRUE) {
                return "Notification Deleted successfully";
            } else {
                return "Error Delete  Notification : " . $conn->error;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'deleteNotif') {
        $ID_COM = $_GET['ID_COM'];
        $result = deleteNotif($ID_COM);
        echo $result;
    }



    function getFil($TACHE) {
        global $conn;
        DBServer();
        if ($conn != null){
            $requestTache = "SELECT * FROM FIL WHERE TACHE = $TACHE";
            $result = $conn->query($requestTache);
            if ($result->num_rows > 0){
                return $result->fetch_all(MYSQLI_ASSOC);
            }
            else{
                return null;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'getFil') {
        $TACHE = $_GET['TACHE'];
        $result = getFil($TACHE);
        echo json_encode($result);
    }
    function addFil($CREATOR, $TACHE, $NOM) {
        global $conn;
        DBServer();
        if ($conn != null){ 
            $timestamp = date("Y-m-d");
            $sql = "INSERT INTO FIL (CREATOR,TACHE,NOM, DAY) VALUES ('$CREATOR', '$TACHE', '$NOM', '$timestamp')";
            if ($conn->query($sql) === TRUE) {
                echo "Fil Created successfully";
            } else {
                echo "Error Creation Fil : " . $conn->error;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'addFil') {
        $CREATOR = $_GET['CREATOR'];
        $TACHE = $_GET['TACHE'];
        $NOM = $_GET['NOM'];
        $result = addFil($CREATOR, $TACHE, $NOM);
        echo ($result);
    }
    function deleteFil($ID_FIL) {
        global $conn;
        DBServer();
        if ($conn != null){ 
            $sql = "DELETE FROM FIL WHERE ID_FIL = $ID_FIL";
            if ($conn->query($sql) === TRUE) {
                echo "Fil Deleted successfully";
            } else {
                echo "Error Delete FIL : " . $conn->error;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'deleteFil') {
        $ID_FIL = $_GET['ID_FIL'];
        $result = deleteFil($ID_FIL);
        echo ($result);
    }


    function getCommentaire($FIL) {
        global $conn;
        DBServer();
        if ($conn != null){
            $requestTache = "SELECT * FROM COMMENTAIRE WHERE FIL = $FIL";
            $result = $conn->query($requestTache);
            if ($result->num_rows > 0){
                return $result->fetch_all(MYSQLI_ASSOC);
            }
            else{
                return null;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'getCommentaire') {
        $ID_FIL = $_GET['ID_FIL'];
        $result = getCommentaire($ID_FIL);
        echo json_encode($result);
    }
    function addCommentaire($CREATOR, $FIL, $COMM) {
        global $conn;
        DBServer();
        if ($conn != null){ 
            $timestamp = date("Y-m-d");
            $sql = "INSERT INTO COMMENTAIRE (CREATOR,FIL,COMM, DAY) VALUES ('$CREATOR', '$FIL', '$COMM', '$timestamp')";
            if ($conn->query($sql) === TRUE) {
                echo "Commentaire Created successfully";
            } else {
                echo "Error Creation Commentaire : " . $conn->error;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'addCommentaire') {
        $CREATOR = $_GET['CREATOR'];
        $FIL = $_GET['FIL'];
        $COMM = $_GET['COMM'];
        $result = addCommentaire($CREATOR, $FIL, $COMM);
        echo ($result);
    }
    function deleteCommentaire($ID_CMT) {
        global $conn;
        DBServer();
        if ($conn != null){ 
            $sql = "DELETE FROM COMMENTAIRE WHERE ID_CMT = $ID_CMT";
            if ($conn->query($sql) === TRUE) {
                echo "Commentaire Deleted successfully";
            } else {
                echo "Error Delete Commentaire : " . $conn->error;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'deleteCommentaire') {
        $ID_CMT = $_GET['ID_CMT'];
        $result = deleteCommentaire($ID_CMT);
        echo ($result);
    }




    function getCat($ID_CAT){
        global $conn;
        DBServer();
        if ($conn != null){ 
            $sql = "SELECT * FROM CAT";
            if (!empty($ID_CAT) && isset($ID_CAT)) {
                $sql .= " WHERE ID_CAT = $ID_CAT";
            }
            $result = $conn->query($sql);
            if ($result->num_rows > 0){
                return $result->fetch_all(MYSQLI_ASSOC);
            } else {
                return null;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'getCat') {
        $ID_CAT = $_GET['ID_CAT'];
        $result = getCat($ID_CAT);
        echo json_encode($result);
    }
    function addCat($NOM){
        global $conn;
        DBServer();
        if ($conn != null){ 
            $sql = "INSERT INTO CAT (NOM) VALUES ('$NOM')";
            if ($conn->query($sql) === TRUE) {
                echo "Categorie Created successfully";
            } else {
                echo "Error Creation Categorie : " . $conn->error;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'addCat') {
        $NOM = $_GET['NOM'];
        $result = addCat($NOM);
        echo $result;
    }
    function deleteCat($ID_CAT){
        global $conn;
        DBServer();
        if ($conn != null){ 
            $sql = "DELETE FROM CAT WHERE ID_CAT = $ID_CAT";
            if ($conn->query($sql) === TRUE) {
                echo "Categorie Deleted successfully";
            } else {
                echo "Error Delete Categorie : " . $conn->error;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'deleteCat') {
        $ID_CAT = $_GET['ID_CAT'];
        $result = deleteCat($ID_CAT);
        echo $result;
    }



    function setTache($ID_TCH){
        $_SESSION["Tache"] = $ID_TCH;
        return "Tache";
    }
    if (isset($_GET['action']) && $_GET['action'] === 'setTache') {
        $ID_TCH = $_GET['ID_TCH'];
        $result = setTache($ID_TCH);
        echo $result;
    }





    function addFollow($ID_TCH, $ID_COM){
        global $conn;
        DBServer();
        if ($conn != null){ 
            $sql = "INSERT INTO FOLLOW (ID_TCH, ID_COM) VALUES ('$ID_TCH', '$ID_COM')";

            createNotif($ID_TCH, $ID_COM, "follow");
            if ($conn->query($sql) === TRUE) {
                echo "follow Created successfully";
            } else {
                echo "Error Creation follow : " . $conn->error;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'addFollow') {
        $ID_TCH = $_GET['ID_TCH'];
        $ID_COM = $_GET['ID_COM'];
        $result = addFollow($ID_TCH, $ID_COM);
        echo $result;
    }
    function deleteFollow($ID_TCH, $ID_COM){
        global $conn;
        DBServer();
        if ($conn != null){ 
            $sql = "DELETE FROM FOLLOW WHERE ID_TCH = $ID_TCH AND ID_COM = $ID_COM";
            createNotif($ID_TCH, $ID_COM, "unfollow");
            if ($conn->query($sql) === TRUE) {
                echo "follow Deleted successfully";
            } else {
                echo "Error Delete follow : " . $conn->error;
            }
        }
    }
    if (isset($_GET['action']) && $_GET['action'] === 'deleteFollow') {
        $ID_TCH = $_GET['ID_TCH'];
        $ID_COM = $_GET['ID_COM'];
        $result = deleteFollow($ID_TCH, $ID_COM);
        echo $result;
    }

    function createNotif($ID_TCH, $ID_COM, $ACTION) {
        global $conn;
        if ($conn != null) {
            if (isset($ID_TCH)) {
                if ($ACTION == "update" || $ACTION == "delete") {
                    $sql = "SELECT FOLLOW.ID_COM, TACHE.NOM
                                FROM FOLLOW
                                JOIN TACHE ON FOLLOW.ID_TCH = TACHE.ID_TCH
                                WHERE FOLLOW.ID_TCH = $ID_TCH";
                    $result = $conn->query($sql);
                    if ($result->num_rows > 0) {
                        while ($row = $result->fetch_assoc()) {
                            return addNotif($row["ID_COM"], "la tache " . $row["NOM"] . " a ete $ACTION.");
                        }
                    } else {
                        echo "Error finding user for notification: " . $conn->error;
                    }
                }
                else if ($ACTION == "follow" || $ACTION == "unfollow") {
                    $sql = "SELECT * FROM TACHE WHERE ID_TCH = $ID_TCH";
                    $result = $conn->query($sql);
                    if ($result->num_rows > 0) {
                        $row = $result->fetch_assoc();
                        return addNotif($ID_COM, "Vous avez bien $ACTION la tache " . $row["NOM"] . ".");
                    } else {
                        echo "Error creating follow notification: " . $conn->error;
                    }
                }
            } else {
                echo "1";
                if ($ACTION == "update") {
                    return addNotif($ID_COM, "Vous avez bien mis a jour votre Compte.");
                } else if ($ACTION == "admin") {
                    return addNotif($ID_COM, "Votre compte a change de status.");
                }
            }
        }
    }


    if (isset($_POST['action'])) {
        $action = $_POST['action'];

        if ($action === "getHash") {
            $currentPassword = $_POST["currentPassword"];
            $newPassword = $_POST["newPassword"];
            $confirmPassword = $_POST["confirmPassword"];

            $hashedCurrentPassword = hash('sha512', $currentPassword);
            $hashedNewPassword = hash('sha512', $newPassword);
            $hashedConfirmPassword = hash('sha512', $confirmPassword);

            $response = array(
                $hashedCurrentPassword,
                $hashedNewPassword,
                $hashedConfirmPassword
            );

            echo json_encode($response);
            exit();
        }
    }

?>