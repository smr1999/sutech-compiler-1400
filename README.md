# mini-java compiler

## A simple mini-java project with jflex and cup

### This project created by Sina Sarvari & Sayyed Mohammad Rouzegar

### To run this project follow the instruction
1. install jflex from **[here](https://www.jflex.de/)**
2. create Scanner.java file with command `jflex scanner.jflex`
3. install cup from **[here](http://www2.cs.tum.edu/projects/cup/)**  
__Note: In this prject we add these files so you don`t to download these files !!!__
4. create Parser.java file with command `java -jar java-cup-11b.jar -parser Parser parser.cup`
5. extract java-cup-11b-runtime.jar and place `java_cup` folder near of project
6. compile Main.java with command `javac Main.java`
7. run project with command `java Main inputs\input#.txt`

__Note: In this project we suppose that we have only one block of code so all identifier refers to main method block__


### Shiraz - Shiraz university of technology