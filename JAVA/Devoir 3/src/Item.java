//Tchoumkeu Djeumen Thierry Manuel
//De Ryck Hadrien
//27/03/2021
//Classe pour initialiser les instances d'Item de différent type(double, String ou Int)

import java.io.Serializable;

public class Item<T extends Comparable<?>> implements Comparable<Item<?>>, Serializable {
    private T t;

    public void add(T t){
        this.t = t;
    } //Setter de la classe
    public T get() {
        return t;
    }  //Getter de la classe

    @Override
    public int compareTo(Item<?> item2) {
        var type1 = t.getClass().getName();
        type1 = type1.replace("java.lang.", "");//String contenant le type de l'item t
        var type2 = item2.get().getClass().getName();
        type2 = type2.replace("java.lang.", "");//String contenant le type de l'item placé en paramètre

        var valeur1 = t.toString();
        var valeur2 = item2.get().toString();
        //Les conditions suivantes vont permettre de comparer les items en question par rapport à leur type grace à la méthode "compareTo()"
        //elles sont initialisées en String pour des questions de simplicité et sont converties plus tard

        if (type1.equals("String") ||type2.equals("String")) //Si se sont des String
        {
            return (valeur2.compareTo(valeur1));
        }
        else if (type1.equals("Integer") && type2.equals("Integer")) //Si ce sont des Int
        {
            return (Integer.valueOf(valeur2).compareTo(Integer.valueOf(valeur1)));
        }
        else //Si ce sont des double
            {
            return (Double.valueOf(valeur2).compareTo(Double.valueOf(valeur1)));
        }
    }
}
