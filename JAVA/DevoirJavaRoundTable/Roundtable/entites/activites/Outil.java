package entites.activites;
import java.util.List;

import entites.Interet;
import entites.utilisateurs.Membre;


public class Outil extends Activite {

    public String Version;
    public String Git;
    public String LienAdd;
	public Membre Responsable;
    public List<Membre> Collaborateur;
    public List<Article> Article;

    public Outil(Integer Id, String Nom, String Description, String Version, String Git, 
        String LienAdd, Membre Responsable, String Visibilite,
             List<Membre> Collaborateur, List<Article> Article, 
                List<Interet> Interet, String MotsCle, List<Membre> Souscrit){

        super(Id, Nom, Description, Visibilite, Interet, MotsCle, Souscrit);

        this.Version = Version;
        this.Git = Git;
        this.LienAdd = LienAdd;
        this.Responsable = Responsable;
        this.Collaborateur = Collaborateur;
        this.Article = Article;
    }
    public Outil(){
        
    }
}
