package entites.activites;
import java.util.List;

import entites.Interet;
import entites.utilisateurs.Membre;


public class Projet extends Activite {

    public String PeriodeDebut;
    public String PeriodeFin;
    public Membre Responsable;
    public String Partenaires;
    public List<Membre> Membres;

    public Projet (Integer Id, String Nom, String Description, String PeriodeDebut, String PeriodeFin,
                Membre Responsable, String Partenaires, List<Membre> Membres, 
                    String Visibilite, List<Interet> Interet, String MotsCle, List<Membre> Souscrit){

            super(Id, Nom, Description, Visibilite, Interet, MotsCle, Souscrit);

            this.PeriodeDebut = PeriodeDebut;
            this.PeriodeFin = PeriodeFin;
            this.Responsable = Responsable;
            this.Partenaires = Partenaires;
            this.Membres = Membres;
    }
    public Projet(){

    }
}
