import org.firmata.*;
import cc.arduino.*;

import processing.serial.*;
import java.io.*;
int mySwitch=0;
String [] subtext;
Serial myPort;


void setup(){
 //Create a switch that will control the frequency of text file reads.
 //When mySwitch=1, the program is setup to read the text file.
 //This is turned off when mySwitch = 0
 mySwitch=1;
 size(800, 600);
 //Open the serial port for communication with the Arduino
 //Make sure the COM port is correct
 myPort = new Serial(this, "COM9", 9600);
 myPort.bufferUntil('\n');
 readData("C:/Users/Ivo/Documents/spilog.csv");
}

void draw() {
 if (mySwitch>0){
 /*The readData function can be found later in the code.
 This is the call to read a CSV file on the computer hard-drive. */
 
 
 /*The following switch prevents continuous reading of the text file, until
 we are ready to read the file again. */
 mySwitch=0;
 }
 
 
 
 for(String s : subtext){
   myPort.write(s);
 }	

 
 	
 
 
 /*
 myPort.write(subtext[1]);
 myPort.write("\n");
 myPort.write(subtext[2]);
 myPort.write("\n");
 myPort.write(subtext[3]);
*/
 delay(500);

 mySwitch=1;
 
}


/* The following function will read from a CSV or TXT file */
void readData(String myFileName){
 
 File file=new File(myFileName);
 BufferedReader br=null;
 
 try{
 br=new BufferedReader(new FileReader(file));
 String text=null;
 
 /* keep reading each line until you get to the end of the file */
 while((text=br.readLine())!=null){
 	println("lijn ingelezen: " + text);
 /* Spilt each line up into bits and pieces using a comma as a separator */
 if(text != null){
   append(subtext, text);
 }
 
 }
 
 
 }catch(FileNotFoundException e){
 e.printStackTrace();
 }catch(IOException e){
 e.printStackTrace();
 }finally{
 try {
 if (br != null){
 	println("bestand ingelezen");
 br.close();
 }
 } catch (IOException e) {
 e.printStackTrace();
 }
 }
}
