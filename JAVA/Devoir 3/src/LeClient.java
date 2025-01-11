//Tchoumkeu Djeumen Thierry Manuel
//De Ryck Hadrien
//02/04/2021
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.net.ConnectException;
import java.net.Socket;

import java.io.FileReader;
import java.io.BufferedReader;

// Si necessaire:
//import java.util.ArrayList;

public class LeClient {
	public static void main(String[] args) {

		try {
			System.out.println("Demarrage du client sur port 1337.");
			Socket monSocket = new Socket("127.0.0.1", 1337);

			/*
			À FAIRE: 
			
			Créer un objet ObjectOutputStream writer à partir du monSocket
			
			(Devoir 2) Lire listes du fichier d'entrée
			(Devoir 2) Créer les objets necessaires
			
			Itérer tous les listes et les sérializer en appellant
				writer.writeObject(...)
			*/	

			ObjectOutputStream writer = new ObjectOutputStream(monSocket.getOutputStream());

            //ouverture des fichiers à lire
            FileReader fichier = new FileReader("assets/input.txt");
			BufferedReader input = new BufferedReader(fichier);

            String action;
            while((action = input.readLine()) !=null) //Lire le contenu du fichier input.txt ligne par ligne
            {
                String[] colonne = action.split(" ");//Tableau de 2 éléments (String) donc le premier est le sens et le 2e le tableau à utiliser
                IListeDoublementChainee listeDouble = new IListeDoublementChainee(colonne[0]);//Instance de la liste doublement chainée prennant en paramètre le sens
                listeDouble.ajouterListe(colonne[1]);//lancement de la methode ajouter liste qui créer les noeuds adequats
    
                IListeDoublementChainee liste = new IListeDoublementChainee(listeDouble.getSens(), listeDouble.getListe(), listeDouble.getNoeudInit(), listeDouble.getNoeudFinal());
    
                writer.writeObject(liste);//Writer pour serializer les requetes au serveur
            }
            //Fermeture des fichiers
			writer.flush();
			writer.close();

            input.close();
			//socket.close();
			monSocket.close();

        //Les exeptions
		} catch (ConnectException x) {
			System.out.println("Connexion impossible sur port 1337: pas de serveur.");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
