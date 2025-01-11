package controleurs.activites;
import java.util.Scanner;

import controleurs.ControleurInteret;
import controleurs.ControleurMembre;
import entites.Interet;
import entites.activites.Article;
import entites.activites.Outil;
import entites.utilisateurs.Membre;

import java.util.ArrayList;
import java.util.List;

import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime;


public class ControleurOutil {
    public static Scanner scanner = new Scanner(System.in);

    public static List<Outil> listeOutil = new ArrayList<>();
    public static boolean init = true;


    public static void creationInitOutil(){
        if (init){
            init = false;
            List<Interet> listeInteret = new ArrayList<>();
            List<Membre> listemembre = new ArrayList<>();
            List<Article> listearticle = new ArrayList<>();
            listeOutil.add(new Outil(41, "outil1", "description de l'outil1", "v1",
                 "Lien Git1", "Lien add 1", ControleurMembre.listeMembre.get(0),
                 "Publique", listemembre, listearticle, listeInteret, "motcle1", listemembre));
            listeOutil.add(new Outil(42, "outil2", "description de l'outil2", "v2",
                 "Lien Git2", "lien add 2", ControleurMembre.listeMembre.get(0),
                 "Publique", listemembre, listearticle, listeInteret, "motcle2", listemembre));
        }
    }

    public static void newOutil(){
        System.out.println("merci de remplir les ifnormation de votre outil : \n");
        System.out.print("le titre de votre outil :");
        String Titre = scanner.nextLine();
        System.out.print("la Description de votre outil :");
        String Desc = scanner.nextLine();
        System.out.print("la version de l'outil :");
        String version = scanner.nextLine();
        System.out.print("Liens git :");
        String git = scanner.nextLine();
        System.out.print("Liens additionnels (en une fois) :");
        String lienadd = scanner.nextLine();
        Membre Prof = ControleurMembre.findmembre("Professeur");
        List<Membre> ListCollab = ControleurMembre.creationListemembre(true, "Collaborateur (Hors Prof)");
        List<Article> ListArticle = ControleurArticle.creationListearticle(new Membre());
        List<Interet> ListeInteret = ControleurInteret.creationListeInteret();
        System.out.print("Ecrivez Vos Mots cle Ici (en une fois) :");
        String Motscle = scanner.nextLine();
        List<Membre> Souscrit = new ArrayList<>();
        Souscrit.add(Prof);
        Souscrit.addAll(ListCollab);
        System.out.println("Voulez-vous Creer cet outil? Yes ou No :");
        String reponse = scanner.nextLine();
        switch(reponse){
            case "Yes" : {
                listeOutil.add(new Outil(Integer.parseInt(Integer.toString(4) + Integer.toString(listeOutil.size() + 1)), Titre, Desc, version, git, lienadd,
                Prof, "Publique", ListCollab, ListArticle, ListeInteret, Motscle, Souscrit));
                for (int y = 0; y < listeOutil.get(listeOutil.size()-1).Souscrit.size(); y++){
                    listeOutil.get(listeOutil.size()-1).Souscrit.get(y).outil.add(listeOutil.get(listeOutil.size()-1));
                }
                System.out.println
                    ("Votre projet a ete ajoute.\n");
                break;
            } 
            case "No" : System.out.println
            ("Votre demande a ete annule."); ; break;       
            default : {
                System.out.println("erreur de typage, la demande est annulee\n");
            }
        }
    }

