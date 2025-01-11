//De Ryck Hadrien
//Tchoumkeu Djeumen Thierry Manuel
//15/04/2021
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

/*
 * Dans cette classe nous definissons les éléments graphiques de notre
 * application.
 * 
 * NB: voir aussi lignes 64-74!
 */
public class Vue extends Application {

	private static Controleur controleur;

	private Modele valeurInitiale = new Modele();

	private	Text compteur1Valeur = new Text(String.valueOf(valeurInitiale.getValeur()));
	private Text compteur2Valeur = new Text(String.valueOf(valeurInitiale.getValeur()));

	private Modele modele1 = new Modele();
	private Modele modele2 = new Modele();


	@Override
	public void start(Stage primaryStage) {

		try {
			BorderPane root = new BorderPane();
			Scene scene = new Scene(root, 400, 200);

			ToggleGroup groupe = new ToggleGroup();

			RadioButton bouttonRadio1= new RadioButton("compteur1");
			RadioButton bouttonRadio2= new RadioButton("compteur2");

			bouttonRadio1.setToggleGroup(groupe);
			bouttonRadio2.setToggleGroup(groupe);

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
				controleur = new Controleur(modele1, compteur1Valeur);
			}); 
			bouttonRadio2.setOnAction((envent) -> {
				controleur = new Controleur(modele2, compteur2Valeur);
			});

			controleur = new Controleur(new Modele(), new Text());

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
