package jarbased.defects;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
 
public class CkjmExtractor {
 
	
	public static void main(String[] args) {
		/**
		 * 
		 * org.apache.accumulo.core.iterators.filter.ColumnAgeOffFilter 6 1 0 6 14 0 1 6 6 0,5000 70 0,0000 1 0,0000 0,3667 0 0 10,3333
 		 * **/
		
		
		try (BufferedReader br = new BufferedReader(new FileReader("D:\\Jars\\metrics-out.txt")))
		
		{
 
			String sCurrentLine;
			int NOC = 0; //number of classes in a package
			double WMC = 0;
			double CBO = 0;
			double RFC = 0;
			double Ca = 0;
			double Ce = 0;
			double Instability = 0;
			double LCOM = 0;
			double LCOM3 = 0;
			double LCO = 0;
			
	        
			while ((sCurrentLine = br.readLine()) != null) {
				
				if(!sCurrentLine.contains("~")){
					String[] lineItem = sCurrentLine.split(" ");
					
					
					
					double _WMC		= (lineItem.length>1) ? Double.parseDouble( lineItem[1]) : 0;
					double _CBO		= (lineItem.length>4) ? Double.parseDouble( lineItem[4]) : 0;
					double _RFC		= (lineItem.length>5) ? Double.parseDouble( lineItem[5]) : 0;
					double _LCOM	= (lineItem.length>6) ? Double.parseDouble( lineItem[6]) : 0;
					double _Ca		= (lineItem.length>7) ? Double.parseDouble( lineItem[7]) : 0;
					double _Ce		= (lineItem.length>8) ? Double.parseDouble( lineItem[8]) : 0;
					double _LCOM3	= (lineItem.length>10) ? Double.parseDouble( lineItem[10].replaceAll(",", ".")) : 0;
					double _LCO		= (lineItem.length>11) ? Double.parseDouble( lineItem[11].replaceAll(",", ".")) : 0;
					
					NOC++;
					WMC = WMC + _WMC;
					CBO = CBO + _CBO;
					RFC = RFC + _RFC;
					LCOM = LCOM + _LCOM;
					Ca = Ca + _Ca;
					Ce = Ce + _Ce;
					Instability = Ce / (Ce+Ca);
					LCOM3 = LCOM3 + _LCOM3;
					LCO = LCO + _LCO;
					//4120, 4.71, 6.77, 15.27, 37.2, 2.6, 4.38, 0.63, 0.48, 120.07
					//4120,4.71,6.77,15.27,37.20,2.60,4.38,0.63,0.48,120.07
					//System.out.println(NOC+", "+df.format(WMC/NOC).replaceAll(",", ".")+", "+df.format(CBO/NOC).replaceAll(",", ".")+", "+df.format(RFC/NOC).replaceAll(",", ".")+", "+df.format(LCOM/NOC).replaceAll(",", ".")+", "+df.format(Ca/NOC).replaceAll(",", ".")+", "+df.format(Ce/NOC).replaceAll(",", ".")+", "+df.format(Instability).replaceAll(",", ".")+", "+df.format(LCOM3/NOC).replaceAll(",", ".")+", "+df.format(LCO/NOC).replaceAll(",", "."));
					System.out.println(NOC+","+String.format("%.2f", WMC/NOC).replaceAll(",", ".")+","+String.format("%.2f", CBO/NOC).replaceAll(",", ".")+","+String.format("%.2f", RFC/NOC).replaceAll(",", ".")+","+String.format("%.2f", LCOM/NOC).replaceAll(",", ".")+","+String.format("%.2f", Ca/NOC).replaceAll(",", ".")+","+String.format("%.2f", Ce/NOC).replaceAll(",", ".")+","+String.format("%.2f", Instability).replaceAll(",", ".")+","+String.format("%.2f", LCOM3/NOC).replaceAll(",", ".")+","+String.format("%.2f", LCO/NOC).replaceAll(",", "."));
				}
				
			}	
 
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	
	}
}
