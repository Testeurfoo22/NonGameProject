//Tchoumkeu Djeumen Thierry Manuel
//de Ryck Hadrien
//Le programme permet d'analyser une série de transaction bancaire et de les afficher si besoin
//Cette classe est la classe principale, elle gère les succursalles et envoie les infos dans les autres classes si besoin
public class Bank{

    protected static String[] liste;//Liste éphémere pour actualiser les informations
    private static String[] listeSuccursale = {};//Liste comprennant toutes les succursales ouvertes

    private static int x; 
    private static int tailleListe;
    //Attributs pour les constructeurs
    protected int compteOuvertBank;
    protected int compteFermeBank;
    protected double totalDepositBank;
    protected double totalFermeBank;
    protected double balanceBank;
    protected String derniereOperationBank;
    protected String compteBank;

    public Bank(){

    }

    public Bank(int compteOuvert, int compteFerme, double totalDeposit,
                     double totalFerme)//Constructeur pour garder en mémoire le nombre de compte ouvert/fermés et leur dépots de la succursalle
    {

        compteOuvertBank = compteOuvert;
        compteFermeBank = compteFerme;
        totalDepositBank = totalDeposit;
        totalFermeBank = totalFerme;
    }

    public void processTransaction(String informationTransaction)//Méthode pour gérer les transactions ligne par ligne
    {

        final String separateur = " ";
        String[] action = informationTransaction.split(separateur);

        if (action[0].equals("bonus") && Integer.parseInt(action[1]) >= 0){

            Branch.soldeOuverture((double) Integer.parseInt(action[1]));
        }

        else if (! action[0].equals("bonus") && action.length > 1){

            transfertSpecifique(action);
        }

        else if (action[0].equals("report") || action[0].equals("short-report")){

            rapport(action[0]);
        }

    }

    public static void transfertSpecifique(String[] action)//Pour gerer les opérationset emmener les infos au bon endroit en fonction de la transaction
    {

        if (action.length == 4)//Dépot et retrait d'argent dans un compte
             {

            BankAccount.operation(action[1], action[2], action[0],
                Double.parseDouble(action[3]));
        }

        else if (action.length == 3 && action[2].length() == 7)//Ouverture et fermeture de compte
        {

            Branch.mouvementCompte(action[0], action[1], action[2]);
        }

        else if (action.length == 2 && action[1].length() == 5)//Ouverture et fermeture de succursalle
        {

            x = 0;

            for (int i = 0; i < listeSuccursale.length; i++)//Va chercher dans la liste de succursalles déjà ouvertes si il y'a un doublon
            {
                if (listeSuccursale[i].equals(action[1])){

                    x = 1;
                }
            }
            if (x == 0 && action[0].equals("build") ||
                    x == 1 && action[0].equals("dismantle")){

                Bank.mouvementSuccursale(action);
            }
        }
    }

    public static void mouvementSuccursale(String[] action)//Permet d'actualiser la liste de succursalles ouvertes en les ouvrant ou fermant
    {

        x = 0;
        boolean build = false;

        if (action[0].equals("build")) {

            tailleListe = listeSuccursale.length + 1;
            build = true;
        }
        if  (action[0].equals("dismantle"))//Si on ferme une succursalle tous les comptes de la succursalles seron supprimés
        {

            tailleListe = listeSuccursale.length - 1;
            Branch.suppressionCompteParSuccursale(action[1]);
        }

        String[] nouvelleListe = new String[tailleListe];
        liste = nouvelleListe;

        for (int i = 0; i < listeSuccursale.length; i++)//Réactualise le tableau mais si il y'a un doublon de numéro de succursalle on le retire
        {
            if ( ! listeSuccursale[i].equals(action[1])){

                liste[x] = listeSuccursale[i];
                x += 1;
            }
        }
        
        if (build){

            liste[listeSuccursale.length] = action[1];
        }

        listeSuccursale = liste;
    }

    public static void rapport(String typeRapport)//Impréssion du rapport
    {

        x = 0;

        System.out.println("+++ Bank Report +++");

        for (int i = 0; i < listeSuccursale.length; i++){

            Bank succursale = new Bank(0, 0, 0.0, 0.0);
            for (int y = 0; y < Branch.listeCompte.length; y++)//Crée une instance "succursalle" ou l'on ajoute le nombre de comptes ouverts/fermés dans la succursalle
            {
                if (Branch.listeCompte[y].succursaleBankAccount.equals(
                        listeSuccursale[i])){

                    if (Branch.listeCompte[y].actifBankAccount.equals("open")){

                        succursale.compteOuvertBank += 1;
                        succursale.totalDepositBank += Branch.listeCompte[y].balanceBankAccount;
                    }
                    else{

                        succursale.compteFermeBank += 1;
                        succursale.totalFermeBank += Branch.listeCompte[y].balanceBankAccount;
                    }
                }
            }

            if (typeRapport.equals("report"))//Si on demande un rapport, on affiche les informations de chaque compte
            {

                affichageCompte(i, succursale);
            }

            x += succursale.totalDepositBank;
        }

        System.out.println("Bank total deposits = " + (double) x + "$");
        System.out.println("-------------------");
    }

    public static void affichageCompte(int i, Bank succursale)//Affiche toutes les informations des comptes de la succursalle
    {

        System.out.println("### Branch " + listeSuccursale[i] + " ###" );
        System.out.println("    " + succursale.compteOuvertBank +
             " active accounts.");

        for (int y = 0; y < Branch.listeCompte.length; y++)//Recherche tous les comptes non suprimés et affiche leurs informations
        {
            if (Branch.listeCompte[y].succursaleBankAccount.equals(
                    listeSuccursale[i]) && 
                        Branch.listeCompte[y].actifBankAccount.equals("open")){

                System.out.println("*** Account " + Branch.listeCompte[y].succursaleBankAccount + ":"
                    + Branch.listeCompte[y].compteBankAccount );
                System.out.println("    " + "Balance = " + Branch.listeCompte[y].balanceBankAccount + "$");
                System.out.println("    " + "Last operation " + Branch.listeCompte[y].transfertBankAccount);
            }
        }
        //Affichage montant total de dépots de comptes, le nombre de compte ouvert et le nombre de compte fermés
        System.out.println("    Total deposits = " + succursale.totalDepositBank + "$");
        System.out.println("    " + succursale.compteFermeBank + " closed accounts.");
        System.out.println("    Total closed accounts = " + succursale.totalFermeBank +"$");
        System.out.println("####################");
    }

}