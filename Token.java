public class Token{
    public int ID;
    public String Name;
    public String Type;
    public String Value;


    public Token(){

    }

    public Token(int ID_, String Name_ ,  String Type_ , String Value_){
        this.ID = ID_;
        this.Name = Name_;
        this.Type = Type_;
        this.Value = Value_;
    }
}