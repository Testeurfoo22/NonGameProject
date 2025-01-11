/*Tchoumkeu Djeumen Thierry Manuel 20170651
De Ryck Hadrien
27/03/2021*/
//Classe Noeud utilisée dans le devoir 2
package mvc;

public class Noeud {
    protected String operateur;
    protected Integer valeur1;
    protected Integer valeur2;
    protected Noeud precedent;
    protected Noeud suivant;
    protected String compteur;

    //Constructeur Noeud, gardant en mémoire les dernières valeurs mis en place, le compteur mis a jour, avec son operateur et pointe vers un noeud precedent et suivant
    public Noeud(String compteur, String operateur, Integer valeur1, Integer valeur2, Noeud precedent, Noeud suivant){
        this.compteur = compteur;
        this.operateur=operateur;
        this.valeur1=valeur1;
        this.valeur2=valeur2;
        this.precedent=precedent;
        this.suivant=suivant;
    }

    //Différents Getters et Setters de la classe
    public void setPrecedent(Noeud precedent){
        this.precedent = precedent;
    }

    public void setSuivant(Noeud suivant){
        this.suivant = suivant;
    }

    public void setCompteur(String compteur){
        this.compteur = compteur;
    } 

    public void setOperateur(String operateur){
        this.operateur=operateur;
    }

    public void setValeur1(Integer valeur){
        this.valeur1=valeur;
    }

    public void setValeur2(Integer valeur){
        this.valeur2=valeur;
    }

    public String getCompteur(){
        return compteur;
    } 

    public String getOperateur(){
        return operateur;
    }

    public int getValeur1(){
        return valeur1;
    }

    public int getValeur2(){
        return valeur2;
    }

    public Noeud getPrecedent(){
        return precedent;
    }

    public Noeud getSuivant(){
        return suivant;
    }
}
