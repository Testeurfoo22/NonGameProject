/*Tchoumkeu Djeumen Thierry Manuel 20170651
De Ryck Hadrien
27/03/2021*/
/*Classe Principale du programme, met en place l'affichage JavaFx et redirige le programme 
ou il faut en fonction des buttons cliqués*/
package mvc;

import javafx.application.Application;
import javafx.geometry.Pos;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import javafx.scene.text.Text;
import javafx.scene.control.RadioButton;
import javafx.scene.control.ToggleGroup;
import javafx.scene.control.Menu;
import javafx.scene.control.MenuBar;
import javafx.scene.control.MenuItem;

import java.io.FileWriter;

/*
 * Dans cette classe nous definissons les éléments graphiques de notre
 * application.
 * 
 * NB: voir aussi lignes 64-74!
 */
public class Vue extends Application {

	private int valeurInit = 0;

	private static Controleur controleur;

	private Modele modele = new Modele(valeurInit);


	@Override
	public void start(Stage primaryStage) {

		try {
			/*Configuration Initiale de l'affichage*/
			VBox sceneBox = new VBox();

			Menu file = new Menu("File");

			MenuItem undo = new MenuItem("Undo");
			MenuItem redo = new MenuItem("Redo");
			MenuItem print = new MenuItem("Print");
			MenuItem exit = new MenuItem("Exit");
			file.getItems().add(undo);
			file.getItems().add(redo);
			file.getItems().add(print);
			file.getItems().add(exit);

			Menu help = new Menu("Help");
			
			MenuBar menuBar = new MenuBar();
			menuBar.getMenus().add(file);
			menuBar.getMenus().add(help);

			sceneBox.getChildren().add(menuBar);


			BorderPane root = new BorderPane();

			ToggleGroup groupe = new ToggleGroup();

			RadioButton bouttonRadio1= new RadioButton("compteur1");
			RadioButton bouttonRadio2= new RadioButton("compteur2");

			bouttonRadio1.setToggleGroup(groupe);
			bouttonRadio2.setToggleGroup(groupe);

			Text compteur1Valeur = new Text(String.valueOf(modele.getNoeudAffichage().getValeur1()));
			Text compteur2Valeur = new Text(String.valueOf(modele.getNoeudAffichage().getValeur2()));

			Button inc = new Button("+1");
			Button dub = new Button("*2");
			Button div = new Button("/2");
			Button dec = new Button("-1");
			HBox box=new HBox();
			VBox compteur1 = new VBox();
			VBox compteur2 = new VBox(); 

			compteur1.getChildren().add(bouttonRadio1);
			compteur1.getChildren().add(compteur1Valeur);
			compteur1.setAlignment(Pos.CENTER);

			compteur2.getChildren().add(bouttonRadio2);
			compteur2.getChildren().add(compteur2Valeur);
			compteur2.setAlignment(Pos.CENTER);

			box.getChildren().add(compteur1);
			box.getChildren().add(compteur2);
			box.setAlignment(Pos.CENTER);
			box.setSpacing(20);
			box.setPrefHeight(1000);
			BorderPane.setAlignment(inc, Pos.CENTER);
			BorderPane.setAlignment(dub, Pos.CENTER);
			BorderPane.setAlignment(div, Pos.CENTER);
			BorderPane.setAlignment(dec, Pos.CENTER);
			BorderPane.setAlignment(box, Pos.CENTER);


			root.setTop(inc);
			root.setBottom(dec);
			root.setLeft(dub);
			root.setRight(div);
			root.setCenter(box);

			sceneBox.getChildren().add(root);


			Scene scene = new Scene(sceneBox, 400, 200);

			// Le controleur manipule tout evenement.

			inc.setOnAction((action) -> {
				controleur.inc();
			});

			dec.setOnAction((action) -> {
				controleur.dec();
			});

			dub.setOnAction((action) -> {
				controleur.dub();
			});

			div.setOnAction((action) -> {
				controleur.div();
			});

			/*
			 * En raison de la conception des applications JavaFX, nous sommes obligés de
			 * créer le modèle et le controleur ici.
			 * 
			 * Notez cependant que nous passons l'instance du modèle directement dans le
			 * constructeur du controleur; nous n'y avons pas d'autre accès.
			 * 
			 * Pour faciliter les choses, ici le constructeur ne prend pas la Vue entière,
			 * mais juste le sous-ensemble de la Vue (l'objet Text) qu'il doit manipuler.
			 */

			bouttonRadio1.setOnAction((envent) -> {
				controleur = new Controleur(modele, compteur1Valeur, compteur2Valeur, bouttonRadio1.getText());
			}); 
			bouttonRadio2.setOnAction((envent) -> {
				controleur = new Controleur(modele, compteur1Valeur, compteur2Valeur, bouttonRadio2.getText());
			});

			undo.setOnAction((envent) -> {
				controleur.setNoeudAffichage(-1);
			}); 

			redo.setOnAction((envent) -> {
				controleur.setNoeudAffichage(1);
			}); 

			print.setOnAction((envent) -> {
				/*Affichage dans le fichier historique.txt*/
				try {
					FileWriter fichier = new FileWriter("assets/historique.txt");
					fichier.write("----------\n");
					Noeud ephemere = modele.getNoeudInit();
					while (true){
						fichier.write("----------\n");
						if (ephemere.getOperateur() == null){
							fichier.write("DEBUT\n");
						}
						else {
							fichier.write(ephemere.getOperateur() + " COMPTEUR " + ephemere.getCompteur() + "\n");
						}
						fichier.write("RESULTAT COMPTEUR GAUCHE " + ephemere.getValeur1() + "\n");
						fichier.write("RESULTAT COMPTEUR DROITE " + ephemere.getValeur2() + "\n");
						fichier.write("----------\n");
						if(ephemere == modele.getNoeudAffichage()){
							fichier.write("----------\n");
							fichier.write("FIN\n");
							fichier.write("RESULTAT COMPTEUR GAUCHE " + ephemere.getValeur1() +"\n");
							fichier.write("RESULTAT COMPTEUR DROITE " + ephemere.getValeur2() +"\n");
							fichier.write("----------\n");
							break;
						}
						ephemere = ephemere.getSuivant();
					}
					fichier.write("----------");
					fichier.close();
				} catch(java.io.IOException e){
					System.out.println("il y a un probleme dans l'ecriture");
				}
			}); 

			exit.setOnAction((envent) -> {
				System.exit(0);
			}); 

			controleur = new Controleur(new Modele(valeurInit), new Text(), new Text(), "laisser");

			primaryStage.setScene(scene);
			primaryStage.show();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		launch(args);
	}
}
