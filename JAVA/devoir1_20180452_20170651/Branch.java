//Pour les mouvements de compte, l'ouverture et la fermeture, les supppréssions et le solde de départ
public class Branch extends Bank{

    protected static BankAccount[] liste = {};//Sert de tableau temporaire pour actualiser les valeurs
    protected static BankAccount[] listeCompte = {};//Tableau d'instance ou l'on regroupe les statuts de compte

    private static int tailleListe;

    private static double soldeOuverture = 0.0;//Correspond au solde de départ à l'ouverture d'un compte qui est initialisée à 0 mis à jour par bonus

    private Branch(){

    }

    public static void mouvementCompte//Pour gerer les ouvertures et fermetures de chaque compte
            (String action,
        String succursale, String compte){
        boolean repeter = false;

        for (int i = 0; i < listeCompte.length; i++)//Pour vérifier si le numéro de compte et de succursale sont libres
        {

            if (listeCompte[i].succursaleBankAccount.equals(succursale) && 
                    listeCompte[i].compteBankAccount.equals(compte) && 
                        action.equals("open")){

                repeter = true;//Si cette variable est Vrai alors il y'a une double ouverture de compte et donc cela ne pourra pas se faire
            }
        }

        tailleListe = listeCompte.length;

        if (action.equals("open") && ! repeter) {

            tailleListe = listeCompte.length + 1;
        }

        BankAccount[] liste = new BankAccount[tailleListe];

        if (action.equals("open") && ! repeter) //Rajoute le statut du nouveau compte ouvert à la dernière position
        {

            liste[listeCompte.length] = new BankAccount(succursale, 
            compte, action, "open " + succursale + ":" + compte + 
                " balance = " + soldeOuverture + "$", soldeOuverture);
        }

        for (int i = 0; i < listeCompte.length; i++)//Actualisation du tableau d'instance
        {
            liste[i] = listeCompte[i];

            if (listeCompte[i].succursaleBankAccount.equals(succursale) && 
                    listeCompte[i].compteBankAccount.equals(compte) && 
                        action.equals("close")) //Si la demande de transaction est "close" on ferme le compte et le mouvement de compte est terminé
            {

                liste[i].actifBankAccount = action;
            }
        }

        listeCompte = liste;
    }

    public static void suppressionCompteParSuccursale(String succursale)//Pour supprimer tous les comptes d'une succursalle fermée
    {

        tailleListe = 0;
        int x = 0;

        for (int i = 0; i < listeCompte.length; i++){
            if (! listeCompte[i].succursaleBankAccount.equals(succursale)){

                tailleListe += 1;
            }
        }

        BankAccount[] liste = new BankAccount[tailleListe];

        for (int i = 0; i < listeCompte.length; i++){
            if (! listeCompte[i].succursaleBankAccount.equals(succursale)){

                liste[x] = listeCompte[i];
                x += 1;
            }
        }

        listeCompte = liste;
    }

    public static void soldeOuverture(double bonus)//Pour attibuer les bonus à l'ouverture
    {
        
        soldeOuverture = bonus;
    }
}