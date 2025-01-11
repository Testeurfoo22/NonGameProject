package controleurs.activites;
import java.util.Scanner;

import controleurs.ControleurInteret;
import controleurs.ControleurMembre;
import entites.Interet;
import entites.activites.Article;
import entites.utilisateurs.Membre;

import java.util.ArrayList;
import java.util.List;

import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime; 


public class ControleurArticle {
    public static Scanner scanner = new Scanner(System.in);
    public static boolean init = true;

    public static List<Article> listeArticle = new ArrayList<>();
    public static List<Article> listeArticleAttente = new ArrayList<>();

    public static void creationInitArticle(){
        if (init){
            init = false;
            List<Interet> listeInteret = new ArrayList<>();
            List<Membre> listemembre = new ArrayList<>();
            listeArticle.add(new Article(21, "article1", "description de l'article1", "2018-04-23",
                listemembre, listemembre, "Publique", 
                listeInteret, "motcle1", "Publie", "Lien article1",  listemembre));
            listeArticle.add(new Article(22, "article2", "description de l'article2", "2018-05-23",
                listemembre, listemembre, "Publique", 
                listeInteret, "motcle2", "Publie", "Lien article2",  listemembre));
        }
    }

    public static void newArticle(Membre membre){
        System.out.println("merci de remplir les informations de votre article : \n");
        System.out.print("le titre de votre article :");
        String Titre = scanner.nextLine();
        System.out.print("la Description de votre article :");
        String Desc = scanner.nextLine();
        List<Membre> listeAuteur = ControleurMembre.creationListemembre(false, "Auteur (Prof Inclus)");
        Membre Prof = ControleurMembre.findmembre("Professeur");
        List<Membre> ListCollab = ControleurMembre.creationListemembre(true, "Collaborateur");
        List<Interet> ListeInteret = ControleurInteret.creationListeInteret();
        System.out.print("Ecrivez Vos Mots cle Ici (en une fois) :");
        String Motscle = scanner.nextLine();
        List<Membre> Souscrit = new ArrayList<>();
        Souscrit.addAll(listeAuteur);
        Souscrit.addAll(ListCollab);
        System.out.println("Voulez-vous Envoyer? Yes ou Brouillon ou Annuler :");
        String reponse = scanner.nextLine();
        switch(reponse){
            case "Yes" : {
                listeArticleAttente.add(new Article(Integer.parseInt(Integer.toString(2) + Integer.toString(listeArticle.size())), Titre, Desc, "", listeAuteur, 
                ListCollab, "Prive", ListeInteret, Motscle, 
                    "Pret", "", Souscrit));
                /*System.out.print("\nVeuillez ecrire une Description de votre Actions: ");
                String Description = scanner.nextLine();*/
                for (int x = 0; x <ControleurMembre.listeMembre.size(); x++){
                    if (ControleurMembre.listeMembre.get(x).MailUni.equals(Prof.MailUni)){
                        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                        LocalDateTime now = LocalDateTime.now(); 
                        ControleurMembre.listeMembre.get(x).notif.add
                            (membre.Nom  + " " + dtf.format(now) + " il y a une nouvelle demande de creation d'article. " /*+ "\n      " + Description*/);
                    }
                }
                System.out.println
                    ("Votre demande a ete prise en compte, vous recevrez une reponse apres examination.\n");
                break;
            } 
            case "Brouillon" : {
                listeArticleAttente.add(new Article(Integer.parseInt(Integer.toString(2) + Integer.toString(listeArticle.size() + 1)), Titre, Desc, "", listeAuteur, 
                ListCollab, "Prive", ListeInteret, Motscle, 
                    "Brouillon", "", Souscrit));
                    System.out.println("votre article est en brouillon");
            }; break;
            case "Annuler" : System.out.println
            ("Votre demande a ete annule.\n"); ; break;       
            default : {
                System.out.println("erreur de typage, la demande est mise en brouillon\n");
                listeArticleAttente.add(new Article(Integer.parseInt(Integer.toString(2) + Integer.toString(listeArticle.size() + 1)), Titre, Desc, "", listeAuteur, 
                ListCollab, "Prive", ListeInteret, Motscle, 
                    "Brouillon", "", Souscrit));
            }
        }
    }
    public static void ajoutArticle(Membre Prof){
        System.out.println("Bienvenue dans la gestion des demandes de publication d'articles");
        if (! listeArticleAttente.isEmpty()){
            //boolean articleAjoutable = false;
            for (int x = 0; x < listeArticleAttente.size(); x++){
                boolean pass = false;
                //articleAjoutable = true;
                if(! listeArticleAttente.get(x).Statut.equals("Brouillon")){
                    affichagearticleCompletAjout(" |  ", listeArticleAttente.get(x));
                }
                if (listeArticleAttente.get(x).Statut.equals("Envoye")){
                    System.out.println("Voulez-vous accepter cet article? Yes, No ou Passe, Retour pour quitter la gestion");
                    System.out.print ("-> ");
                    String reponse = scanner.nextLine();
                    switch(reponse){
                        case "Yes" : {
                            System.out.print ("Lien de l'article : ");
                            listeArticleAttente.get(x).lien = scanner.nextLine();
                            listeArticleAttente.get(x).Statut = "publie";
                            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");  
                            LocalDateTime now = LocalDateTime.now(); 
                            listeArticleAttente.get(x).DatedePublication = (dtf.format(now));
                            for (int y = 0; y < listeArticleAttente.get(x).Souscrit.size(); y++){
                                listeArticleAttente.get(x).Souscrit.get(y).article.add(listeArticleAttente.get(x));
                            }
                            sendnotif(Prof, listeArticleAttente.get(x), "a ete ajoute.");
                            listeArticle.add(listeArticleAttente.get(x));
                            listeArticleAttente.remove(x);
                            System.out.println("la demande a ete accepte.");
                            /*envoie un mail */
                        } ; break;
                        case "No" : {
                            listeArticleAttente.remove(x);
                            System.out.println("la demande a ete rejete.");
                            /*envoie un mail */
                        }; break;
                        case "Passe" : {
                            System.out.println("la demande a ete passe.");
                        }; break;
                        case "Retour" : {
                            pass = true;
                            System.out.println("Vous quittez la gestion de membre.");
                        }; break;
                        default :{
                            System.out.println("Cette action n'est pas valable, la demande a ete passe.");
                        }
                    }
                    if (pass){
                        break;
                    }
                    System.out.println("");
                }
                else if (listeArticleAttente.get(x).Statut.equals("Pret")){
                    System.out.println("Voulez-vous envoyer cet article? Yes, No ou Passe, Retour pour quitter la gestion");
                    System.out.print ("-> ");
                    String reponse = scanner.nextLine();
                    switch(reponse){
                        case "Yes" : {
                            listeArticleAttente.get(x).Statut = "Envoye";
                            System.out.println("la demande a ete envoye.");
                            /*envoie un mail */
                        } ; break;
                        case "No" : {
                            listeArticleAttente.remove(x);
                            System.out.println("la demande a ete rejete.");
                            /*envoie un mail */
                        }; break;
                        case "Passe" : {
                            System.out.println("la demande a ete passe.");
                        }; break;
                        case "Retour" : {
                            pass = true;
                            System.out.println("Vous quittez la gestion de membre.");
                        }; break;
                        default :{
                            System.out.println("Cette action n'est pas valable, la demande a ete passe.");
                        }
                    }
                    if (pass){
                        break;
                    }
                    System.out.println("");
                }
            }
            /*if (! articleAjoutable){
                System.out.println("Aucun article ajoutable n'est Supervise par Vous");
            }*/
        }
        else{
            System.out.println("Pas d'article dans la liste d'attente.\n");
        }
    }
    public static void supp(Membre membre, String prefix, List<Article> liste){
        if (liste.size() > 0){
            System.out.print(prefix + "  Veuillez entrer un article a supprimer: ");
            String nom = scanner.nextLine();
            boolean BonProjet = false;
            for (int x = 0; x < liste.size(); x++){
                System.out.println(prefix + "  " + liste.get(x).Nom);
                if (nom.equals(liste.get(x).Nom)){
                    sendnotif(membre, liste.get(x), "a ete supprime");
                    liste.remove(x);
                    BonProjet = true;
                    break;
                }
            }
            if (! BonProjet){
                System.out.println("\n" + prefix + "  article Introuvable.\n");
            }
        }
        else{
            System.out.println("\n" + prefix + "  Il n'y a aucun article danc cette liste");
        }
    }
    public static void affichagearticle(Membre membre){
        System.out.println("------------articles de Roundtable-------------------");
        //System.out.println("\n ||  Affichage des articles de Roundtable : \n");
        boolean action = false;
        while (! action){
            System.out.println(" ||  [1] Afficher tout les Articles : ");
            System.out.println(" ||  [2] Recherche par Titre ou Auteur ou MotCle : ");
            System.out.println(" ||  [3] Recherche par Interet : ");
            System.out.println(" ||  [4] Affichage profil Complet (Titre) : ");
            System.out.println(" ||  [5] creer un article : ");
            System.out.println(" ||  [6] Mes Articles");
            System.out.println(" ||  [7] Retour : ");
            System.out.print("\n || Entrez votre numero -> ");
            String Value = scanner.nextLine();
            switch(Value){
                case "1" : {
                    System.out.println(" |||  --TOUT LES ARTICLES--");
                    printerarticleAll(" |||  ", listeArticle, membre);
                    System.out.println(" |||  ---------------------\n");
                }; break;
                case "2" : {
                    System.out.print(" ||| Notez le titre ou l'auteur ou un Motcle : ");
                    String Nom = scanner.nextLine();
                    boolean resultat = false;
                    System.out.println(" |||  --LES RESULTATS--");
                    for (int x = 0; x < listeArticle.size(); x++){
                        if (listeArticle.get(x).Nom.contains(Nom) || listeArticle.get(x).Auteurs.contains(ControleurMembre.findmembreArticle(Nom))
                            || listeArticle.get(x).MotsCle.contains(Nom)){
                            affichagearticleComplet(" |||  ", false, listeArticle.get(x), membre);
                            resultat = true;
                        }
                    }
                    System.out.println(" |||  -----------------\n");
                    if (! resultat){
                        System.out.println(" ||| Aucun resultat, ou erreur d'ecriture");
                    }
                }; break ;
                case "3" : {
                    ControleurInteret.printArticleInteret(membre);
                }; break;
                case "4" : {
                    System.out.print(" ||| Notez le Titre : ");
                    String Nom = scanner.nextLine();
                    boolean resultat = false;
                    for (int x = 0; x < listeArticle.size(); x++){
                        if (listeArticle.get(x).Nom.contains(Nom)){
                            resultat = true;
                            System.out.println(" |||  --LE RESULTAT--");
                            affichagearticleComplet(" |||  ", true, listeArticle.get(x), membre);
                            System.out.println(" |||  ---------------");
                            if (! listeArticle.contains(membre)){
                                String reponse = scanner.nextLine();
                                switch(reponse){
                                    case "Y" : {
                                        System.out.println("\n ||| Souscription effectuee\n");
                                        listeArticle.get(x).Souscrit.add(membre);
                                        membre.article.add(listeArticle.get(x));
    
                                    };break;
                                    default : {
                                    };
                                }
                                break;
                            }
                            System.out.print(" ||| Voulez-vous souscrire a cet article? (Y ou N) -> ");
                        }
                    }
                    if (! resultat){
                        System.out.println(" ||| Aucun resultat, ou erreur d'ecriture");
                    }
                }; break ;
                case "5" : newArticle(membre); break;
                case "6" : modifier(membre); break;
                case "7" : action = true; break ;
                default : {
                    System.out.println
                    (" || mauvais numero, veuillez ressayer.\n");
                };
            }
        }
        System.out.println("");
    }
    public static void printerarticleAll(String prefix, List<Article> liste, Membre membre){
        if (liste.size() != 0){
            for (int x = 0; x < liste.size(); x++){
                affichagearticleComplet(prefix, false, liste.get(x), membre);
            }
        }
        else{
            System.out.println(prefix + "  pas d'articles , ou d'articles public.");
        }
    }
    public static void printerarticleAllAuteur(String prefix, List<Article> liste, Membre membre){
        if (liste.size() != 0){
            int cinq = 0;
            for (int x = liste.size() - 1; x > -1; x--){
                if (cinq < 5 && liste.get(x).Auteurs.contains(membre)){
                    affichagearticleComplet(prefix, false, liste.get(x), membre);
                    cinq += 1;
                }
            }
        }
        else{
            System.out.println(prefix + "pas d'articles , ou d'articles public.");
        }
    }
    public static void affichagearticleComplet(String prefix, boolean complet, Article liste, Membre membre){
        if (liste.Visibilite.equals("Publique") || liste.Auteurs.equals(membre)
            || liste.Collaborateur.contains(membre)){
            System.out.println(prefix + "--------------------");
            System.out.println(prefix + "Titre : " + liste.Nom);
            System.out.println(prefix + "les Auteurs : ----");
            ControleurMembre.printermembreAll(prefix, liste.Auteurs);
            System.out.println(prefix + "Date de Publication : " + liste.DatedePublication);
            if (complet){
                System.out.println(prefix + "la Description : " + liste.Description);
                System.out.println(prefix + "les Collaborateurs : ----");
                ControleurMembre.printermembreAll(prefix, liste.Collaborateur);
                ControleurInteret.printerAll(prefix, membre.interet);
                System.out.println(prefix + "Lien supplementaire : " + liste.lien);
            }
            System.out.println(prefix + "--------------------");
        }
    }
    public static void affichagearticleCompletAjout(String prefix, Article liste){
        System.out.println(prefix + "--------------------");
        System.out.println(prefix + "Titre : " + liste.Nom);
        System.out.println(prefix + "les Auteurs : ----");
        ControleurMembre.printermembreAll(prefix, liste.Auteurs);
        System.out.println(prefix + "Date de Publication : " + liste.DatedePublication);
        System.out.println(prefix + "la Description : " + liste.Description);
        System.out.println(prefix + "les Collaborateurs : ----");
        ControleurMembre.printermembreAll(prefix, liste.Collaborateur);
        ControleurInteret.printerAll(prefix, liste.Interet);
        System.out.println(prefix + "Lien supplementaire : " + liste.lien);
        System.out.println(prefix + "Statut : " + liste.Statut);
        System.out.println(prefix + "--------------------");
    }
    /*public static void affichagearticleInteret(article liste, membre membre){
        if (liste.Visibilite.equals("Publique")){
            System.out.println("--------------------");
            System.out.println("Titre : " + liste.Nom);
            System.out.println("les Auteurs : ----");
            membre.printermembreAll("", liste.Auteurs);
            System.out.println("le Professeur : ----");
            membre.affichagemembreComplet("", false, membre);
            System.out.println("--------------------");
        }
    }*/
    public static void sendnotif(Membre auteur, Article article, String donne){
        System.out.print("\nVeuillez ecrire un descriptif de vos Actions: ");
        String Description = scanner.nextLine();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
        LocalDateTime now = LocalDateTime.now(); 
        for (int y = 0; y < article.Souscrit.size(); y++){
            article.Souscrit.get(y).notif.add
                (auteur.Nom  + " " + dtf.format(now) + " " + article.Nom + " " + donne + "\n      " + Description);
        }
    }

