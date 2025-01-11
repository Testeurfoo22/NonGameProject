package controleurs;
import java.util.Scanner;

import controleurs.activites.ControleurArticle;
import controleurs.activites.ControleurProjet;
import controleurs.activites.ControleurOutil;
import entites.Interet;
import entites.utilisateurs.Membre;

import java.util.ArrayList;
import java.util.List;


public class ControleurInteret {
    public static Scanner scanner = new Scanner(System.in);

    public static List<Interet> listeInteret = new ArrayList<>();
    public static boolean init = true;


    public static void startListCreator(){
        if (init){
            init = false;
            for (int x = 0; x < Interet.InitInteret.length; x++){
                listeInteret.add(new Interet(Integer.parseInt(Integer.toString(5) + Integer.toString(x+1)), Interet.InitInteret[x], Interet.InitInteretDesc[x]));
            }
        }
    }

    public static List<Interet> creationListeInteret(){
        printerAll("", listeInteret);
        List<Interet> listeInteretMembre = new ArrayList<>();
        System.out.println(" ");
        for (int x = 0; x < 5; x++){
            boolean interetTrouve = false;
            boolean listeterminee = false;
            while (! interetTrouve){
                System.out.print("Votre Interet No" + x + " : (null pour terminer la liste) ");
                String Interet = scanner.nextLine();
                if (Interet.equals("null")){
                    interetTrouve = true;
                    listeterminee = true;
                }
                else{
                    for (int y = 0; y < listeInteret.size(); y++){
                        if (Interet.equals(listeInteret.get(y).Nom)){
                            listeInteretMembre.add(listeInteret.get(x));
                            interetTrouve = true;
                            break;
                        }
                    }
                    if (! interetTrouve){
                        System.out.println("Interet Introuvable.");
                    }
                }
            }
            if (listeterminee){
                break;
            }
        }
        System.out.print("\ninteret a ete cree avec succes : \n");
        return listeInteretMembre;
    }