    public static void supp(Membre membre, String prefix, List<Outil> liste){
        System.out.print(prefix + "  Veuillez entrer un Outil a supprimer: ");
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
            System.out.println("\n" + prefix + "  Outil Introuvable.\n");
        }
    }

    public static void affichageoutil(Membre membre){
        System.out.println("--------------------------------------------------------------------------------");
        System.out.println("\nAffichage des outils de Roundtable : \n");
        boolean action = false;
        while (! action){
            System.out.println("  [1] Afficher tout les Outils : ");
            System.out.println("  [2] Affichage Outil Complet (Titre) : ");
            System.out.println("  [3] Recherche par Interet : ");
            System.out.println("  [4] creer un outil : ");
            System.out.println("  [5] Mes outils : ");
            System.out.println("  [6] Retour : ");
            System.out.print("\nque voulez vous faire : ");
            String Value = scanner.nextLine();
            switch(Value){
                case "1" : {
                    System.out.println("\n |||  --TOUT LES PROJETS--");
                    printeroutilAll(" |||  ", listeOutil, membre);
                    System.out.println(" |||  --------------------\n");
                }; break;
                case "2" : {
                    System.out.print("Notez le titre : ");
                    String Nom = scanner.nextLine();
                    boolean resultat = false;
                    System.out.println(" ");
                    for (int x = 0; x < listeOutil.size(); x++){
                        if (listeOutil.get(x).Nom.contains(Nom)){
                            resultat = true;
                            System.out.println(" |||  --LE RESULTAT--");
                            affichageoutilComplet(" |||  ", false, listeOutil.get(x), membre);
                            System.out.println(" |||  ---------------");
                            if (! listeOutil.get(x).Souscrit.contains(membre)){
                                System.out.print("Voulez-vous souscrire a cet outil? (Y ou N) ->");
                                String reponse = scanner.nextLine();
                                switch(reponse){
                                    case "Y" : {
                                        System.out.println("\nSouscription effectuee\n");
                                        listeOutil.get(x).Souscrit.add(membre);
                                        membre.outil.add(listeOutil.get(x));
                                    };break;
                                    default : {
                                    };
                                }
                            }
                        }
                    }
                    System.out.println(" ");
                    if (! resultat){
                        System.out.println("Aucun resultat, ou erreur d'ecriture\n");
                    }
                }; break ;
                case "3" : ControleurInteret.printOutilInteret(membre); break;
                case "4" : newOutil(); break;
                case "5" : modifier(membre); break;
                case "6" : action = true; break ;
                default : {
                    System.out.println
                    ("mauvais numero, veuillez ressayer.\n");
                };
            }
        }
        System.out.println("");
    }
    public static void printeroutilAll(String prefix, List<Outil> liste, Membre membre){
        if (liste.size() != 0){
            for (int x = 0; x < liste.size(); x++){
                affichageoutilComplet(prefix, false, liste.get(x), membre);
            }
        }
        else{
            System.out.println(prefix + "pas d'outils, ou d'outils public.");
        }
    }
    public static void affichageoutilComplet(String prefix, boolean complet, Outil liste, Membre membre){
        if (liste.Visibilite.equals("Publique") || liste.Responsable.equals(membre)
            || liste.Collaborateur.contains(membre)){
            System.out.println(prefix + "--------------------");
            System.out.println(prefix + "Titre : " + liste.Nom);
            System.out.println(prefix + "la Version : " + liste.Version);
            System.out.println(prefix + "le Responsable : ----");
            ControleurMembre.affichagemembreComplet(prefix, false, liste.Responsable);
            System.out.println(prefix + "les Collaborateurs : ----");
            ControleurMembre.printermembreAll(prefix, liste.Collaborateur);
            if (complet){
                System.out.println(prefix + "la Description " + liste.Description);
                System.out.println(prefix + "Liens Additionnels : " + liste.LienAdd);
                System.out.println(prefix + "les Articles : ----");
                ControleurArticle.printerarticleAll(prefix, liste.Article, membre);
                ControleurInteret.printerAll(prefix, membre.interet);
            }
            System.out.println(prefix + "--------------------");
        }
    }
    /*public static void affichageoutilInteret(outil liste, membre membre){
        if (liste.Visibilite.equals("Publique") || liste.Responsable.equals(membre)
            || liste.Collaborateur.contains(membre)){
            System.out.println("--------------------");
            System.out.println("Titre : " + liste.Nom);
            System.out.println("le Responsable : ----");
            membre.affichagemembreComplet(" ", false, liste.Responsable);
            System.out.println("le Professeur : ----");
        }
    }*/
    public static void sendnotif(Membre auteur, Outil outil, String message){
        System.out.print("\nVeuillez ecrire un descriptif de vos Actions: ");
        String Description = scanner.nextLine();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
        LocalDateTime now = LocalDateTime.now(); 
        for (int y = 0; y < outil.Souscrit.size(); y++){
            outil.Souscrit.get(y).notif.add
                (auteur.Nom  + " " + dtf.format(now) + " " + outil.Nom + " " + message + "\n      " + Description);
        }
    }
    public static void souscription(boolean souscription, Membre membre, Outil outil){
        if (souscription){
            outil.Souscrit.add(membre);
            System.out.println("Souscription ajoutee.\n");
        }
        else{
            outil.Souscrit.remove(membre);
            System.out.println("Souscription retiree.\n");
        }
    }
    public static void modifier(Membre Membre){
        boolean action = false;
        while (! action){
            System.out.println(" |  [1] Voir mes outils : ");
            System.out.println(" |  [2] Modifier un outil : ");
            System.out.println(" |  [3] Retour : ");
            System.out.print("\nEntrez votre numero -> ");
            String Value = scanner.nextLine();
            switch(Value){
                case "1" : {
                    for (int x = 0; x < listeOutil.size(); x++){
                        if (listeOutil.get(x).Responsable.equals(Membre)){
                            System.out.println(" ||||  --Vous etes Responsable--");
                            affichageoutilComplet(" ||||  ", false, listeOutil.get(x), Membre);
                            System.out.println(" ||||  -------------------------");
                        }
                        else if (listeOutil.get(x).Collaborateur.equals(Membre)){
                            System.out.println(" ||||  --Vous etes un Collaborateur--");
                            affichageoutilComplet(" ", false, listeOutil.get(x), Membre);
                            System.out.println(" ||||  ------------------------------");
                        }
                    }
                }; break;
                case "2" : {
                    boolean BonArticle = false;
                    while(! BonArticle){
                        System.out.print("Veuillez entrer un Article a modifier: (Titre)");
                        String nom = scanner.nextLine();
                        for (int x = 0; x < listeOutil.size(); x++){
                            if (nom.equals(listeOutil.get(x).Nom)){
                                BonArticle = true;
                                    if (listeOutil.get(x).Responsable.equals(Membre)){
                                        System.out.println(" ");
                                        System.out.println(" ||||  [1] Titre : ");
                                        System.out.println(" ||||  [2] Description : ");
                                        System.out.println(" ||||  [3] Version : ");
                                        System.out.println(" ||||  [4] Git : ");
                                        System.out.println(" ||||  [5] LienAdd : ");
                                        System.out.println(" ||||  [6] Visibilite : ");
                                        System.out.println(" ||||  [7] Collaborateur : ");
                                        System.out.println(" ||||  [8] Article : ");
                                        System.out.println(" ||||  [9] Interet : ");
                                        System.out.println(" ||||  [10] MotsCle : ");
                                        System.out.println(" ||||  [11] supprimer : ");
                                        System.out.println(" ||||  [12] Retour : ");
                                        boolean action2 = false;
                                        boolean modification = false;
                                        while(! action2){
                                            System.out.print("\nEntrez votre numero -> ");
                                            String donnee = scanner.nextLine();
                                            switch(donnee){
                                                case "1" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeOutil.get(x).Nom = textCreator(50); 
                                                    modification = true; 
                                                    break;
                                                case "2" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");listeOutil.get(x).Description = textCreator(500); 
                                                    modification = true; 
                                                    break;
                                                case "3" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeOutil.get(x).Version = scanner.nextLine();; 
                                                    modification = true; 
                                                    break;
                                                case "4" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeOutil.get(x).Git = scanner.nextLine();; 
                                                    modification = true; 
                                                    break;
                                                case "5" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");listeOutil.get(x).LienAdd = scanner.nextLine();; 
                                                    modification = true; 
                                                    break;
                                                case "6" : {
                                                    System.out.println(" |    [1] Publique: \n |    [2] Prive : ");
                                                    System.out.print("Veuillez entrer le nouveau statut : ");
                                                    String role = scanner.nextLine();
                                                    switch(role){
                                                        case "1" : {
                                                            System.out.println("Statut modifie avec succes.\n");   
                                                            listeOutil.get(x).Visibilite = "Publique";
                                                            modification = true;
                                                        }; break;
                                                        case "2" : {
                                                            System.out.println("Statut modifie avec succes.\n");   
                                                            listeOutil.get(x).Visibilite = "Prive";
                                                            modification = true;
                                                        }; break;
                                                        default :{
                                                            System.out.println("Cette action n'est pas valable, veuillez recommencer.\n");
                                                            modification = true;
                                                        }
                                                    }
                                                }; break;
                                                case "7" : ControleurMembre.modifierMembre(listeOutil.get(x).Collaborateur); modification = true; break;
                                                case "8" : ControleurArticle.modifierArticle(listeOutil.get(x).Article, Membre); modification = true; break;
                                                case "9" : ControleurInteret.modifierInteret(listeOutil.get(x).Interet); modification = true; break;
                                                case "10" : 
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeOutil.get(x).MotsCle = textCreator(40); 
                                                    modification = true; 
                                                    break;
                                                case "11" : {
                                                    action = true;
                                                    action2 = true; 
                                                    modification = false;
                                                    System.out.println(" |||| projet Supprime"); 
                                                    sendnotif(Membre, listeOutil.get(x), "a ete supprime.");
                                                    listeOutil.remove(x); 
                                                }; break;
                                                case "12" : action2 = true; break ;
                                                default : {
                                                    System.out.println
                                                    ("mauvais numero, veuillez ressayer.\n");
                                                };
                                            }
                                        }
                                        if (modification){
                                            modification = false;
                                            sendnotif(Membre, listeOutil.get(x), "a ete modifie.");
                                            System.out.println("modification effectue avec succes.\n");
                                        }
                                        System.out.println(" ");
                                        break;
                                    }
                                    else{
                                        System.out.println("Impossible de modifier cet article\n");
                                    }
                            }
                        }
                        if (! BonArticle){
                            BonArticle = true;
                            System.out.println("\nOutil Introuvable.\n");
                        }
                    }
                }; break;
                case "3" : action = true; break ;
                default : {
                    System.out.println
                    ("mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }
    /*public static void modifierOutil(List<outil> liste, membre membre){
        boolean action = false;
        System.out.println(" |Que Souhaitez vous faire? \n");
        while (! action){
            System.out.println(" |  [1] Afficher tout les Outils : ");
            System.out.println(" |  [2] ajouter un Outil : ");
            System.out.println(" |  [3] supprimer un Outil : ");
            System.out.println(" |  [4] Retour : ");
            System.out.print("\nEntrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : printeroutilAll(" |", liste, membre); break;
                case "2" : addInner(" |", liste); break;
                case "3" : suppInner(" |", liste); break ;
                case "4" : action = true; break;
                default : {
                    System.out.println
                    ("mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }*/
    public static void modifierOutilMembre(List<Outil> liste, Membre membre){
        boolean action = false;
        //System.out.println(" |Que Souhaitez vous faire? \n");
        while (! action){
            System.out.println(" |||  [1] Afficher tout les articles souscrit: ");
            System.out.println(" |||  [2] supprimer un article souscrit : ");
            System.out.println(" |||  [3] Retour : ");
            System.out.print("\n ||  Entrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : printeroutilAll(" |||  ", liste, membre); break;
                case "2" : suppInnerMembre(liste, membre); break ;
                case "3" : action = true; break;
                default : {
                    System.out.println
                    (" ||  mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }
    /*public static void addInner(String prefix, List<outil> liste){
        if (liste.size() > 0){
            System.out.print(prefix + "  Veuillez entrer un Outil a supprimer: ");
            String nom = scanner.nextLine();
            boolean BonProjet = false;
            for (int x = 0; x < listeOutil.size(); x++){
                if (nom.equals(listeOutil.get(x).Nom)){
                    System.out.println(prefix + "  " + listeOutil.get(x).Nom + "a ete ajoute");
                    liste.add(listeOutil.get(x));
                    BonProjet = true;
                    break;
                }
            }
            if (! BonProjet){
                System.out.println("\n" + prefix + "  Outil Introuvable.\n");
            }
        }
        else{
            System.out.println("\n" + prefix + "  Il n'y a aucun Outil danc cette liste\n");
        }
    }*/
    /*public static void suppInner(String prefix, List<outil> liste){
        if (listeOutil.size() > 0){
            System.out.print(prefix + "  Veuillez entrer un Outil a supprimer: ");
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
                System.out.println("\n" + prefix + "  Outil Introuvable.\n");
            }
        }
        else{
            System.out.println("\n" + prefix + "  Il n'y a aucun Outil danc cette liste\n");
        }
    }*/
    public static void suppInnerMembre(List<Outil> liste, Membre membre){
        if (liste.size() > 0){
            System.out.print(" |||  Veuillez entrer un outil a deSouscrire: ");
            String nom = scanner.nextLine();
            boolean BonProjet = false;
            for (int x = 0; x < liste.size(); x++){
                if (nom.equals(liste.get(x).Nom)){
                    System.out.println(" |||  " + liste.get(x).Nom + "a ete supprime");
                    souscription(false, membre, liste.get(x)); 
                    liste.remove(x);
                    BonProjet = true;
                    break;
                }
            }
            if (! BonProjet){
                System.out.println("\n |||  Outil Introuvable.\n");
            }
        }
        else{
            System.out.println("\n |||  Il n'y a aucun outil danc cette liste\n");
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
}
