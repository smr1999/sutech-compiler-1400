import java.io.*;
import java.util.Vector;

public class Main {
  public static void main(String[] args) {
    Vector<Token> allTokens = new Vector<>();
    try {
      Scanner scanner = new Scanner(new FileReader(args[0]));
      scanner.setTable(allTokens);

      Parser parser = new Parser(scanner);
      parser.setTable(allTokens);

      Object result = parser.parse().value;
      printTable(allTokens);
      
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  public static void printTable(Vector<Token> allTokens){
    System.out.println();
    TableList tl = new TableList(3, "ID" , "Name" , "Type").sortBy(0).withUnicode(true);
    allTokens.forEach(item -> tl.addRow(String.valueOf(item.ID),item.Name,item.Type));
    tl.print();
  }
}
