/*Tchoumkeu Djeumen Thierry Manuel 20170651
De Ryck Hadrien
27/03/2021*/
package mvc;
/*
 *	Notez que cette classe est completement indépendante de la representation.
 *	On pourraît facilement definir un interface complètement different.
 */
public class Modele {

	//noeudInit est le noeud le Base, initié en 0 0
	//noeudAffichage, le noeud affiché sur l'interface
	//noeudFinal, le dernier noeud, si on undo 
	private Noeud noeudInit = new Noeud(null, null, null, null, null, null);
	private Noeud noeudAffichage = new Noeud(null, null, null, null, null, null);
	private Noeud noeudFinal = new Noeud(null, null, null, null, null, null);

	public Modele(int v) {
		this.noeudInit.setValeur1(v);
		this.noeudAffichage.setValeur1(v);
		this.noeudFinal.setValeur1(v);
		this.noeudInit.setValeur2(v);
		this.noeudAffichage.setValeur2(v);
		this.noeudFinal.setValeur2(v);
	}

	//getter noeud specifiques.
	public Noeud getNoeudAffichage() {
		return noeudAffichage;
	}

	public Noeud getNoeudInit(){
		return noeudInit;
	}

	public void ajouter(int montant, String compteur) {

		int modification = 0;

		Noeud ephemere = new Noeud(null, null, null, null, null, null);
		ephemere.setOperateur("ADDITION");
		if (compteur.equals("compteur1")){
			modification = (this.noeudAffichage.getValeur1() + montant);
		}
		else if (compteur.equals("compteur2")){
			modification = (this.noeudAffichage.getValeur2() + montant);
		}
		modification(ephemere, modification, compteur);
	}

	public void supprimer(int montant, String compteur) {

		int modification = 0;

		Noeud ephemere = new Noeud(null, null, null, null, null, null);
		ephemere.setOperateur("SOUSTRACTION");
		if (compteur.equals("compteur1")){
			modification = (this.noeudAffichage.getValeur1() - montant);
		}
		else if (compteur.equals("compteur2")){
			modification = (this.noeudAffichage.getValeur2() - montant);
		}
		modification(ephemere, modification, compteur);
	}

	public void multiplier(int fois, String compteur) {

		int modification = 0;

		Noeud ephemere = new Noeud(null, null, null, null, null, null);
		ephemere.setOperateur("MULTIPLICATION");
		if (compteur.equals("compteur1")){
			modification = (this.noeudAffichage.getValeur1() * fois);
		}
		else if (compteur.equals("compteur2")){
			modification = (this.noeudAffichage.getValeur2() * fois);
		}
		modification(ephemere, modification, compteur);
	}

	public void diviser(int fois, String compteur) {

		int modification = 0;

		Noeud ephemere = new Noeud(null, null, null, null, null, null);
		ephemere.setOperateur("DIVISION");
		if (compteur.equals("compteur1")){
			modification = (this.noeudAffichage.getValeur1() / fois);
		}
		else if (compteur.equals("compteur2")){
			modification = (this.noeudAffichage.getValeur2() / fois);
		}
		modification(ephemere, modification, compteur);
	}

	public void modification(Noeud ephemere, int modification, String compteur){
		if (compteur.equals("compteur1")){
			ephemere.setCompteur("GAUCHE");
			ephemere.setValeur1(modification);
			ephemere.setValeur2(this.noeudAffichage.getValeur2());
		}
		else if (compteur.equals("compteur2")){
			ephemere.setCompteur("DROITE");
			ephemere.setValeur2(modification);
			ephemere.setValeur1(this.noeudAffichage.getValeur1());
		}
		ephemere.setPrecedent(this.noeudAffichage);
		this.noeudAffichage.setSuivant(ephemere);
		if (this.noeudInit.getSuivant() == null){
			this.noeudInit.setSuivant(ephemere);
		}
		this.noeudFinal = ephemere;
		this.noeudAffichage = ephemere;
	}

	//methode qui set les valeurs affiché lors d'undo redo.
	public void setNoeudAffichage(Integer valeur){
		if (valeur == -1 && this.noeudAffichage.getPrecedent() != null){
			this.noeudAffichage = this.noeudAffichage.getPrecedent();
		}
		if (valeur == 1 && this.noeudAffichage.getSuivant() != null){
			this.noeudAffichage = this.noeudAffichage.getSuivant();
		}
	}
}
