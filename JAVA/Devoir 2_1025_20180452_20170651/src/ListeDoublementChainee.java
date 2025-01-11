//Tchoumkeu Djeumen Thierry Manuel
//De Ryck Hadrien
//27/03/2021
//La classe ListeDoublementChainee et la classe principale avec Main
//elle va chercher la valeur initiale de la liste et va créer tout les noeuds adequats, et va les afficher en fonction de l'ordre demandé
public class ListeDoublementChainee implements IListeDoublementChainee{
    
    private String sens;
    private String[] words; 

    //valeurSuivant permet de connaitre la position (compareTo) d'un item par rapport a l'item du noeud
    //Item suivant est une instance Item qui gerde en memoire la prochain itel d'un noeud
    protected Integer valeurSuivant;
    protected Item<?> itemSuivant;

    //Les Noeuds Init et Final sont les seuls noeuds gardé en memoire dans la classe, initialisé sans valeurs 
    protected Noeud noeudInit = new Noeud(null, null , null);
    protected Noeud noeudFinal = new Noeud(null, null , null);

    //Noeud ephemere, permettant la creation des noeuds intermediaires
    protected Noeud noeud;

    //ListeDoublementChainee est un ocnstructeur gardant en memoire le sens asc ou desc
    public ListeDoublementChainee(String sens){
        this.sens = sens;
    }

    //ajouterListe, sur le String Liste on cherche la valeur la plus faible, en sens asc
    //le plus grand, en sens desc, on effectue la recherhe dans choixInitial
    public void ajouterListe(String listeEnString){

        Item<Integer> integerItemInit = new Item<Integer>();
        Item<Double> doubleItemInit = new Item<Double>();
        Item<String> stringItemInit = new Item<String>();

        listeEnString = listeEnString.replace("[", "");
        listeEnString = listeEnString.replace("]","");
        words = listeEnString.split(",");
        var valeur = words[0];

        if (Main.isInteger(valeur)) {
            integerItemInit.add(Integer.parseInt(valeur));
            choixInitial(integerItemInit);
        }
        else if (Main.isDouble(valeur)) {
            doubleItemInit.add(Double.parseDouble(valeur));
            choixInitial(doubleItemInit);
        }
        else {
            stringItemInit.add(valeur);
            choixInitial(stringItemInit);
        }
    }

    //choixInitial va chercher si in il a une valeur plus forte ou faible que la valeur initiale
    public void choixInitial(Item<?> item1){

        for (int x = 1; x < (words.length); x++){
            var valeur = words[x];

            Item<Integer> integerItem = new Item<Integer>();
            Item<Double> doubleItem = new Item<Double>();
            Item<String> stringItem = new Item<String>();

            if(Main.isInteger(valeur)) {
                integerItem.add(Integer.parseInt(valeur));
                item1 = newItem1(item1.compareTo(integerItem), integerItem, item1);
            }
            else if(Main.isDouble(valeur)) {
                doubleItem.add(Double.parseDouble(valeur));
                item1 =  newItem1(item1.compareTo(doubleItem), doubleItem, item1);
            }
            else {
                stringItem.add(valeur);
                item1 =  newItem1(item1.compareTo(stringItem), stringItem, item1);
            }
        }

        ajouterNoeud(item1);
    }

    //newItem permet de changer l'item initial si besoin
    public Item newItem1(int valeur, Item<?> item2, Item<?> item1){

        if (sens.equals("asc") && valeur < 0) {
            return item2;
        }
        else if (sens.equals("desc") && valeur > 0) {
            return item2;
        }
        return item1;
    }

