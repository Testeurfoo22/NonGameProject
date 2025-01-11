package entites.utilisateurs;
import java.util.ArrayList;
import java.util.List;

public class Role {
    public Integer Id;
    public TypeRole Nom;
    public String Description;
    
    public enum TypeRole {
    	Membre, Superviseur, Administrateur
    }

    public Role(Integer Id, TypeRole Nom, String Description){
        this.Id = Id;
        this.Nom = Nom;
        this.Description = Description;
    }
    public Role(){
        
    }

    public static boolean init = true;

    public static List<Role> listeRole = new ArrayList<>();

    public static void initRole(boolean init){
        if (init){
            listeRole.add(new Role(01, TypeRole.Membre, "Un membre est un des éléments du groupe de recherche."
            		+ "Il peut avoir le rôle d'administrateur, de professeur ou de simple membre."));
            listeRole.add(new Role(02, TypeRole.Superviseur, "Un superviseur est le professeur qui est dirige"
            		+ "un activité de recherche en particulier."));
            listeRole.add(new Role(03, TypeRole.Administrateur, "Rôle spécial. Il administre le système (attribution"
            		+ "des rôles, validation des nouveaux membres, supression des activités obsolètes)."));
            init = false;
        }
    }
}
