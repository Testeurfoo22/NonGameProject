package interfaces;

import controleurs.ControleurInteret;
import controleurs.ControleurMembre;
import controleurs.activites.ControleurArticle;
import entites.utilisateurs.Membre;

public class InterfaceProfesseur extends InterfaceMainLoop {


    public InterfaceProfesseur(){

    }

    private static String[] options = {
        "  [1] Activite:",
        "  [2] Membre:",
        "  [3] Gestion Interet:",
        "  [4] Gestion Profil:",
        "  [5] Gestion Article superviseur",
        "  [6] Notification:",
        "  [7] Deconnection:",
    };

    public void adminlogIn(Membre compte){
        System.out.print("\n");
        for (String titre : InterfaceMainLoop.TitleMenu){
            System.out.println(titre);
        }
        System.out.println("\nBon retour " + compte.Prenom + " " + compte.Nom + "(" + compte.Role.Nom + ") \n");
        while (true){
            System.out.println
            ("ATTENTION, UNE NOTATION EXACTE DES DONNEES EST ACTUELLEMENT OBLIGATOIRE");
            System.out.println
            ("---- ACCUEIL -------------------------------------------------------------------");
            System.out.println("Que Souhaitez vous faire? \n");
            for (String titre : options){
                System.out.println(titre);
            }
            System.out.print("\nEntrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : {
                    System.out.println("-------- ACTIVITE --------------------------------------------------------------");
                    Activite(compte);
                }; break;
                case "2" : {
                    ControleurMembre.affichagemembre();
                 }; break ;
                case "3" : {
                    System.out.println("-------- GESTION INTERET -------------------------------------------------------");
                    gestionInteret();
                }; break ;
                case "4" : {
                    ControleurMembre.modifier(compte);
                }; break ;
                case "5" : {
                    System.out.println("-------- GESTION ARTICLE SUPERVISEUR -------------------------------------------");
                    ControleurArticle.ajoutArticle(compte);
                }; break ;
                case "6" : {
                    System.out.println("-------- GESTION NOTIF ---------------------------------------------------------");
                    ControleurMembre.printNotif(compte);
                }; break ;
                case "7" : {
                    System.out.println("\nDECONNECTION!\n");
                    try {
                        Thread.sleep(1500);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    InterfaceMainLoop.mainLoop(); break ;
                }
                default : {
                    System.out.println("Cette action n'est pas valable, veuillez recommencer.\n");
                };
            }
        }
    }

    public static void gestionInteret(){
        boolean action = false;
        //System.out.println(" |Que Souhaitez vous faire? \n");
        while (! action){
            System.out.println(" |  [1] Afficher tout les Interets des donnees generales : ");
            System.out.println(" |  [2] ajouter un Interet des donnees generales : ");
            System.out.println(" |  [3] modifier un Interet des donnees generales : ");
            System.out.println(" |  [4] supprimer un Interet des donnees generales : ");
            System.out.println(" |  [5] Retour : ");
            System.out.print("\n | Entrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : ControleurInteret.printerAll(" ||  ", ControleurInteret.listeInteret); break;
                case "2" : ControleurInteret.add(" ||  ", ControleurInteret.listeInteret); break;
                case "3" : ControleurInteret.modifier(" ||  ", ControleurInteret.listeInteret); break ;
                case "4" : ControleurInteret.supp(" ||  ", ControleurInteret.listeInteret); break ;
                case "5" : action = true; break;
                default : {
                    System.out.println
                    (" | mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }
}