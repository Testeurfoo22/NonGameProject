//Tchoumkeu Djeumen Thierry Manuel
//De Ryck Hadrien
//27/03/2021
//Classe pour les instances de Noeuds

import java.io.Serializable;

public class Noeud implements Serializable{
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    
    protected Item<?> item;
    protected Noeud precedent;
    protected Noeud suivant;

    //Constructeur Noeud, gardant en mémoire son item et pointe vers un noeud precedent et suivant
    public Noeud(Item<?> item, Noeud precedent, Noeud suivant){
        this.item=item;
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

    public Item getItem(){
        return item;
    }

    public Noeud getPrecedent(){
        return precedent;
    }

    public Noeud getSuivant(){
        return suivant;
    }
}