    //ajouterNoeud permet d'ajouter les noeuds adequats, si on a pas d'item precedent, on injecte le noeud a noeud Init et a noeud Final si on a pas d'item suivant
    public void ajouterNoeud(Item<?> item){

        noeud = new Noeud(item, null , null);

        while (noeudFinal.getItem() == null){
            item = noeud.getItem();
            itemSuivant = null;

            //permet de changer la valeurSuivant en fonction du sens
            if (sens.equals("desc")){
                valeurSuivant = Integer.MIN_VALUE;
            }
            else {
                valeurSuivant = Integer.MAX_VALUE;
            }

            //doublon permet de ne pas prendre en compte le premier item equivalent a notre item
            Boolean doublon = false;

            for (int x = 0; x < (words.length); x++){
                var valeur = words[x];
    
                Item<Integer> integerItem = new Item<Integer>();
                Item<Double> doubleItem = new Item<Double>();
                Item<String> stringItem = new Item<String>();
    
                if(Main.isInteger(valeur)) {
                    integerItem.add(Integer.parseInt(valeur));
                    if (item.compareTo(integerItem) == 0){
                        if (!doublon){
                            doublon = true;
                        }
                        else {
                            noeud.setSuivant(new Noeud(integerItem, noeud , null));
                            noeud = noeud.getSuivant();
                            item = noeud.getItem();
                        }
                        continue;
                    }
                    compareToItem(item, integerItem);
                }
                else if(Main.isDouble(valeur)) {
                    doubleItem.add(Double.parseDouble(valeur));
                    if (item.compareTo(doubleItem) == 0){
                        if (!doublon){
                            doublon = true;
                        }
                        else {
                            noeud.setSuivant(new Noeud(doubleItem, noeud , null));
                            noeud = noeud.getSuivant();
                            item = noeud.getItem();
                        }
                        continue;
                    }
                    compareToItem(item, doubleItem);
                }
                else {
                    stringItem.add(valeur);
                    if (item.compareTo(stringItem) == 0){
                        if (!doublon){
                            doublon = true;
                        }
                        else {
                            noeud.setSuivant(new Noeud(stringItem, noeud , null));
                            noeud = noeud.getSuivant();
                            item = noeud.getItem();
                        }
                        continue;
                    }
                    compareToItem(item, stringItem);
                }
            }
    
            //si itemSuivant != null, on change le noeud suivant 
            if (itemSuivant != null){
                noeud.setSuivant(new Noeud(itemSuivant, noeud , null));
            }
    
            if (noeud.getPrecedent() == null){
                noeudInit = noeud;
            }
            if (noeud.getSuivant() == null){
                noeudFinal = noeud;
                break;
            }

            noeud = noeud.getSuivant();
        }
    }

    //compareToItem qui compare 2 items, et change itemSuivant en fonction du resultat
    public void compareToItem(Item<?> item, Item<?> secondItem){
        if (itemSuivant == null){
            if (sens.equals("asc") && item.compareTo(secondItem) > 0){

                modificationValeur(item.compareTo(secondItem));
                itemSuivant = secondItem;
            }
            else if (sens.equals("desc") && item.compareTo(secondItem) < 0){
                modificationValeur(item.compareTo(secondItem));
                itemSuivant = secondItem;
            }
        }
        else {
            if (sens.equals("asc") && item.compareTo(secondItem) > 0 && itemSuivant.compareTo(secondItem) < 0){

                modificationValeur(item.compareTo(secondItem));
                itemSuivant = secondItem;
            }
            else if (sens.equals("desc") && item.compareTo(secondItem) < 0 && itemSuivant.compareTo(secondItem) > 0){
                modificationValeur(item.compareTo(secondItem));
                itemSuivant = secondItem;
            }
        }
    }

    //modificationValeur permet de changer la valeurSuivant
    public void modificationValeur(int valeur){

        if (valeur > 0 && valeur < valeurSuivant){
            valeurSuivant = valeur;
        }
        else if (valeur < 0 && valeur > valeurSuivant){
            valeurSuivant = valeur;
        }
    }

    //imprimerListeDuDebut imprime les noeuds du debut a la fin
    //on imprime initialement noeudInit et on affiche le noeud suivant 
    //On stop si le pointeur suivant du noeud vaut NULL
    public void imprimerListeDuDebut(){

        System.out.print("Noeuds du debut vers la fin: ");

        noeud = noeudInit;
        while (noeud.getSuivant() != null){
            System.out.print(noeud.getItem().get() + "->");
            noeud = noeud.getSuivant();
        }
        System.out.println(noeud.getItem().get());
    }

    //imprimerListeDeLaFin imprime les noeuds de la fin au debut
    //on imprime initialement noeudFinal et on affiche le noeud precedent 
    //On stop si le pointeur precedent du noeud vaut NULL
    public void imprimerListeDeLaFin(){

        System.out.print("Noeuds de la fin vers le debut: ");

        noeud = noeudFinal;
        while (noeud.getPrecedent() != null){
            System.out.print(noeud.getItem().get() + "->");
            noeud = noeud.getPrecedent();
        }
        System.out.print(noeud.getItem().get());
    }
}
