//Tchoumkeu Djeumen Thierry Manuel
//De Ryck Hadrien
//02/04/2021
import java.io.EOFException;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.net.ServerSocket;
import java.net.Socket;
//import java.util.ArrayList;

import java.io.FileWriter;
import java.io.BufferedWriter;

public class LeServeur {

	public static void main(String[] args) {

		try {
			System.out.println("Demarrage du serveur sur port 1337");
			ServerSocket server = new ServerSocket(1337, 1);

			Socket client = server.accept();
			System.out.println(
					"Un client ayant l'addresse " + client.getInetAddress() + 
					" a connecté sur port " + client.getLocalPort()
					);

			InputStream clientStream = client.getInputStream();
			
			/*
			À FAIRE: 
			Créer un objet ObjectInputStream objectReader à partir du clientStream
			*/
			ObjectInputStream objectReader = new ObjectInputStream(clientStream);
			FileWriter fichier = new FileWriter("assets/notreOutput.txt");
			BufferedWriter output = new BufferedWriter(fichier);

			try {
				while (true) {
					try {
						/*
						À FAIRE: 
						Deserialiser un objet uneListe du type IListeDoublementChainee en appellant
							objectReader.readObject()
						*/
						
						IListeDoublementChainee uneListe = (IListeDoublementChainee)objectReader.readObject();
						/*Liste d'instructions débalant le résultat que l'on va obtenir dans
						le fichier "notreOutput.txt"
						 */
						output.write("----------");
						output.newLine();
						output.write("Sens du tri: " + uneListe.getSens());
						output.newLine();
						output.write("Liste originale: " + uneListe.getListe());
						output.newLine();

						var affichageListe = faireDesChoses(uneListe);

						output.write(affichageListe[0]);
						output.newLine();
						output.write(affichageListe[1]);
						output.newLine();
						output.write("----------");
						output.newLine();

					} catch (ClassNotFoundException e) {
						System.err.println("L'objet lu n'etait pas une instance de la classe attendue.");
					}
				}
			} catch (EOFException eof) {
				/*
				Rien à faire ici. Le EOFException signifie juste que l' objectReader
				n'arrive pas à recevoir plus d'objets par clientStream.
				Cela nous permet de sortir du boucle while(true) quand il n'y a plus 
				d'objets à deserialiser.
				*/
			}
			//Fermeture des fichiers et déconnexion du client
			output.close();

			System.out.println("Plus des choses à lire. Au revoir.");

			objectReader.close();
			server.close();

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	//À FAIRE: adaptez la signature selon votre implementation du IListeDoublementChainee
	private static String[] faireDesChoses(IListeDoublementChainee d) {
    /*
    À FAIRE:
    (Devoir 2) exporter la liste de l'avant vers l'arrière et inversement 
	au fond du fichier output.txt comme en devoir 2
	*/

		String[] affichageListe = new String[2];
		affichageListe[0] = d.imprimerListeDuDebut();
		affichageListe[1] = d.imprimerListeDeLaFin();

		return affichageListe;
	}

}
