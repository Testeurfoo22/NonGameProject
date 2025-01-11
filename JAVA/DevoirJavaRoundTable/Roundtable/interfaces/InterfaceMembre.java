package interfaces;

import controleurs.ControleurMembre;
import entites.utilisateurs.Membre;


public class InterfaceMembre extends InterfaceMainLoop {


    public InterfaceMembre(){

    }

    private static String[] options = {
        "  [1] Activite:",
        "  [2] Membre:",
        "  [3] Gestion Profil:",
        "  [4] Notification:",
        "  [5] Deconnection:",
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
                    ControleurMembre.modifier(compte);
                }; break ;
                case "4" : {
                    System.out.println("-------- GESTION NOTIF ---------------------------------------------------------");
                    ControleurMembre.printNotif(compte);
                }; break ;
                case "5" : {
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

}