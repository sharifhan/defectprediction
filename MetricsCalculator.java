package jarbased.defects;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

 
public class MetricsCalculator {
 
	
	public static void main(String[] args) {
		String name = "";
		boolean shown=false;
		double columnValue = 0;
		double value = 0;
		double value1 = 0;
		double columnMin = 10000;
		
		try (BufferedReader br = new BufferedReader(new FileReader("C:\\Users\\sharifhan\\Desktop\\defect-metrics.csv")))
		
		{
 
			/**
			 * name=1,project_count=2,bug_count=3,new_feature_count=4,
			 * improvement_count=5,sub_task_count=6,blocker_count=7,
			 * critical_count=8,major_count=9,minor_count=10,trivial_count=11,
			 * NOC=12,WMC=13,CBO=14,RFC=15,LCOM=16,Ca=17,Ce=18,ISTBL=19,LCOM3=20,LOC=21
			 * 
			 * index = number-1
			 * */
			
			String sCurrentLine;
		
	        
			while ((sCurrentLine = br.readLine()) != null) {
				
				String[] lineItem = sCurrentLine.split(",");
				double bug	= Double.parseDouble(lineItem[2]);
				double project	= Double.parseDouble(lineItem[1]);
				
				double blocker	= Double.parseDouble(lineItem[6]);
				double critical	= Double.parseDouble(lineItem[7]);
				
				double density = (bug/project);
				double type = blocker+critical;
				
				double quality = density*type;
				int index=0;
				
				if(quality>5){
					 index = 1; 
				}
				
				System.out.println(lineItem[0] + ": ," + String.format("%.2f", quality).replaceAll(",", ".")+","+index);
				
				
			}
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	
	}
}
