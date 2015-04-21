import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Scanner;

// Copyright (c) 2015 K Team. All Rights Reserved.
public class DeleteLLVMComments {

    /**
     * @author LiyiLi
     * This Java program takes an LLVM program as input and eliminates
     * all the comments from it.  The resulting uncommented LLVM program
     * is saved to a temporary string.
     * This step is needed due to a limitation of the current K parser,
     * which cannot parse LLVM comments, and it
     * will be eliminated as soon as the K parser is fixed.
     * @throws InterruptedException 
     */
    public static void main(String[] args) throws InterruptedException {
        
        if(args.length == 0){
            System.err.println("Haven't specified the input program.");
        }
        String fileName = args[0];
        File llvmFile = new File(fileName);
        String newPrintLine = "";
        if(llvmFile.isFile()){//if input file exists.
            try {
                Scanner scanner = new Scanner(llvmFile);
                /**
                 * Declare a variable to indicate whether or
                 * not the current scanning character is inside
                 * a double quote block.
                 * This algorithm works because users cannot write
                 * \" inside a string (starting by " and ending by ") in LLVM.
                 * That is why we can only use a variable (isInQuoteBlock) to keep track of
                 * whether or not the current character is located inside
                 * a string block of a LLVM program.
                 */
                boolean isInQuoteBlock = false;
                
                while(scanner.hasNextLine()){
                    String currentLine = scanner.nextLine();
                    for(int i = 0; i < currentLine.length(); ++i){
                        char currentChar = currentLine.charAt(i);
                        if(currentChar == '"'){
                            isInQuoteBlock = ! isInQuoteBlock;
                        } else if(!isInQuoteBlock
                                    && currentChar == ';'){
                            break;
                        }
                        newPrintLine += currentChar;
                    } //end of for loop
                    newPrintLine += "\n";
                } // end of while loop
                scanner.close();
            } catch (FileNotFoundException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        else {//if input file doesn't exist.
              System.err.println("Input test file " +
                      "is not a file or does not exist.");
        }
        File output = new File(fileName+".temp");
        PrintWriter printWriter = null;
        try {
            printWriter = new PrintWriter(output);
        } catch (FileNotFoundException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        printWriter.print(newPrintLine);
        printWriter.close();
        Process p = null;
        try {
            p = Runtime.getRuntime().exec(new String[]{"/bin/sh", "-c", "\"kast "+fileName+".temp\""});
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        p.waitFor();
     
        BufferedReader reader = 
             new BufferedReader(new InputStreamReader(p.getInputStream()));
     
        String line = "";            
        try {
            while ((line = reader.readLine())!= null) {
                System.out.println(line);
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
