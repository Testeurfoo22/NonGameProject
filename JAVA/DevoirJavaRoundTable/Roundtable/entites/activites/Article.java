package entites.activites;
import java.util.List;

import entites.Interet;
import entites.utilisateurs.Membre;

public class Article extends Activite {

    public String DatedePublication;
    public List<Membre> Auteurs;
    public List<Membre> Collaborateur;
    public String Statut;
    public String lien;

    public Article(Integer Id, String Nom, String Description, String DatedePublication, 
        List<Membre> Auteurs, List<Membre> Collaborateur, 
            String Visibilite, List<Interet> Interet,
                String MotsCle, String Statut, String lien, List<Membre> Souscrit){

            super(Id, Nom, Description, Visibilite, Interet, MotsCle, Souscrit);

            this.DatedePublication = DatedePublication;
            this.Auteurs = Auteurs;
            this.Collaborateur = Collaborateur;
            this.Statut = Statut;
            this.lien = lien;
    }
    public Article(){
        
    }
} 