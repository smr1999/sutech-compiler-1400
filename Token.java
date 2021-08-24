public class Token {
    public int ID;
    public String Name;
    public String Type;
    public Token(int ID,String Name,String Type){
        this.ID = ID;
        this.Name = Name;
        this.Type = Type;
    }

    public void setType(String Type){
        this.Type = Type;
    }
}
