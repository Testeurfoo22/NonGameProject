package controleurs.activites;
import java.util.Scanner;

import controleurs.ControleurInteret;
import controleurs.ControleurMembre;
import entites.Interet;
import entites.activites.Projet;
import entites.utilisateurs.Membre;
import entites.utilisateurs.Role;

import java.util.ArrayList;
import java.util.List;

import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime; 


public class ControleurProjet {
    
    public static Scanner scanner = new Scanner(System.in);

    public static List<Projet> listeProjet = new ArrayList<>();
    public static boolean init = true;

    
    public static void creationInitProjet(){
        if (init){
            init = false;
            List<Interet> listeInteret = new ArrayList<>();
            List<Membre> listemembre = new ArrayList<>();
            List<Interet> listeinteret2 = new ArrayList<>();
            listeinteret2.add(ControleurInteret.listeInteret.get(0));
            listeProjet.add(new Projet(31, "projet1", "description du projet 1", "01/01/2002",
                 "01/01/0221", ControleurMembre.listeMembre.get(0), "les partenaires", listemembre
                 , "Publique", listeInteret, "", listemembre));
            listeProjet.add(new Projet(32, "projet 2", "description du projet 2", "02/02/2022",
                 "02/02/0222", ControleurMembre.listeMembre.get(0), "Les Partenaires",
                 listemembre, "Publique", listeinteret2, "", listemembre));
        }
    }

