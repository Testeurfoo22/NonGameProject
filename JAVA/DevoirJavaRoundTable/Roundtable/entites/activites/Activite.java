package entites.activites;
import java.util.List;

import entites.Interet;
import entites.utilisateurs.Membre;

public abstract class Activite {
	/*
		Classe d'entitée représentant une activité.
		Est héritée par article, projet et outils.
	*/

	public Integer Id;
	public String Nom;
	public String Description;
	public List<Interet> Interet;
	public List<Membre> Souscrit;
	public String Visibilite;
	public String MotsCle;


    public Activite(
		Integer Id, String Nom, String Description,
		String Visibilite, List<Interet> Interet,
		String MotsCle, List<Membre> Souscrit
	) {

		this.Id = Id;
		this.Nom = Nom;
		this.Description = Description;
		this.Visibilite = Visibilite;
		this.Interet = Interet;
		this.MotsCle = MotsCle;
		this.Souscrit = Souscrit;
    }

    public Activite(){
        
    }

}