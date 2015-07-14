package classbased.defects;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class ContinuousProbablictyExtractionForROC {

	public static void main(String[] args) {
		try (BufferedReader br = new BufferedReader(new FileReader("C:\\Users\\sharifhan\\Desktop\\report.raw.test.csv")))
		
		{
			String sCurrentLine;
			String pred_class = "";
			String x0 = "";
			String x1 = "";
			
			
			FileWriter fileWritter = new FileWriter("C:\\Users\\sharifhan\\Desktop\\report.raw.test.out.csv", true);
	        BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
	        
	        while ((sCurrentLine = br.readLine()) != null) {
				
				String[] lineItem = sCurrentLine.split(",");
				
				pred_class = lineItem[2];
				x0 = lineItem[3];
				x1 = lineItem[4];
				
				if(x0.contains("X.0.") & x1.contains("X.1.")){
					bufferWritter.write(sCurrentLine+",\"pred.raw\""+"\n");
				}
				
				if(pred_class.contains("1")){
					bufferWritter.write(sCurrentLine+","+x1+"\n");
				}else if(pred_class.contains("0")){
					bufferWritter.write(sCurrentLine+","+x0+"\n");
				}
				
	        }
	       
	        bufferWritter.close();
	        
		} catch (FileNotFoundException e) {			
			e.printStackTrace();
		} catch (IOException e) {			
			e.printStackTrace();
		}
	}

}
