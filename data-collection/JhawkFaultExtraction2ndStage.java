package classbased.defects;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;


public class JhawkFaultExtraction2ndStage {
 
	
	public static void main(String[] args) {
		
		/**
		 * This class takes the Eclipse Fault Data file in a raw format and extracts defect metrics
		 * 
		 * 
		 * **/
		//also change the separator ;->,
		try (BufferedReader br = new BufferedReader(new FileReader("C:\\Users\\sharifhan\\Desktop\\defect-metrics-jhawk.txt")))
			{
 
			String sCurrentLine;

			
			FileWriter fileWritter = new FileWriter("C:\\Users\\sharifhan\\Desktop\\eclipse-jhawk-metrics-v2.csv", true);
	        BufferedWriter bufferWritter = new BufferedWriter(fileWritter);	
	        
			while ((sCurrentLine = br.readLine()) != null) {
				
				String[] lineItem = sCurrentLine.split(",");
				
				if(lineItem.length==39){
					System.out.println("Line: " + sCurrentLine);
					bufferWritter.write(sCurrentLine);
					bufferWritter.write("\n");
				}
				
			}
			
			bufferWritter.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	
	}
	
}
