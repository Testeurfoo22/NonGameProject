/*Tchoumkeu Djeumen Thierry Manuel 20170651
De Ryck Hadrien
27/03/2021*/
package mvc;

import javafx.scene.text.Text;

public class Controleur {

	private Modele modele;
	private Text vue1;
	private Text vue2;
	private String compteur;

	public Controleur(Modele m, Text v1, Text v2, String compteur ) {
		this.modele = m;
		this.vue1 = v1;
		this.vue2 = v2;
		this.compteur = compteur;
	}

	public void inc() {
		this.modele.ajouter(1, compteur);
		this.updateText();
	}

	public void dec() {
		this.modele.supprimer(1, compteur);
		this.updateText();
	}

	public void dub() {
		this.modele.multiplier(2, compteur);
		this.updateText();
	}

	public void div() {
		this.modele.diviser(2, compteur);
		this.updateText();
	}

	private void updateText() {
		this.vue1.setText(String.valueOf(this.modele.getNoeudAffichage().getValeur1()));
		this.vue2.setText(String.valueOf(this.modele.getNoeudAffichage().getValeur2()));
	}

	public void setNoeudAffichage(Integer valeur){
		modele.setNoeudAffichage(valeur);
		this.updateText();
	}
}