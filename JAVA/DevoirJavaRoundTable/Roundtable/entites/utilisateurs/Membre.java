package entites.utilisateurs;

import java.util.List;

import entites.Interet;
import entites.activites.Article;
import entites.activites.Outil;
import entites.activites.Projet;


public class Membre {
    public static String[] membreroleDesc = {
        "Description de Membre",
        "Description de Superviseur",
        "Description de Administrateur",
    };
    public static String[] membreTitre = {
        "Maitrise",
        "Doctorat",
        "PostDoc",
        "Professeur",
    };

    public Integer Id;
    public String Nom;
    public String Prenom;
    public String MailUni;
    public String Mail;
    public String Mdp;
    public String Tel;
    public String LienWeb;
    public String Titre;
    public Role Role;
    public String Statut;
    public List<Interet> interet;
    public List<Projet> projet;
    public List<Outil> outil;
    public List<Article> article;
    public List<String> notif;
    public boolean notifMail;
    public Membre Superviseur;

    public Membre(Integer Id, String Nom, String Prenom, String MailUni, String Mdp, String Mail, String Tel,
        String LienWeb, String Titre, Membre Superviseur, Role Role, String Statut, List<Interet> interet, 
            List<Projet> projet, List<Outil> outil, List<Article> article, List<String> notif, boolean notifMail){

        this.Id = Id;
        this.Prenom = Prenom;
        this.Nom = Nom;
        this.MailUni = MailUni;
        this.Mdp = Mdp;
        this.Mail = Mail;
        this.Tel = Tel;

        this.LienWeb = LienWeb;
        this.Titre = Titre;
        this.Superviseur = Superviseur;

        this.interet = interet;

        this.projet = projet;
        this.outil = outil;
        this.article = article;

        this.Statut = Statut;
        this.Role = Role;

        this.notif = notif;
        this.notifMail = notifMail;
    }

    public Membre(){

    }

}
