package interfaces;

import java.util.Scanner;

import controleurs.ControleurInteret;
import controleurs.ControleurMembre;
import controleurs.activites.ControleurArticle;
import controleurs.activites.ControleurOutil;
import controleurs.activites.ControleurProjet;

import static java.lang.System.exit;

import entites.utilisateurs.Membre;
import entites.utilisateurs.Role;


public class InterfaceMainLoop {

    public static Scanner scanner = new Scanner(System.in);

    public static String[] TitleMenu = {
        "---------- ##### ##### #   # #   # ####  #####  ###  ####  #     ##### ---------",
        "---------- #   # #   # #   # ##  # #   #   #   #   # #   # #     #     ---------",
        "---------- ##### #   # #   # # # # #   #   #   ##### ####  #     ##### ---------",
        "---------- # #   #   # #   # #  ## #   #   #   #   # #   # #     #     ---------",
        "---------- #   # ##### ##### #   # ####    #   #   # ####  ##### ##### ---------",
    };

    public static void mainLoop() {
        Role.initRole(true);

        ControleurMembre.creationInitMembre();
        ControleurInteret.startListCreator();
        ControleurArticle.creationInitArticle();
        ControleurProjet.creationInitProjet();
        ControleurOutil.creationInitOutil();
    	
        //Affichage du nom de l'app
        for (String titre : TitleMenu){
            System.out.println(titre);
        }

        //affichage connection
        System.out.println("\nBienvenue sur Roundtable: ");

        Scanner scanner = new Scanner(System.in);
        while (true){
            System.out.println("--------------------------------------------------------------------------------");
        
            System.out.println("[1] Service de connection: ");
            System.out.println("[2] Service d'enregistrement: ");
            System.out.println("[3] Quitter le logiciel: ");
            System.out.print("\nEntrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : connection(); break;
                case "2" : ControleurMembre.newMember(); break;
                case "3" : {
                    scanner.close();
                    fermeture();
                }; break ;
                default : {
                    System.out.println("Cette action n'est pas valable, veuillez recommencer.");
                };
            }
        }
    }
    
    public static void Activite(Membre compte){
        boolean action = false;
        //System.out.println(" | Que Souhaitez vous faire? \n");
        while (! action){
            System.out.println(" |  [1] Article : ");
            System.out.println(" |  [2] Projet : ");
            System.out.println(" |  [3] Outil : ");
            System.out.println(" |  [4] Retour : ");
            System.out.print("\n | Entrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : ControleurArticle.affichagearticle(compte); break;
                case "2" : ControleurProjet.affichageprojet(compte); break ;
                case "3" : ControleurOutil.affichageoutil(compte);; break ;
                case "4" : action = true; break;
                default : {
                    System.out.println
                    (" | mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }
    

    public static void fermeture() {
        System.out.println("--------------------------------------------------------------------------------");
        System.out.println("Fermeture de Roundtable.");
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        exit(0);
    }
    public static void connection(){
        Scanner scanner = new Scanner(System.in);
        System.out.print("\n");
        System.out.println("--------------------------------------------------------------------------------");
        System.out.println
        ("------------Page de connection--------------------------------------------------");
        boolean action = false;
        System.out.println("--------------------------------------------------------------------------------");
        System.out.print("Veuillez entrer votre Mail Universitaire : ");
        String id = scanner.nextLine();
        System.out.print("Veuillez entrer votre Mdp : ");
        String mdp = scanner.nextLine();
        Membre compte = new Membre();
        for (int x = 0; x < ControleurMembre.listeMembre.size(); x++){
            if (id.equals(ControleurMembre.listeMembre.get(x).MailUni) && 
                mdp.equals(ControleurMembre.listeMembre.get(x).Mdp)){
                    if (("Actif").equals(ControleurMembre.listeMembre.get(x).Statut)){
                        compte = ControleurMembre.listeMembre.get(x);
                        action = true;
                        break;
                    }
                    else{
                        System.out.println("\nNous sommes navre, mais votre compte est Suspendu, veuillez prendre contact avec votre professeur");
                        break;
                    }
            }
        }
        if (action){
            switch (compte.Role.Id){
                case 01: {
                    System.out.println("\nconnection en cours.");
                    try {
                        Thread.sleep(1500);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    action = true;
                    InterfaceMembre adminLog = new InterfaceMembre();
                    adminLog.adminlogIn(compte); 
                }; break ;
                case 02 : {
                    System.out.println("\nconnection en cours.");
                    try {
                        Thread.sleep(1500);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    action = true;
                    InterfaceProfesseur adminLog = new InterfaceProfesseur();
                    adminLog.adminlogIn(compte);
                }; break ;
                case 03 : {
                    System.out.println("\nconnection en cours.");
                    try {
                        Thread.sleep(1500);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    action = true;
                    InterfaceAdmin adminLog = new InterfaceAdmin();
                    adminLog.adminlogIn(compte); 
                }; break ;
            }
        }
        else {
            System.out.println
            ("Votre identifiant ou mod de passe est errone(e), veuillez recommencer.");
        }
    } 
}
