package mvc;

import javafx.scene.text.Text;

public class Controleur {

	private Modele modele;
	private Text vue;

	public Controleur(Modele m, Text v) {
		this.modele = m;
		this.vue = v;
	}

	public void inc() {
		this.modele.ajouter(1);
		this.updateText();
	}

	public void dec() {
		this.modele.supprimer(1);
		this.updateText();
	}

	public void dub() {
		this.modele.multiplier(2);
		this.updateText();
	}

	public void div() {
		this.modele.diviser(2);
		this.updateText();
	}

	private void updateText() {
		this.vue.setText(String.valueOf(this.modele.getValeur()));
	}

}