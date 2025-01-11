package interfaces;

import controleurs.ControleurMembre;
import controleurs.activites.ControleurOutil;
import controleurs.activites.ControleurArticle;
import controleurs.activites.ControleurProjet;
import entites.utilisateurs.Membre;


public class InterfaceAdmin extends InterfaceMainLoop {

    

    public InterfaceAdmin(){

    }

    private static String[] options = {
        "  [1] Activite:",
        "  [2] Membre:",
        "  [3] Gestion Administrative Activite:",
        "  [4] Gestion Administrative Membre:",
        "  [5] Gestion Profil:",
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
            System.out.println("---- ACCUEIL -------------------------------------------------------------------");
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
                    System.out.println("-------- GESTION ADMIN ACTIVITE ------------------------------------------------");
                    gestionActivite(compte);
                }; break ;
                case "4" : {
                    System.out.println("-------- GESTION ADMIN MEMBRE --------------------------------------------------");
                    gestionMembre();
                }; break;
                case "5" : {
                    ControleurMembre.modifier(compte);
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

    public static void gestionActivite(Membre membre){
        boolean action = false;
        System.out.println("--Que Souhaitez vous faire? \n");
        while (! action){
            System.out.println("    [1] supprimer un Article des donnees generales : ");
            System.out.println("    [2] supprimer un Projet des donnees generales : ");
            System.out.println("    [3] supprimer un Outil des donnees generales : ");
            System.out.println("    [4] Retour : ");
            System.out.print("\nEntrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : ControleurArticle.supp(membre, " ", ControleurArticle.listeArticle); break;
                case "2" : ControleurProjet.supp(membre, " ", ControleurProjet.listeProjet); break ;
                case "3" : ControleurOutil.supp(membre, " ", ControleurOutil.listeOutil); break ;
                case "4" : action = true; break;
                default : {
                    System.out.println
                    ("mauvais numero, veuillez ressayer.\n");
                };
            }
        }
    }
    public static void gestionMembre(){
        boolean retour = false;
        System.out.println(" |Que Souhaitez vous faire? \n");
        while (! retour){
            System.out.println(" |  [1] Modifier membre: \n |  [2] Ajouter Membre: \n |  [3] Retour: ");
            System.out.print("\nEntrez votre numero -> ");
            String choix = scanner.nextLine();
            switch (choix){
                case "1" : {
                    System.out.print("Veuillez entrer le nom du membre a modifier : ");
                    String membreString = scanner.nextLine();
                    Membre membremodifiable = new Membre();
                    boolean action = false;
                    for (int x = 0; x < ControleurMembre.listeMembre.size(); x++){
                        if (membreString.equals(ControleurMembre.listeMembre.get(x).Nom)){
                            membremodifiable = ControleurMembre.listeMembre.get(x);
                                action = true;
                                break;
                        }
                    }
                    if (action){
                        boolean retour2 = false;
                        ControleurMembre.affichagemembreComplet(" |  ", false, membremodifiable);
                        System.out.println("Role : " + membremodifiable.Role);
                        System.out.println("Statut : " + membremodifiable.Statut);
                        while (! retour2){
                            System.out.println();
                            System.out.println
                            (" |    [1] Modifier role: \n |    [2] Modifier statut: \n |    [3] retour:");
                            System.out.print("\n |  Entrez votre numero -> ");
                            String choix2 = scanner.nextLine();
                            switch (choix2){
                                case "1" : {
                                    System.out.println(" |    [1] Membre: " + Membre.membreroleDesc[0] + 
                                        " \n |    [2] Professeur: " + Membre.membreroleDesc[1] + " \n |    [3] Administrateur: " + Membre.membreroleDesc[2]);
                                    System.out.print("Veuillez entrer le nouveau role : ");
                                    String role = scanner.nextLine();
                                    switch(role){
                                        case "1" : {
                                            System.out.println("Role modifie avec succes.\n");
                                            membremodifiable.Role.Id = 01;
                                        }; break;
                                        case "2" : {
                                            System.out.println("Role modifie avec succes.\n");
                                            membremodifiable.Role.Id = 02;
                                        }; break;
                                        case "3" : {
                                            System.out.println("Role modifie avec succes.\n");
                                            membremodifiable.Role.Id = 03;
                                        }; break;
                                        default :{
                                            System.out.println("Cette action n'est pas valable, veuillez recommencer.");
                                        }
                                    }
                                    retour2 = true;
                                }; break;
                                case "2" : {
                                    System.out.println(" |    [1] Actif: \n |    [2] Suspendu : ");
                                    System.out.print("Veuillez entrer le nouveau statut : ");
                                    String role = scanner.nextLine();
                                    switch(role){
                                        case "1" : {
                                            System.out.println("Statut modifie avec succes.\n");   
                                            membremodifiable.Statut = "Actif";
                                        }; break;
                                        case "2" : {
                                            System.out.println("Statut modifie avec succes.\n");   
                                            membremodifiable.Statut = "Suspendu";
                                        }; break;
                                        default :{
                                            System.out.println("Cette action n'est pas valable, veuillez recommencer.");
                                        }
                                    }
                                    retour2 = true;
                                }; break;
                                case "3" : retour2 = true; break;
                                default : {
                                    System.out.println("Cette action n'est pas valable, veuillez recommencer.");
                                };
                            }
                        }
                    }
                    else {
                        System.out.println
                        ("Votre membre est introuvable.");
                    }
                }; break;
                case "2" : {
                    ControleurMembre.ajoutMembre();
                }
                case "3" : retour = true; break;
                default : {
                    System.out.println("Cette action n'est pas valable, veuillez recommencer.");
                };
            }
        }
    }
}