    public static List<Article> creationListearticle(Membre membre){
        printerarticleAll("", listeArticle, membre);
        List<Article> listearticle = new ArrayList<>();
        if (listeArticle.size() == 0){
            boolean listeterminee = false;
            while (! listeterminee){
                boolean interetTrouve = false;
                System.out.print("Votre article : (null pour terminer la liste) ");
                String articlelTitre = scanner.nextLine();
                if (articlelTitre.equals("null")){
                    listeterminee = true;
                }
                else{
                    for (int y = 0; y < listeArticle.size(); y++){
                        if (articlelTitre.equals(listeArticle.get(y).Nom)){
                            listearticle.add(listeArticle.get(y));
                            interetTrouve = true;
                            break;
                        }
                    }
                    if (! interetTrouve){
                        System.out.println("article Introuvable.");
                    }
                }
            }
            System.out.println("|  ->la liste a ete cree avec succes : \n");
        }
        return listearticle;
    }
    public static void souscription(boolean souscription, Membre membre, Article article){
        if (souscription){
            article.Souscrit.add(membre);
            System.out.println("Souscription ajoutee.\n");
        }
        else{
            article.Souscrit.remove(membre);
            System.out.println("Souscription retiree.\n");
        }
    }
    public static void modifier(Membre Membre){
        boolean action = false;
        while (! action){
            System.out.println(" |||  [1] Voir mes articles : ");
            System.out.println(" |||  [2] Modifier un article : ");
            System.out.println(" |||  [3] Retour : ");
            System.out.print("\n ||| Entrez votre numero -> ");
            String Value = scanner.nextLine();
            switch(Value){
                case "1" : {
                    for (int x = 0; x < listeArticle.size(); x++){
                        if (listeArticle.get(x).Auteurs.contains(Membre)){
                            System.out.println(" ||||  --Vous etes Auteur--");
                            affichagearticleComplet(" ||||  ", false, listeArticle.get(x), Membre);
                            System.out.println(" ||||  --------------------");
                        }
                    }
                    System.out.println(" ||||  -- Brouillon --");
                    for (int x = 0; x < listeArticleAttente.size(); x++){
                        if (listeArticleAttente.get(x).Auteurs.contains(Membre) && listeArticleAttente.get(x).Statut.equals("Brouillon")){
                            affichagearticleComplet(" ||||  ", false, listeArticleAttente.get(x), Membre);
                        }
                    }
                    System.out.println(" ||||  ---------------");
                    System.out.println(" ||||  -- Pret --");
                    for (int x = 0; x < listeArticleAttente.size(); x++){
                        if (listeArticleAttente.get(x).Auteurs.contains(Membre) && listeArticleAttente.get(x).Statut.equals("Pret")){
                            affichagearticleComplet(" ||||  ", false, listeArticleAttente.get(x), Membre);
                        }
                    }
                    System.out.println(" ||||  ----------");
                }; break;
                case "2" : {
                    boolean BonArticle = false;
                    while(! BonArticle){
                        System.out.print(" |||| Veuillez entrer un Article a modifier (Titre): ");
                        String nom = scanner.nextLine();
                        for (int x = 0; x < listeArticle.size(); x++){
                            if (nom.equals(listeArticle.get(x).Nom)){
                                BonArticle = true;
                                    if (listeArticle.get(x).Auteurs.contains(Membre)){
                                        System.out.println(" ");
                                        System.out.println(" ||||  [1] Titre : ");
                                        System.out.println(" ||||  [2] Description : ");
                                        System.out.println(" ||||  [3] DatedePublication : ");
                                        System.out.println(" ||||  [4] Auteurs : ");
                                        System.out.println(" ||||  [5] Collaborateur : ");
                                        System.out.println(" ||||  [6] Visibilite : ");
                                        System.out.println(" ||||  [7] Interet : ");
                                        System.out.println(" ||||  [8] MotsCle : ");
                                        System.out.println(" ||||  [9] lien : ");
                                        System.out.println(" ||||  [10] supprimer : ");
                                        System.out.println(" ||||  [11] Retour : ");
                                        boolean action2 = false;
                                        boolean modification = false;
                                        while(! action2){
                                            System.out.print("\n |||| Entrez votre numero -> ");
                                            String donnee = scanner.nextLine();
                                            switch(donnee){
                                                case "1" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeArticle.get(x).Nom = textCreator(50); 
                                                    modification = true; 
                                                    break;
                                                case "2" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeArticle.get(x).Description = textCreator(500); 
                                                    modification = true; 
                                                    break;
                                                case "3" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeArticle.get(x).DatedePublication = dateCreator(); 
                                                    modification = true; 
                                                    break;
                                                case "4" : 
                                                    ControleurMembre.modifierMembre(listeArticle.get(x).Auteurs); 
                                                    modification = true; 
                                                    break;
                                                case "5" : 
                                                    ControleurMembre.modifierMembre(listeArticle.get(x).Collaborateur); modification = true; 
                                                    break;
                                                case "6" : {
                                                    System.out.println(" ||||  [1] Publique: \n ||||  [2] Prive : ");
                                                    System.out.print(" |||| Veuillez entrer le nouveau statut : ");
                                                    String role = scanner.nextLine();
                                                    switch(role){
                                                        case "1" : {
                                                            System.out.println(" |||| Statut modifie avec succes.\n");   
                                                            listeArticle.get(x).Visibilite = "Publique";
                                                            modification = true;
                                                        }; break;
                                                        case "2" : {
                                                            System.out.println(" |||| Statut modifie avec succes.\n");   
                                                            listeArticle.get(x).Visibilite = "Prive";
                                                            modification = true;
                                                        }; break;
                                                        default :{
                                                            System.out.println(" |||| Cette action n'est pas valable, veuillez recommencer.");
                                                            modification = true;
                                                        }
                                                    }
                                                }; break;
                                                case "7" : ControleurInteret.modifierInteret(listeArticle.get(x).Interet); modification = true; break;
                                                case "8" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeArticle.get(x).MotsCle = textCreator(40); 
                                                    modification = true; 
                                                    break;
                                                case "9" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeArticle.get(x).lien = scanner.nextLine();
                                                    modification = true; 
                                                    break;
                                                case "10" : {
                                                    action = true;
                                                    action2 = true; 
                                                    modification = false;
                                                    System.out.println(" |||| projet Supprime"); 
                                                    sendnotif(Membre, listeArticle.get(x), "a ete supprime.");
                                                    listeArticle.remove(x); 
                                                }; break;
                                                case "11" : action2 = true; break ;
                                                default : {
                                                    System.out.println
                                                    (" |||| mauvais numero, veuillez ressayer.\n");
                                                };
                    
                                            }
                    
                                        }
                                        if (modification){
                                            modification = false;
                                            sendnotif(Membre, listeArticle.get(x), "a ete modifie.");
                                            System.out.println(" |||| modification effectue avec succes.");
                                        }
                                        System.out.println(" ");
                                        break;
                                    }
                                    else{
                                        System.out.println(" |||| Impossible de modifier cet article");
                                    }
                            }
                        }
                        for (int x = 0; x < listeArticleAttente.size(); x++){
                            if (nom.equals(listeArticleAttente.get(x).Nom)){
                                BonArticle = true;
                                    if (listeArticleAttente.get(x).Auteurs.contains(Membre)){
                                        System.out.println(" ");
                                        System.out.println(" ||||  [1] Titre : ");
                                        System.out.println(" ||||  [2] Description : ");
                                        System.out.println(" ||||  [3] DatedePublication : ");
                                        System.out.println(" ||||  [4] Auteurs : ");
                                        System.out.println(" ||||  [5] Collaborateur : ");
                                        System.out.println(" ||||  [6] Visibilite : ");
                                        System.out.println(" ||||  [7] Interet : ");
                                        System.out.println(" ||||  [8] MotsCle : ");
                                        System.out.println(" ||||  [9] lien : ");
                                        System.out.println(" ||||  [10] Statut : ");
                                        System.out.println(" ||||  [11] supprimer : ");
                                        System.out.println(" ||||  [12] Retour : ");
                                        boolean action2 = false;
                                        boolean modification = false;
                                        while(! action2){
                                            System.out.print("\n |||| Entrez votre numero -> ");
                                            String donnee = scanner.nextLine();
                                            switch(donnee){
                                                case "1" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeArticleAttente.get(x).Nom = textCreator(50); 
                                                    modification = true; 
                                                    break;
                                                case "2" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeArticleAttente.get(x).Description = textCreator(500); 
                                                    modification = true; 
                                                    break;
                                                case "3" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeArticleAttente.get(x).DatedePublication = dateCreator(); 
                                                    modification = true; 
                                                    break;
                                                case "4" : 
                                                    ControleurMembre.modifierMembre(listeArticleAttente.get(x).Auteurs); 
                                                    modification = true; 
                                                    break;
                                                case "5" : 
                                                    ControleurMembre.modifierMembre(listeArticleAttente.get(x).Collaborateur); modification = true; 
                                                    break;
                                                case "10" : {
                                                    System.out.println("Voulez-vous Envoyer? Yes ou No :");
                                                    String reponse = scanner.nextLine();
                                                    switch(reponse){
                                                        case "Yes" : {
                                                            listeArticleAttente.get(x).Statut = "Pret";
                                                            for (int z = 0; z < ControleurMembre.listeMembre.size(); z++){
                                                                //if (membre.listeMembre.get(z).MailUni.equals(listeArticleAttente.get(x).Responsable.MailUni)){
                                                                    ControleurMembre.listeMembre.get(z).notif.add("il y a une nouvelle demande de creation d'article.");
                                                                //}
                                                            }
                                                            System.out.println
                                                                ("Votre demande a ete prise en compte, vous recevrez une reponse apres examination.\n");
                                                            break;
                                                        } 
                                                        case "No" : {
                                                            System.out.println
                                                                ("Votre demande a ete prise en compte.\n");
                                                        } 
                                                        default : {
                                                            System.out.println("erreur de typage, la demande est mise en brouillon\n");
                                                        }break;
                                                    }
                                                }; break;
                                                case "7" : ControleurInteret.modifierInteret(listeArticleAttente.get(x).Interet); modification = true; break;
                                                case "8" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeArticleAttente.get(x).MotsCle = textCreator(40); 
                                                    modification = true; 
                                                    break;
                                                case "9" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeArticleAttente.get(x).lien = scanner.nextLine();
                                                    modification = true; 
                                                    break;
                                                case "6" : {
                                                    System.out.println(" ||||  [1] Prive: \n ||||  [2] Prive : ");
                                                    System.out.print(" |||| Veuillez entrer le nouveau statut : ");
                                                    String role = scanner.nextLine();
                                                    switch(role){
                                                        case "1" : {
                                                            System.out.println(" |||| Statut modifie avec succes.\n");   
                                                            listeArticleAttente.get(x).Visibilite = "Publique";
                                                            modification = true;
                                                        }; break;
                                                        case "2" : {
                                                            System.out.println(" |||| Statut modifie avec succes.\n");   
                                                            listeArticleAttente.get(x).Visibilite = "Prive";
                                                            modification = true;
                                                        }; break;
                                                        default :{
                                                            System.out.println(" |||| Cette action n'est pas valable, veuillez recommencer.");
                                                            modification = true;
                                                        }
                                                    }
                                                }; break;
                                                case "11" : {
                                                    action = true;
                                                    action2 = true; 
                                                    modification = false;
                                                    System.out.println(" |||| projet Supprime"); 
                                                    sendnotif(Membre, listeArticle.get(x), "a ete supprime.");
                                                    listeArticle.remove(x); 
                                                }; break;
                                                case "12" : action2 = true; break ;
                                                default : {
                                                    System.out.println
                                                    (" |||| mauvais numero, veuillez ressayer.\n");
                                                };
                    
                                            }
                    
                                        }
                                        if (modification){
                                            modification = false;
                                            sendnotif(Membre, listeArticleAttente.get(x), "a ete modifie.");
                                            System.out.println(" |||| modification effectue avec succes.");
                                        }
                                        System.out.println(" ");
                                        break;
                                    }
                                    else{
                                        System.out.println(" |||| Impossible de modifier cet article");
                                    }
                            }
                        }
                        if (! BonArticle){
                            BonArticle = true;
                            System.out.println("\n |||| projet Introuvable.\n");
                        }
                    }
                }; break;
                case "3" : action = true; break ;
                default : {
                    System.out.println
                    (" ||| mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }
    public static void modifierArticleMembre(List<Article> liste, Membre membre){
        boolean action = false;
        //System.out.println(" |Que Souhaitez vous faire? \n");
        while (! action){
            System.out.println(" |||  [1] Afficher tout les articles souscrit: ");
            System.out.println(" |||  [2] supprimer un article souscrit : ");
            System.out.println(" |||  [3] Retour : ");
            System.out.print("\n ||  Entrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : printerarticleAll(" |||", liste, membre); break;
                case "2" : suppInnerMembre(liste, membre); break ;
                case "3" : action = true; break;
                default : {
                    System.out.println
                    ("||  mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }
    public static void modifierArticle(List<Article> liste, Membre membre){
        boolean action = false;
        System.out.println(" |Que Souhaitez vous faire? \n");
        while (! action){
            System.out.println(" |  [1] Afficher tout les Articles : ");
            System.out.println(" |  [2] ajouter un Article : ");
            System.out.println(" |  [3] supprimer un Article : ");
            System.out.println(" |  [4] Retour : ");
            System.out.print("\nEntrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : printerarticleAll(" |", liste, membre); break;
                case "2" : addInner(" |", liste); break;
                case "3" : suppInner(" |", liste); break ;
                case "4" : action = true; break;
                default : {
                    System.out.println
                    ("mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }
    public static void addInner(String prefix, List<Article> liste){
        if (listeArticle.size() > 0){
            System.out.print(prefix + "  Veuillez entrer un article a supprimer: ");
            String nom = scanner.nextLine();
            boolean BonProjet = false;
            for (int x = 0; x < listeArticle.size(); x++){
                if (nom.equals(listeArticle.get(x).Nom)){
                    System.out.println(prefix + "  " + listeArticle.get(x).Nom + "a ete ajoute");
                    liste.add(listeArticle.get(x));
                    BonProjet = true;
                    break;
                }
            }
            if (! BonProjet){
                System.out.println("\n" + prefix + "  article Introuvable.\n");
            }
        }
        else{
            System.out.println("\n" + prefix + "  Il n'y a aucun article danc cette liste");
        }
    }
    public static void suppInner(String prefix, List<Article> liste){
        if (liste.size() > 0){
            System.out.print(prefix + "  Veuillez entrer un article a supprimer: ");
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
                System.out.println("\n" + prefix + "  Article Introuvable.\n");
            }
        }
        else{
            System.out.println("\n" + prefix + "  Il n'y a aucun Article danc cette liste");
        }
    }
    public static void suppInnerMembre(List<Article> liste, Membre membre){
        if (liste.size() > 0){
            System.out.print(" |||  Veuillez entrer un article a de Souscrire: ");
            String nom = scanner.nextLine();
            boolean BonProjet = false;
            for (int x = 0; x < liste.size(); x++){
                if (nom.equals(liste.get(x).Nom)){
                    System.out.println(" |||  " + liste.get(x).Nom + " a ete supprime");
                    souscription(false, membre, liste.get(x)); 
                    liste.remove(x);
                    BonProjet = true;
                    break;
                }
            }
            if (! BonProjet){
                System.out.println("\n |||  article Introuvable.\n");
            }
        }
        else{
            System.out.println("\n |||  Il n'y a aucun article danc cette liste");
        }
    }

    public static String textCreator (Integer maxRange){
        while (true){
            String text = scanner.nextLine();
            if (text.length() <= maxRange){
                return text;
            }
            System.out.print ("Impossible, reesayez :");
        }
    }

    public static String dateCreator (){
        char x = '-';
        while (true){
            String text = scanner.nextLine();
            if (text.length() == 10 && text.charAt(4) == (x) 
                && text.charAt(7) == (x)){
                return text;
            }
            System.out.print ("Impossible, reesayez :");
        }
    }
}
