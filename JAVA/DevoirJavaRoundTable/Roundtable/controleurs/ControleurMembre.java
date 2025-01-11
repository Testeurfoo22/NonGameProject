package controleurs;
import java.util.Scanner;
import controleurs.activites.ControleurArticle;
import controleurs.activites.ControleurProjet;
import controleurs.activites.ControleurOutil;
import entites.Interet;
import entites.activites.Article;
import entites.activites.Outil;
import entites.activites.Projet;
import entites.utilisateurs.Membre;
import entites.utilisateurs.Role;

import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime; 

import java.util.ArrayList;
import java.util.List;


public class ControleurMembre {
    public static Scanner scanner = new Scanner(System.in);

    public static List<Membre> listeMembre = new ArrayList<>();
    public static List<Membre> listeMembreAttente = new ArrayList<>();

    public static boolean init = true;

    public static void creationInitMembre(){
        if (init){
            init = false;
            listeMembre.add(new Membre(11, "Famelis", "Michalis", "famelis@iro.umontreal.ca", "qwerty", "", "514-343-6111", "WebSite", "Titre", null, Role.listeRole.get(1),
            "Actif", new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), false));

            listeMembre.add(new Membre(12, "Syriani", "Eugene", "syriani@iro.umontreal.ca", "qwerty", "", "+1 (514) 343-6111", "website", "Titre", null, Role.listeRole.get(1),
            "Actif", new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), false));

