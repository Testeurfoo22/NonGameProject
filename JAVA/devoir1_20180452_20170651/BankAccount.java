//Permet de faire des mouvements de solde sur un compte
public class BankAccount{
    //Pour le constructeur
    protected String succursaleBankAccount;
    protected String compteBankAccount;
    protected String actifBankAccount;
    protected String transfertBankAccount;

    protected double balanceBankAccount;
    //Constructeur qui ressence le statut d'un compte
    public BankAccount(String succursale, String compte, String actif, 
        String transfert, double balance)//Constructeur
    {
            
        succursaleBankAccount = succursale;
        compteBankAccount = compte;
        actifBankAccount = actif;
        transfertBankAccount = transfert;
        balanceBankAccount = balance;
    }

    public static void operation(String succursale, String compte, 
        String action, double montant)//Pour gerer les opérations de dépot et de retrait
    {

        for (int i = 0; i < Branch.listeCompte.length; i++)//Permet de chercher dans la liste de comptes le compte ouvert adéquat
        {
            if (Branch.listeCompte[i].succursaleBankAccount.equals(succursale) &&
                 Branch.listeCompte[i].compteBankAccount.equals(compte) && Branch.listeCompte[i].actifBankAccount.equals("open")
            ){
                // Effectue l'opération si le compte en question est ouvert et son solde est supérieur au montant inscrit
                //Effectue l'opération si le montant est supérieur à 0
                if (action.equals("withdraw") && montant > 0 && 
                    Branch.listeCompte[i].balanceBankAccount >= montant){

                    Branch.listeCompte[i].balanceBankAccount -= montant;
                    Branch.listeCompte[i].transfertBankAccount = action + " " + 
                        montant + "$";
                }

                if (action.equals("deposit") && montant > 0){

                    Branch.listeCompte[i].balanceBankAccount += montant;
                    Branch.listeCompte[i].transfertBankAccount = action + " " + 
                        montant + "$";
                }

                break;
            }
        }
    }
}