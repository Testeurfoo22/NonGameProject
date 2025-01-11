package entites;
public class Interet {
    
    public Integer Id;
    public String Nom;
    public String Desciption;

    public static String[] InitInteret = {
        "Goal modeling",
        "Design-time uncertainty",
        "Product lines",
        "Domain-specific modeling",
        "Collaborative modeling",
        "Model transformations",
        "Code synthesis",
        "AI-powered assistance",
        "Pattern mining",
    };
    public static String[] InitInteretDesc = {
        "G.m Description",
        "D-t.u Description",
        "P.l Description",
        "D-s.m Description",
        "C.m Description",
        "M.t Description",
        "C.s Description",
        "AI-p.a Description",
        "P.m Description",
    };

    public Interet(Integer Id, String Nom, String Desciption){
        this.Id = Id;
        this.Nom = Nom;
        this.Desciption = Desciption;
    }
    public Interet(){

    }
}