            listeMembre.add(new Membre(13, "Sahraoui", "Houari", "sahraoui@iro.umontreal.ca", "qwerty", "", "(514) 343-5746", "website", "Titre", null, Role.listeRole.get(1),
            "Actif", new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), false));
            
            listeMembre.add(new Membre(14, "Lafontant", "Louis-Edouard", "louis.edouard.lafontant@umontreal.ca", "qwerty", "", "xxx-xxx-xxxx", "website", "Titre", null, Role.listeRole.get(2),
            "Actif", new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), false));

            listeMembre.add(new Membre(15, "Istvan", "David", "istvan.david@umontreal.ca", "qwerty", "", "xxx-xxx-xxxx", "website", "Titre", null, Role.listeRole.get(2),
            "Actif", new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), false));

            listeMembre.add(new Membre(16, "de Ryck", "Hadrien", "hadrien.de.ryck@umontreal.ca", "qwerty", "", "+33 6 52 55 81 22", "", "Titre", null, Role.listeRole.get(0),
            "Actif", new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), false));
        }
    }

    public static void newMember(){
        System.out.println("merci de remplir vos Informations : \n");
        System.out.print("Votre Nom : ");
        String Nom = textCreator(0, 50);
        System.out.print("Votre Prenom : ");
        String Prenom = textCreator(0, 50);
        System.out.print("Votre Titre (Maitrise, Doctorat, PostDoc, Professeur) : ");
        String Titre = scanner.nextLine();
        Membre superviseur = findmembre("Professeur/ Superviseur ");
        String MailUni = "";
        while (true){
            System.out.print("Votre Mail Universitaire : ");
            MailUni = scanner.nextLine();
            if (checkMailUni(MailUni)){
                break;
            }
            else {
                System.out.print("Mail deja utilise -> ");
            }
        }
        System.out.print("Votre Mdp : ");
        String Mdp = mdpCreator();
        while (true){
            System.out.print("Confirmez Votre Mdp : ");
            if (Mdp.equals(mdpCreator())){
                break;
            }
            else {
                System.out.print("Mdp Errone: ");
            }
        }
        System.out.print("Votre Tel : ");
        String Tel = textCreator(10, 15);
        System.out.print("Website : ");
        String WebSite = scanner.nextLine();
        System.out.println("");
        List<Interet> listeInteret = ControleurInteret.creationListeInteret();
        List<Projet> listeProjet = new ArrayList<>();
        List<Outil> listeOutil = new ArrayList<>();
        List<Article> ListeArticle = new ArrayList<>();
        List<String> notif = new ArrayList<>();
        System.out.print("Voulez-vous confirmer? Y ou N : ");
        String reponse = scanner.nextLine();
        switch(reponse){
            case "Y" : {
                listeMembreAttente.add(new Membre(Integer.parseInt(Integer.toString(1) + Integer.toString(listeMembre.size() + 1)), Nom, Prenom, MailUni, Mdp, "",
                Tel, WebSite, Titre, superviseur, Role.listeRole.get(2), "Attente", listeInteret, listeProjet, 
                    listeOutil, ListeArticle, notif, false));
                for (int x = 0; x < listeMembre.size(); x++){
                    if (listeMembre.get(x).Role.equals(Role.listeRole.get(2))){
                        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                        LocalDateTime now = LocalDateTime.now(); 
                        ControleurMembre.listeMembre.get(x).notif.add
                            (Nom  + " " + dtf.format(now) + " il y a une nouvelle demande de creation de compte.");
                    }
                }
                System.out.println
                    ("Votre demande a ete prise en compte, vous recevrez une reponse apres examination.");
                break;
            }        
            case "N" : System.out.println
                ("Votre demande a ete prise en compte, votre demande a ete annulee.");break;
            default : {
                System.out.println("Erreur de reponse, la demande est annulee");
            }
        }
    }

    public static void ajoutMembre(){
        if (! listeMembreAttente.isEmpty()){
            for (int x = 0; x < listeMembreAttente.size(); x++){
                boolean pass = false;
                affichagemembreCompletAjout(" ||  ", listeMembreAttente.get(x));
                System.out.print(" ||  Voulez-vous accepter cette personne? Yes, No ou Passe, Retour pour quitter la gestion \n Reponse -> ");
                String reponse = scanner.nextLine();
                switch(reponse){
                    case "Yes" : {
                        listeMembreAttente.get(x).Statut = "Actif";
                        listeMembre.add(listeMembreAttente.get(x));
                        listeMembreAttente.remove(x);
                        System.out.println(" ||  la demande a ete accepte.");
                        /*envoie un mail */
                    } ; break;
                    case "No" : {
                        listeMembreAttente.remove(x);
                        System.out.println(" ||  la demande a ete rejete.");
                        /*envoie un mail */
                    }; break;
                    case "Passe" : {
                        System.out.println(" ||  la demande a ete passe.");
                    }; break;
                    case "Retour" : {
                        pass = true;
                        System.out.println(" ||  Vous quittez la gestion de membre.");
                        break;
                    }
                    default :{
                        System.out.println(" ||  Cette action n'est pas valable, la demande a ete passe.");
                    }
                }
                if (pass){
                    break;
                }
                System.out.println("");
            }
        }
        else{
            System.out.println(" ||  Pas de Membre dans la liste d'attente.\n");
        }
    }

    public static void modifier(Membre membre){
        System.out.println("-------- GESTION PROFIL --------------------------------------------------------");
        boolean action = false;
        while (! action){
            System.out.println(" |  [1] Voir mon profil : ");
            System.out.println(" |  [2] Modifier mon profil : ");
            System.out.println(" |  [3] Retour : ");
            System.out.print("\n | Entrez votre numero -> ");
            String Value = scanner.nextLine();
            switch(Value){
                case "1" : {
                    System.out.println("\n ||  --Votre Profil--");
                    System.out.println(" ||  Id :          " + membre.Id);
                    System.out.println(" ||  Nom :         " + membre.Nom);
                    System.out.println(" ||  Prenom :      " + membre.Prenom);
                    System.out.println(" ||  Mail Uni. :   " + membre.MailUni);
                    System.out.println(" ||  Mail :        " + membre.Mail);
                    System.out.println(" ||  Tel :         " + membre.Tel);
                    System.out.println(" ||  Lien Web :    " + membre.LienWeb);
                    System.out.println(" ||  Titre :       " + membre.Titre);
                    System.out.println(" ||  Superviseur : " + membre.Superviseur);
                    System.out.println(" ||  Role :        " + membre.Role);
                    System.out.println(" ||  Notif Mail :        " + membre.notifMail);
                    System.out.println(" ||  Interet Souscrit :   ");
                    ControleurInteret.printerAll(" |", membre.interet);
                    System.out.println(" ||  Projet Souscrit :   ");
                    ControleurProjet.printerprojetAll(" |", membre.projet, membre);
                    System.out.println(" ||  Outil Souscrit :    ");
                    ControleurOutil.printeroutilAll(" |", membre.outil, membre);
                    System.out.println(" ||  Article Souscrit :  ");
                    ControleurArticle.printerarticleAll(" |", membre.article, membre);
                    System.out.println(" ||  ----------------\n");
                }; break;
                case "2" : {
                    System.out.println("\n ||  --Modifier Profil--");
                    System.out.println(" ||  [1] Nom : ");
                    System.out.println(" ||  [2] Prenom : ");
                    System.out.println(" ||  [3] Mail personnel : ");
                    System.out.println(" ||  [4] Mdp : ");
                    System.out.println(" ||  [5] Tel : ");
                    System.out.println(" ||  [6] Lien Website : ");
                    System.out.println(" ||  [7] Titre : ");
                    System.out.println(" ||  [8] Notif Mail : ");
                    System.out.println(" ||  [9] Interet : ");
                    System.out.println(" ||  [10] projet : ");
                    System.out.println(" ||  [11] outil : ");
                    System.out.println(" ||  [12] article : ");
                    System.out.println(" ||  [13] Retour : ");
                    boolean action2 = false;
                    while(! action2){
                        System.out.print("\n || Entrez votre numero -> ");
                        String donnee = scanner.nextLine();
                        switch(donnee){
                            case "1" : System.out.print(" || Votre nouvelle donnee : "); 
                            membre.Nom = textCreator(0, 50);
                            System.out.print(" || donnee modifie : "); break;
                            case "2" : System.out.print(" || Votre nouvelle donnee : ");
                            membre.Prenom = textCreator(0, 50);
                            System.out.print(" || donnee modifie : "); break;
                            case "3" : System.out.print(" || Votre nouvelle donnee : ");
                            membre.Mail = scanner.nextLine();
                            System.out.print(" || donnee modifie : "); break;
                            case "4" : {
                                System.out.print(" || Votre nouvelle donnee : ");
                                String mdp = mdpCreator();
                                membre.Mdp = mdp;
                                while (true){
                                    System.out.print("Confirmez Votre Mdp : ");
                                    if (mdp.equals(mdpCreator())){
                                        break;
                                    }
                                    else {
                                        System.out.print("Mdp Errone: ");
                                    }
                                }
                                System.out.print(" || donnee modifie : "); 
                            } break;
                            case "5" : System.out.print(" || Votre nouvelle donnee : ");
                            membre.Tel = textCreator(10, 15);
                            System.out.print(" || donnee modifie : "); break;
                            case "6" : System.out.print(" || Votre nouvelle donnee : ");
                            membre.LienWeb = scanner.nextLine();
                            System.out.print(" || donnee modifie : "); break;
                            case "7" : System.out.print(" || Votre nouvelle donnee : ");
                            membre.Titre = scanner.nextLine();
                            System.out.print(" || donnee modifie : "); break;
                            case "8" : {                                               
                                System.out.println(" ||||  [1] True: \n ||||  [2] False : ");
                                System.out.print(" |||| Veuillez entrer le nouveau statut : ");
                                String role = scanner.nextLine();
                                switch(role){
                                    case "1" : {
                                        System.out.println(" |||| Donnee modifie avec succes.\n");   
                                        membre.notifMail = true;
                                    }; break;
                                    case "2" : {
                                        System.out.println(" |||| Donnee modifie avec succes.\n");   
                                        membre.notifMail = false;
                                    }; break;
                                    default :{
                                        System.out.println(" |||| Cette action n'est pas valable, veuillez recommencer.");
                                    }
                                }
                            }; break;
                            case "9" : {
                                ControleurInteret.modifierInteret(membre.interet);
                                System.out.print(" || donnee modifie : ");
                            }; break;
                            case "10" : {
                                ControleurProjet.modifierProjetMembre(membre.projet, membre);
                                System.out.print(" || donnee modifie : ");
                            }; break;
                            case "11" : {
                                ControleurOutil.modifierOutilMembre(membre.outil, membre);
                                System.out.print(" || donnee modifie : ");
                            }; break;
                            case "12" : {
                                ControleurArticle.modifierArticleMembre(membre.article, membre);
                                System.out.print(" || donnee modifie : ");
                            }; break;
                            case "13" : action2 = true; break ;
                            default : {
                                System.out.println
                                (" || mauvais numero, veuillez ressayer.\n");
                            };

                        }

                    }
                    System.out.println(" ||  -------------------\n");
                }; break;
                case "3" : action = true; System.out.println("\n"); break ;
                default : {
                    System.out.println
                    (" | mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }

    public static void affichagemembre(){
        System.out.println("------------ MEMBRES DE ROUNDTABLE ---------------------------------------------");
        boolean action = false;
        while (! action){
            System.out.println(" |  [1] Afficher tout les Membres : ");
            System.out.println(" |  [2] Recherche par Nom ou Prenom : ");
            System.out.println(" |  [3] Recherche par Interet : ");
            System.out.println(" |  [4] Affichage profil Complet (Nom et Prenom) : ");
            System.out.println(" |  [5] Retour : ");
            System.out.print("\n | Entrez votre numero -> ");
            String Value = scanner.nextLine();
            switch(Value){
                case "1" : {
                    System.out.println("\n ||  --TOUT LES MEMBRES--");
                    printermembreAll(" ||  ", listeMembre);
                    System.out.println(" ||  --------------------\n");
                }; break;
                case "2" : {
                    System.out.print(" || Notez le nom ou prenom : ");
                    String Nom = scanner.nextLine();
                    boolean resultat = false;
                    System.out.println("\n ||  --LES RESULTATS--");
                    for (int x = 0; x < listeMembre.size(); x++){
                        if (listeMembre.get(x).Nom.contains(Nom) || listeMembre.get(x).Prenom.contains(Nom)){
                            affichagemembreComplet(" ||  ", false, listeMembre.get(x));
                            resultat = true;
                        }
                    }
                    System.out.println(" ||  -----------------\n");
                    if (! resultat){
                        System.out.println(" || Aucun resultat, ou erreur d'ecriture\n");
                    }
                }; break ;
                case "3" : {
                    ControleurInteret.printMembreInteret();
                }; break; 
                case "4" : {
                    System.out.print(" || Notez le nom : ");
                    String Nom = scanner.nextLine();
                    System.out.print(" || Notez le Prenom : ");
                    String Prenom = scanner.nextLine();
                    boolean resultat = false;
                    for (int x = 0; x < listeMembre.size(); x++){
                        if (listeMembre.get(x).Nom.contains(Nom) && listeMembre.get(x).Prenom.contains(Prenom)){
                            System.out.println("\n ||  --LE RESULTAT--");
                            affichagemembreComplet(" ||  ", true, listeMembre.get(x));
                            System.out.println(" ||  ---------------\n");
                            resultat = true;
                            break;
                        }
                    }
                    if (! resultat){
                        System.out.println(" || Aucun resultat, ou erreur d'ecriture\n");
                    }
                }; break ;
                case "5" : action = true; break ;
                default : {
                    System.out.println
                    (" | mauvais numero, veuillez ressayer.\n");
                };
            }
        }
        System.out.println("");
    }
    public static void printermembreAll(String prefix, List<Membre> liste){
        for (int x = 0; x < liste.size(); x++){
            affichagemembreComplet(prefix, false, liste.get(x));
        }
    }
    public static void affichagemembreComplet(String prefix, boolean complet, Membre membre){
        if (membre.Statut.equals("Actif")){
            System.out.println(prefix + "--------------------");
            System.out.println(prefix + "Nom : " + membre.Nom + " " + membre.Prenom);
            System.out.println(prefix + "Mail Universitaire : " + membre.MailUni);
            if (complet){
                ControleurInteret.printerAll(prefix, membre.interet);
                System.out.println(prefix + "les articles : ----");
                ControleurArticle.printerarticleAllAuteur(prefix, membre.article, membre);
                System.out.println(prefix + "les projets : ----");
                ControleurProjet.printerprojetAll(prefix, membre.projet, membre);
                System.out.println(prefix + "les outils : ----");
                ControleurOutil.printeroutilAll(prefix, membre.outil, membre);
            }
            System.out.println(prefix + "--------------------");
        }
    }

    public static void affichagemembreCompletAjout(String prefix, Membre membre){
        System.out.println(prefix + "--------------------");
        System.out.println(prefix + "Nom : " + membre.Nom + " " + membre.Prenom);
        System.out.println(prefix + "Mail Universitaire : " + membre.MailUni);
        ControleurInteret.printerAll(prefix, membre.interet);
        System.out.println(prefix + "les articles : ----");
        ControleurArticle.printerarticleAllAuteur(prefix, membre.article, membre);
        System.out.println(prefix + "les projets : ----");
        ControleurProjet.printerprojetAll(prefix, membre.projet, membre);
        System.out.println(prefix + "les outils : ----");
        ControleurOutil.printeroutilAll(prefix, membre.outil, membre);
        System.out.println(prefix + "--------------------");
    }

    public static void printNotif(Membre compte){
        System.out.println("Affichage des notification de " + compte.Nom + " " + compte.Prenom);
        System.out.println("\n--------------------");
        for (int x = 0; x < compte.notif.size(); x++){
            System.out.println("  [" + (compte.notif.size() - x) + "] " + compte.notif.get(x));
        }
        System.out.println("--------------------\n");
    }

    public static List<Membre> creationListemembre(boolean vide, String membreText){
        boolean interetTrouve = false;
        boolean termine = false;
        List<Membre> listeMembrebis = new ArrayList<>();
        int nombreMembre = 0;
        while (! termine){
            System.out.print("Votre " + membreText + " : (Nom seulement, null pour terminer) -> ");
            String membre = scanner.nextLine();
            if (membre.equals("null")){
                if (nombreMembre <= 0 && !vide){
                    System.out.print("    Impossible de terminer la liste, il y a personne : ");
                }
                else{
                    termine = true;
                }
            }
            else{
                for (int y = 0; y < listeMembre.size(); y++){
                    if (membre.equals(listeMembre.get(y).Nom)){
                        listeMembrebis.add(listeMembre.get(y));
                        nombreMembre += 1;
                        interetTrouve = true;
                        break;
                    }
                }
                if (! interetTrouve){
                    System.out.println("membre Introuvable.");
                }
            }
        }
        System.out.println("| ->Liste de membre a ete cree avec succes : ");
        return listeMembrebis;
    }
    public static Membre findmembre(String leMembre){
        boolean interetTrouve = false;
        while (true){
            System.out.print("Votre " + leMembre + " : (Nom Seulement) -> ");
            String membre = scanner.nextLine();
            for (int y = 0; y < listeMembre.size(); y++){
                if (membre.equals(listeMembre.get(y).Nom) && listeMembre.get(y).Role.equals(Role.listeRole.get(1))){
                    return listeMembre.get(y);
                }
            }
            if (! interetTrouve){
                System.out.println("membre Introuvable.");
            }
        }
    }
    public static Membre findmembreArticle(String leMembre){
        for (int y = 0; y < listeMembre.size(); y++){
            if (leMembre.equals(listeMembre.get(y).Nom)){
                return listeMembre.get(y);
            }
        }
        return null;
    }
    public static void add(String prefix, List<Membre> liste){
        if (listeMembre.size() > 0){
            System.out.print(prefix + "  Veuillez entrer un membre a supprimer: ");
            String nom = scanner.nextLine();
            boolean BonProjet = false;
            for (int x = 0; x < listeMembre.size(); x++){
                if (nom.equals(listeMembre.get(x).Nom)){
                    System.out.println(prefix + "  " +listeMembre.get(x).Nom + "a ete ajoute");
                    liste.add(listeMembre.get(x));
                    BonProjet = true;
                    break;
                }
            }
            if (! BonProjet){
                System.out.println("\n" + prefix + "  membre Introuvable.\n");
            }
        }
        else{
            System.out.println("\n" + prefix + "  Il n'y a aucun membre danc cette liste");
        }
    }
    public static void supp(String prefix, List<Membre> liste){
        if (liste.size() > 0){
            System.out.print(prefix + "  Veuillez entrer un membre a supprimer: ");
            String nom = scanner.nextLine();
            boolean BonProjet = false;
            for (int x = 0; x < liste.size(); x++){
                if (nom.equals(liste.get(x).Nom)){
                    System.out.println(prefix + "  " + liste.get(x).Nom + "a ete supprime");
                    liste.remove(x);
                    BonProjet = true;
                    break;
                }
            }
            if (! BonProjet){
                System.out.println("\n" + prefix +"  membre Introuvable.\n");
            }
        }
        else{
            System.out.println("\n" + prefix + "  Il n'y a aucun membre danc cette liste");
        }
    }
    public static void modifierMembre(List<Membre> liste){
        boolean action = false;
        System.out.println(" |Que Souhaitez vous faire? \n");
        while (! action){
            System.out.println(" |  [1] Afficher tout les membres : ");
            System.out.println(" |  [2] ajouter un membre : ");
            System.out.println(" |  [3] supprimer un membre : ");
            System.out.println(" |  [4] Retour : ");
            System.out.print("\nEntrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : printermembreAll(" |", liste); break;
                case "2" : add(" |", liste); break;
                case "3" : supp(" |", liste); break ;
                case "4" : action = true; break;
                default : {
                    System.out.println
                    ("mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }

    public static String textCreator (Integer minRange, Integer maxRange){
        while (true){
            String text = scanner.nextLine();
            if (minRange <= text.length() && text.length() <= maxRange){
                return text;
            }
            System.out.print ("Impossible, reesayez :");
        }
    }

    public static String mdpCreator(){
        while (true){
            String text = scanner.nextLine();
            if (8 <= text.length() && text.matches(".*[0-9].*") && text.matches(".*[a-z].*") && text.matches(".*[A-Z].*") && text.matches(".*[^a-zA-Z0-9].*")){
                return text;
            }
            System.out.print ("Impossible, reesayez :");
        }
    }

    public static boolean checkMailUni(String MailUni){
        for (int x = 0; x < listeMembre.size(); x++){
            if (listeMembre.get(x).MailUni.equals(MailUni)){
                return false;
            }
        }
        for (int x = 0; x < listeMembreAttente.size(); x++){
            if (listeMembreAttente.get(x).MailUni.equals(MailUni)){
                return false;
            }
        }
        return true;
    }
    
}