    public static void newProjet(Membre membre){
        if (membre.Role.equals(Role.listeRole.get(1))){
            System.out.println("merci de remplir les fnormation de votre projet : \n");
            System.out.print("le titre de votre projet :");
            String Titre = textCreator(50);
            System.out.print("la Description de votre projet :");
            String Desc = textCreator(500);
            System.out.print("la Periode de debut (YYYY-MM-DD) :");
            String Debut = dateCreator ();
            System.out.print("la Periode de fin (YYYY-MM-DD) :");
            String Fin = dateCreator ();
            Membre Prof = ControleurMembre.findmembre("Professeur");
            List<Membre> ListMembre = ControleurMembre.creationListemembre(true, "Membre (Hors Prof)");
            System.out.print("les Partenaires :");
            String part = scanner.nextLine();
            List<Interet> ListeInteret = ControleurInteret.creationListeInteret();
            System.out.print("Ecrivez Vos Mots cle Ici (en une fois) :");
            String Motscle = textCreator(40);
            List<Membre> Souscrit = new ArrayList<>();
            Souscrit.add(Prof);
            Souscrit.addAll(ListMembre);
            System.out.println("Voulez-vous Creer ce projet? Yes ou No :");
            String reponse = scanner.nextLine();
            switch(reponse){
                case "Yes" : {
                    listeProjet.add(new Projet(Integer.parseInt(Integer.toString(3) + Integer.toString(listeProjet.size() + 1)), Titre, Desc, Debut, Fin, 
                    Prof, part, ListMembre, "Publique", ListeInteret, Motscle, Souscrit));
                    for (int y = 0; y < listeProjet.get(listeProjet.size()-1).Souscrit.size(); y++){
                        listeProjet.get(listeProjet.size()-1).Souscrit.get(y).projet.add(listeProjet.get(listeProjet.size()-1));
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
        else {
            System.out.println("impossibilite de creer un projet, vous n'avez pas les droits\n");
        }
    }
    public static void supp(Membre membre, String prefix, List<Projet> liste){
        System.out.print(prefix + "  Veuillez entrer un Projet a supprimer: ");
        String nom = scanner.nextLine();
        boolean BonProjet = false;
        for (int x = 0; x < liste.size(); x++){
            System.out.println(prefix + "  " + liste.get(x).Nom);
            if (nom.equals(liste.get(x).Nom)){
                sendnotif(membre, liste.get(x), "a ete supprime.");
                liste.remove(x);
                BonProjet = true;
                break;
            }
        }
        if (! BonProjet){
            System.out.println("\n" + prefix + "  Projet Introuvable.\n");
        }
    }
    public static void affichageprojet(Membre membre){
        System.out.println("-------------projets de Roundtable-------------------");
        //System.out.println("\nAffichage des projets de Roundtable : \n");
        boolean action = false;
        while (! action){
            System.out.println(" ||  [1] Afficher tout les projets : ");
            System.out.println(" ||  [2] Recherche par Responsable : ");
            System.out.println(" ||  [3] Recherche par Interet : ");
            System.out.println(" ||  [4] Affichage profil Complet (Titre) : ");
            System.out.println(" ||  [5] creer un Projet : ");
            System.out.println(" ||  [6] Mes Projets : ");
            System.out.println(" ||  [7] Retour : ");
            System.out.print("\n || que voulez vous faire : ");
            String Value = scanner.nextLine();
            switch(Value){
                case "1" : {
                    System.out.println("\n |||  --TOUT LES PROJETS--");
                    printerprojetAll(" |||  ", listeProjet, membre);
                    System.out.println(" |||  --------------------\n");
                }; break;
                case "2" : {
                    System.out.print(" ||| Notez le Nom du Responsable : ");
                    String Nom = scanner.nextLine();
                    boolean resultat = false;
                    System.out.println("\n |||  --LES RESULTATS--");
                    for (int x = 0; x < listeProjet.size(); x++){
                        if (listeProjet.get(x).Responsable.Nom.contains(Nom)){
                                affichageprojetComplet(" |||  ", false, listeProjet.get(x), membre);
                            resultat = true;
                        }
                    }
                    System.out.println(" |||  -----------------\n");
                    if (! resultat){
                        System.out.println(" ||| Aucun resultat, ou erreur d'ecriture\n");
                    }
                }; break ;
                case "3" : {
                    System.out.println("");
                    ControleurInteret.printProjetInteret(membre);
                    System.out.println("");
                }; break;
                case "4" : {
                    System.out.print("\n ||| Notez le Titre : ");
                    String Nom = scanner.nextLine();
                    boolean resultat = false;
                    for (int x = 0; x < listeProjet.size(); x++){
                        if (listeProjet.get(x).Nom.contains(Nom)){
                            resultat = true;
                            System.out.println(" |||  --LE RESULTAT--");
                            affichageprojetComplet(" |||  ", true, listeProjet.get(x), membre);
                            System.out.println(" |||  ---------------");
                            if (! listeProjet.get(x).Souscrit.contains(membre)){
                                System.out.print("Voulez-vous souscrire a ce projet? (Y ou N) -> ");
                                String reponse = scanner.nextLine();
                                switch(reponse){
                                    case "Y" : {
                                        System.out.println("\n ||| Souscription effectuee\n");
                                        listeProjet.get(x).Souscrit.add(membre);
                                        membre.projet.add(listeProjet.get(x));
    
                                    };break;
                                    default : {
                                        System.out.println("");
                                    };
                                }
                                break;
                            }
                        }
                    }
                    if (! resultat){
                        System.out.println(" ||| Aucun resultat, ou erreur d'ecriture\n");
                    }
                }; break ;
                case "5" : newProjet(membre); break;
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
    public static void printerprojetAll(String prefix, List<Projet> liste, Membre membre){              
        if (liste.size() != 0){
            for (int x = 0; x < liste.size(); x++){
                affichageprojetComplet(prefix, false, liste.get(x), membre);
            }      
        }
        else{
            System.out.println(prefix + " pas de projets, ou de projets public.");
        }
    }
    public static void affichageprojetComplet(String prefix, boolean complet, Projet liste, Membre membre){
        if (liste.Visibilite.equals("Publique") || liste.Responsable.equals(membre) || liste.Membres.contains(membre)){
            System.out.println(prefix + "--------------------");
            System.out.println(prefix + "Titre : " + liste.Nom);
            System.out.println(prefix + "le Responsable : ----");
            ControleurMembre.affichagemembreComplet(prefix, false, liste.Responsable);
            if (complet){
                System.out.println(prefix + "la Description : " + liste.Description);
                System.out.println(prefix + "Periode de Projet : " + liste.PeriodeDebut + "/" + liste.PeriodeFin);
                System.out.println(prefix + "les Partenaires : " + liste.Partenaires);
                ControleurInteret.printerAll(prefix, membre.interet);
            }
            System.out.println(prefix + "--------------------");
        }
    }
    /*public static void affichageprojetInteret(projet liste, membre membre){
        if (liste.Visibilite.equals("Publique") || liste.Responsable.equals(membre) || liste.Membres.contains(membre)){
            System.out.println("--------------------");
            System.out.println("Titre : " + liste.Nom);
            System.out.println("le Responsable : ----");
            membre.affichagemembreComplet("", false, liste.Responsable);
            System.out.println("le Professeur : ----");
        }
    }*/
    public static void sendnotif(Membre auteur, Projet projet, String postfix){
        System.out.print("\nVeuillez ecrire un descriptif de vos Actions: ");
        String Description = scanner.nextLine();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
        LocalDateTime now = LocalDateTime.now(); 
        for (int y = 0; y < projet.Souscrit.size(); y++){
            System.out.print("oui");
            projet.Souscrit.get(y).notif.add
                (auteur.Nom  + " " + dtf.format(now) + " " + projet.Nom + " " + postfix + "\n      " + Description);
        }
    }





    /*public static void affichageprojetProf(membre membre){
        System.out.println("-------------projets de Roundtable-------------------");
        //System.out.println("\nAffichage des projets de Roundtable : \n");
        boolean action = false;
        while (! action){
            System.out.println(" ||  [1] Afficher tout les projets : ");
            System.out.println(" ||  [2] Recherche par Titre ou Auteur ou MotCle : ");
            System.out.println(" ||  [3] Recherche par Interet : ");
            System.out.println(" ||  [4] Affichage profil Complet (Titre) : ");
            System.out.println(" ||  [5] creer un Projet : ");
            System.out.println(" ||  [6] Mes Projets : ");
            System.out.println(" ||  [7] Retour : ");
            System.out.print("\n || que voulez vous faire : ");
            String Value = scanner.nextLine();
            switch(Value){
                case "1" : {
                    System.out.println("\n |||  --TOUT LES PROJETS--");
                    printerprojetAll(" |||  ", listeProjet, membre);
                    System.out.println(" |||  --------------------\n");
                }; break;
                case "2" : {
                    System.out.print(" ||| Notez le titre ou l'auteur ou un Motcle : ");
                    String Nom = scanner.nextLine();
                    boolean resultat = false;
                    System.out.println("\n |||  --LES RESULTATS--");
                    for (int x = 0; x < listeProjet.size(); x++){
                        if (listeProjet.get(x).Responsable.Nom.contains(Nom)){
                                affichageprojetComplet(" |||  ", false, listeProjet.get(x), membre);
                            resultat = true;
                        }
                    }
                    System.out.println(" |||  -----------------\n");
                    if (! resultat){
                        System.out.println(" ||| Aucun resultat, ou erreur d'ecriture\n");
                    }
                }; break ;
                case "3" : {
                    System.out.println("");
                    interet.printProjetInteret(membre);
                    System.out.println("");
                }; break;
                case "4" : {
                    System.out.print("\n ||| Notez le Titre : ");
                    String Nom = scanner.nextLine();
                    boolean resultat = false;
                    for (int x = 0; x < listeProjet.size(); x++){
                        if (listeProjet.get(x).Nom.contains(Nom)){
                            System.out.println(" |||  --LE RESULTAT--");
                            affichageprojetComplet(" |||  ", true, listeProjet.get(x), membre);
                            System.out.println(" |||  ---------------");
                            System.out.print("Voulez-vous souscrire a ce projet? (Y ou N) -> ");
                            String reponse = scanner.nextLine();
                            switch(reponse){
                                case "Y" : {
                                    System.out.println("\n ||| Souscription effectuee\n");
                                    listeProjet.get(x).Souscrit.add(membre);
                                    membre.projet.add(listeProjet.get(x));

                                };break;
                                default : {
                                    System.out.println("");
                                };
                            }
                            resultat = true;
                            break;
                        }
                    }
                    if (! resultat){
                        System.out.println(" ||| Aucun resultat, ou erreur d'ecriture\n");
                    }
                }; break ;
                case "5" : newProjet(membre); break;
                case "6" : modifier(membre); break;
                case "7" : action = true; break ;
                default : {
                    System.out.println
                    (" || mauvais numero, veuillez ressayer.\n");
                };
            }
        }
        System.out.println("");
    }*/
    public static void souscription(boolean souscription, Membre membre, Projet projet){
        if (souscription){
            projet.Souscrit.add(membre);
            System.out.println("Souscription ajoutee.\n");
        }
        else{
            projet.Souscrit.remove(membre);
            System.out.println("Souscription retiree.\n");
        }
    }
    public static void modifier(Membre Membre){
        boolean action = false;
        while (! action){
            System.out.println("\n |||  [1] Voir mes projets : ");
            System.out.println(" |||  [2] Modifier un projet : ");
            System.out.println(" |||  [3] Retour : ");
            System.out.print("\n ||| Entrez votre numero -> ");
            String Value = scanner.nextLine();
            switch(Value){
                case "1" : {
                    for (int x = 0; x < listeProjet.size(); x++){
                        if (listeProjet.get(x).Responsable.equals(Membre)){
                            System.out.println(" ||||  --Vous etes Responsable--");
                            affichageprojetComplet(" ||||  ", false, listeProjet.get(x), Membre);
                            System.out.println(" ||||  -------------------------");
                        }
                        else if (listeProjet.get(x).Membres.equals(Membre)){
                            System.out.println(" ||||  --Vous etes un Membre--");
                            affichageprojetComplet(" ||||  ", false, listeProjet.get(x), Membre);
                            System.out.println(" ||||  -----------------------");
                        }
                    }
                }; break;
                case "2" : {
                    boolean BonProjet = false;
                    while(! BonProjet){
                        System.out.print(" |||| Veuillez entrer un Projet a modifier (Titre) : ");
                        String nom = scanner.nextLine();
                        for (int x = 0; x < listeProjet.size(); x++){
                            if (nom.equals(listeProjet.get(x).Nom)){
                                BonProjet = true;
                                    if (listeProjet.get(x).Responsable.equals(Membre)){
                                        System.out.println(" ");
                                        System.out.println(" ||||  [1] Titre : ");
                                        System.out.println(" ||||  [2] Description : ");
                                        System.out.println(" ||||  [3] PeriodeDebut : ");
                                        System.out.println(" ||||  [4] PeriodeFin : ");
                                        System.out.println(" ||||  [5] Partenaires : ");
                                        System.out.println(" ||||  [6] Membres : ");
                                        System.out.println(" ||||  [7] Visibilite : ");
                                        System.out.println(" ||||  [8] Interet : ");
                                        System.out.println(" ||||  [9] MotsCle : ");
                                        System.out.println(" ||||  [10] supprimer : ");
                                        System.out.println(" ||||  [11] Retour : ");
                                        boolean action2 = false;
                                        boolean modification = false;
                                        while(! action2){
                                            System.out.print("\n |||| Entrez votre numero -> ");
                                            String donnee = scanner.nextLine();
                                            switch(donnee){
                                                case "1" : {
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeProjet.get(x).Nom = textCreator(50);
                                                    modification = true;
                                                };break;
                                                case "2" : {
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeProjet.get(x).Description = textCreator(500); 
                                                    modification = true;
                                                 }; break;
                                                case "3" : {
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeProjet.get(x).PeriodeDebut = dateCreator (); modification = true;
                                                }; break;
                                                case "4" : {
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeProjet.get(x).PeriodeFin = dateCreator (); modification = true;
                                                }; break;
                                                case "5" : {
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeProjet.get(x).Partenaires = scanner.nextLine(); modification = true;
                                                }; break;
                                                case "6" : ControleurMembre.modifierMembre(listeProjet.get(x).Membres); modification = true; break;
                                                case "7" : {
                                                    System.out.println(" ||||  [1] Publique: \n ||||  [2] Prive : ");
                                                    System.out.print(" |||| Veuillez entrer le nouveau statut : ");
                                                    String role = scanner.nextLine();
                                                    switch(role){
                                                        case "1" : {
                                                            System.out.println(" |||| Statut modifie avec succes.\n");   
                                                            listeProjet.get(x).Visibilite = "Publique";
                                                            modification = true;
                                                        }; break;
                                                        case "2" : {
                                                            System.out.println(" |||| Statut modifie avec succes.\n");   
                                                            listeProjet.get(x).Visibilite = "Prive";
                                                            modification = true;
                                                        }; break;
                                                        default :{
                                                            System.out.println(" |||| Cette action n'est pas valable, veuillez recommencer.");
                                                            modification = true;
                                                        }
                                                    }
                                                }; break;
                                                case "8" : ControleurInteret.modifierInteret(listeProjet.get(x).Interet); modification = true; break;
                                                case "9" : {
                                                    System.out.print(" |||| Votre nouvelle donnee : ");
                                                    listeProjet.get(x).MotsCle = scanner.nextLine(); modification = true;
                                                }; break;
                                                case "10" : {
                                                    action = true;
                                                    action2 = true; 
                                                    modification = false;
                                                    System.out.println(" |||| projet Supprime"); 
                                                    sendnotif(Membre, listeProjet.get(x), "a ete supprime.");
                                                    listeProjet.remove(x); 
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
                                            sendnotif(Membre, listeProjet.get(x), "a ete modifie.");
                                            System.out.println(" |||| modification effectue avec succes.\n");
                                        }
                                        System.out.println(" ");
                                        break;
                                    }
                                    else{
                                        System.out.println(" |||| Impossible de modifier ce projet\n");
                                    }
                            }
                        }
                        if (! BonProjet){
                            BonProjet = true;
                            System.out.println("\n |||| projet Introuvable.\n");
                        }
                    }
                }; break;
                case "3" : action = true; break ;
                default : {
                    System.out.println
                    (" |||| mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }
    /*public static void modifierProjet(List<projet> liste, membre membre){
        boolean action = false;
        System.out.println(" |Que Souhaitez vous faire? \n");
        while (! action){
            System.out.println(" |  [1] Afficher tout les projet : ");
            System.out.println(" |  [2] ajouter un projet : ");
            System.out.println(" |  [3] modifier un projet : ");
            System.out.println(" |  [4] supprimer un projet : ");
            System.out.println(" |  [5] Retour : ");
            System.out.print("\nEntrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : printerprojetAll(" |", liste, membre); break;
                case "2" : addInner(" |", liste); break;
                case "3" : suppInner(" |", liste); break ;
                case "4" : supp(" |", liste); break ;
                case "5" : action = true; break;
                default : {
                    System.out.println
                    ("mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }*/
    public static void modifierProjetMembre(List<Projet> liste, Membre membre){
        boolean action = false;
        //System.out.println(" ||  Que Souhaitez vous faire? \n");
        while (! action){
            System.out.println(" |||  [1] Afficher tout les projets souscrit: ");
            System.out.println(" |||  [2] supprimer un projet souscrit : ");
            System.out.println(" |||  [3] Retour : ");
            System.out.print("\n ||  Entrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : printerprojetAll(" |||", liste, membre); break;
                case "2" : suppInnerMembre(liste, membre); break ;
                case "3" : action = true; break;
                default : {
                    System.out.println
                    (" ||  mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }
    /*public static void addInner(String prefix, List<projet> liste){
        if (liste.size() > 0){
            System.out.print(prefix + "  Veuillez entrer un projet a supprimer: ");
            String nom = scanner.nextLine();
            boolean BonProjet = false;
            for (int x = 0; x < listeProjet.size(); x++){
                if (nom.equals(listeProjet.get(x).Nom)){
                    System.out.println(prefix + "  " + listeProjet.get(x).Nom + "a ete ajoute");
                    liste.add(listeProjet.get(x));
                    BonProjet = true;
                    break;
                }
            }
            if (! BonProjet){
                System.out.println("\n" + prefix + "  projet Introuvable.\n");
            }
        }
        else{
            System.out.println("\n" + prefix + "  Il n'y a aucun projet danc cette liste\n");
        }
    }*/
    /*public static void suppInner(String prefix, List<projet> liste){
        if (listeProjet.size() > 0){
            System.out.print(prefix + "  Veuillez entrer un projet a supprimer: ");
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
                System.out.println("\n" + prefix + "  projet Introuvable.\n");
            }
        }
        else{
            System.out.println("\n" + prefix + "  Il n'y a aucun projet danc cette liste\n");
        }
    }*/
    public static void suppInnerMembre(List<Projet> liste, Membre membre){
        if (liste.size() > 0){
            System.out.print(" |||  Veuillez entrer un projet a deSouscrire: ");
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
                System.out.println("\n |||  projet Introuvable.\n");
            }
        }
        else{
            System.out.println("\n |||  Il n'y a aucun projet danc cette liste\n");
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