    public static void add(String prefix, List<Interet> liste){
        if (listeInteret == liste || liste.size() < 5){
            System.out.print(prefix + "Veuillez entrer un Interet : ");
            String interet = textCreator(50);
            System.out.print(prefix + "Veuillez entrer une Description : ");
            String description = textCreator(250);
            liste.add(new Interet(Integer.parseInt(Integer.toString(4) + Integer.toString(listeInteret.size() + 1)), interet, description));
            System.out.println(prefix + "interet a ete ajoute avec succes : \n");
        }
        else{
            System.out.println(prefix + "impossible d'ajouter un interet, plus de place : \n");
        }
    }
    public static void modifier(String prefix, List<Interet> liste){
        boolean BonInteret = false;
        while(! BonInteret){
            System.out.print(prefix + "Veuillez entrer un Interet : (Retour pour annuler)");
            String interet = scanner.nextLine();
            if (! interet.equals("Retour")){
                for (int x = 0; x < liste.size(); x++){
                    if (interet.equals(liste.get(x).Nom)){
                        System.out.print(prefix + "Veuillez entrer la nouvelle donnee : ");
                        String newInteret = scanner.nextLine();
                        System.out.print(prefix + "Veuillez entrer la nouvelle Description : ");
                        String description = scanner.nextLine();
                        liste.get(x).Nom = newInteret;
                        liste.get(x).Desciption = description;
                        BonInteret = true;
                        System.out.print(prefix + "interet a ete modifie avec succes : \n");
                        break;
                    }
                }
                if (! BonInteret){
                    System.out.println("\n" + prefix + "Interet Introuvable.\n");
                }
            }
        }
    }
    public static void supp(String prefix, List<Interet> liste){
        boolean BonInteret = false;
        while(! BonInteret){
            System.out.print(prefix + "Veuillez entrer un Interet a supprimer: ");
            String nom = scanner.nextLine();
            for (int x = 0; x < liste.size(); x++){
                if (nom.equals(liste.get(x).Nom)){
                    liste.remove(x);
                    BonInteret = true;
                    System.out.print(prefix + "interet a ete supprime avec succes : \n");
                    break;
                }
            }
            if (! BonInteret){
                System.out.println("\n" + prefix + "Interet Introuvable.\n");
            }
        }
    }
    public static void modifierInteret(List<Interet> liste){
        boolean action = false;
        //System.out.println(" |Que Souhaitez vous faire? \n");
        while (! action){
            System.out.println(" |||  [1] Afficher tout les Interets : ");
            System.out.println(" |||  [2] ajouter un Interet : ");
            System.out.println(" |||  [3] modifier un Interet : ");
            System.out.println(" |||  [4] supprimer un Interet : ");
            System.out.println(" |||  [5] Retour : ");
            System.out.print("\n ||  Entrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : printerAll(" |||", liste); break;
                case "2" : add(" |||", liste); break;
                case "3" : modifier(" |||", liste); break ;
                case "4" : supp(" |||", liste); break ;
                case "5" : action = true; break;
                default : {
                    System.out.println
                    (" ||  mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }
    public static void printerAll(String prefix, List<Interet> liste){
        System.out.println(prefix + "| --les interets--");
        if (liste.size() != 0){
            for (int x = 0; x < liste.size(); x++){
                System.out.println(prefix + liste.get(x).Nom);
            }
        }
        else{
            System.out.println(prefix + "Pas d'interets");
        }
    }

    public static void printOutilInteret(Membre membre){
        printerAll(" |||  ", listeInteret);
        System.out.println("");
        boolean BonInteret = false;
        while(! BonInteret){
            System.out.print(" ||| Veuillez entrer un Interet : ");
            String nom = scanner.nextLine();
            for (int x = 0; x < listeInteret.size(); x++){
                if (nom.equals(listeInteret.get(x).Nom)){
                    for (int y = 0; y < ControleurOutil.listeOutil.size(); y++){
                        for (int z = 0; z < ControleurOutil.listeOutil.get(y).Interet.size(); z++){
                            if (nom.equals(ControleurOutil.listeOutil.get(y).Interet.get(z).Nom)){
                                ControleurOutil.affichageoutilComplet(" |||  ", false, ControleurOutil.listeOutil.get(y), membre);
                            }
                        }
                    }
                    BonInteret = true;
                    break;
                }
            }
            if (! BonInteret){
                System.out.println(" ||| Interet Introuvable.");
            }
        }
    } 
    public static void printProjetInteret(Membre membre){
        printerAll(" |||  ", listeInteret);
        System.out.println("");
        boolean BonInteret = false;
        while(! BonInteret){
            System.out.print(" ||| Veuillez entrer un Interet : ");
            String nom = scanner.nextLine();
            for (int x = 0; x < listeInteret.size(); x++){
                if (nom.equals(listeInteret.get(x).Nom)){
                    for (int y = 0; y < ControleurProjet.listeProjet.size(); y++){
                        for (int z = 0; z < ControleurProjet.listeProjet.get(y).Interet.size(); z++){
                            if (nom.equals(ControleurProjet.listeProjet.get(y).Interet.get(z).Nom)){
                                ControleurProjet.affichageprojetComplet(" |||  ", false, ControleurProjet.listeProjet.get(y), membre);
                            }
                        }
                    }
                    BonInteret = true;
                    break;
                }
            }
            if (! BonInteret){
                System.out.println(" ||| Interet Introuvable.");
            }
        }
    } 
    public static void printArticleInteret(Membre membre){
        printerAll(" |||  ", listeInteret);
        System.out.println("");
        boolean BonInteret = false;
        while(! BonInteret){
            System.out.print(" ||| Veuillez entrer un Interet : ");
            String nom = scanner.nextLine();
            for (int x = 0; x < listeInteret.size(); x++){
                if (nom.equals(listeInteret.get(x).Nom)){
                    for (int y = 0; y < ControleurArticle.listeArticle.size(); y++){
                        for (int z = 0; z < ControleurArticle.listeArticle.get(y).Interet.size(); z++){
                            if (nom.equals(ControleurArticle.listeArticle.get(y).Interet.get(z).Nom)){
                                ControleurArticle.affichagearticleComplet(" |||  ", false, ControleurArticle.listeArticle.get(y), membre);
                            }
                        }
                    }
                    BonInteret = true;
                    break;
                }
            }
            if (! BonInteret){
                System.out.println(" ||| Interet Introuvable.");
            }
        }
    } 
    public static void printMembreInteret(){
        printerAll(" |||  ", listeInteret);
        System.out.println("");
        boolean BonInteret = false;
        while(! BonInteret){
            System.out.print(" ||| Veuillez entrer un Interet : ");
            String nom = scanner.nextLine();
            for (int x = 0; x < listeInteret.size(); x++){
                if (nom.equals(listeInteret.get(x).Nom)){
                    for (int y = 0; y < ControleurMembre.listeMembre.size(); y++){
                        for (int z = 0; z < ControleurMembre.listeMembre.get(y).interet.size(); z++){
                            if (nom.equals(ControleurMembre.listeMembre.get(y).interet.get(z).Nom)){
                                ControleurMembre.affichagemembreComplet(" |||  ", false, ControleurMembre.listeMembre.get(y));
                            }
                        }
                    }
                    BonInteret = true;
                    break;
                }
            }
            if (! BonInteret){
                System.out.println(" ||| Interet Introuvable.");
            }
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
