package classbased.defects;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

public class ClassLevelEclipseFaultDataS1 {
 
	
	public static void main(String[] args) {
		
		/**
		 * This class takes the Eclipse Fault Data file in a raw format and extracts defect metrics
		 * 
		 * 
		 * **/
		//also change the separator ;->,
		try (BufferedReader br = new BufferedReader(new FileReader("C:\\Users\\sharifhan\\Desktop\\EclipseFaultData.csv")))
		
		{
 
			String sCurrentLine;

			String idNumber = "";
			String className = "";						
			String methodName = "";				
			String startLine = "";
			String endLine = "";
			String defective = "";
			
			FileWriter fileWritter = new FileWriter("C:\\Users\\sharifhan\\Desktop\\eclipse-fault-metrics.arff", true);
	        BufferedWriter bufferWritter = new BufferedWriter(fileWritter);	
	        //bufferWritter.write("idNumber;className;methodName;startLine;endLine;CC;WMC;CBO;RFC;LCOM;Ca;Ce;LCOM3;LCO;defective");
	        
	        bufferWritter.write("@relation		eclipse-defect-metrics"+"\n\n");
	        
	        bufferWritter.write("@attribute		idNumber			numeric"+"\n");
	        bufferWritter.write("@attribute		className			string"+"\n");
	        bufferWritter.write("@attribute		methodName			string"+"\n");	        
	        bufferWritter.write("@attribute		startLine			numeric"+"\n");
	        bufferWritter.write("@attribute		endLine				numeric"+"\n");
	        bufferWritter.write("@attribute		CC					numeric"+"\n");
	        bufferWritter.write("@attribute		WMC					numeric"+"\n");
	        bufferWritter.write("@attribute		CBO					numeric"+"\n");
	        bufferWritter.write("@attribute		RFC					numeric"+"\n");
	        bufferWritter.write("@attribute		LCOM				numeric"+"\n");
	        bufferWritter.write("@attribute		Ca					numeric"+"\n");
	        bufferWritter.write("@attribute		Ce					numeric"+"\n");
	        bufferWritter.write("@attribute		LCOM3				numeric"+"\n");
	        bufferWritter.write("@attribute		LCO					numeric"+"\n");
	        bufferWritter.write("@attribute		defective			{0, 1}"+"\n");
	        
	        bufferWritter.write("@data"+"\n\n");
	        
			while ((sCurrentLine = br.readLine()) != null) {
				//1000;org.eclipse.jdt.core\antadapter\org\eclipse\jdt\core\CheckDebugAttributes.java;execute;30;60;0
				String[] lineItem = sCurrentLine.split(";");
				
				idNumber 	= lineItem[0];
				className 	= lineItem[1];
				methodName 	= lineItem[2];
				startLine 	= lineItem[3];
				endLine 	= lineItem[4];
				defective 	= lineItem[5];
				
				try (BufferedReader br2 = new BufferedReader(new FileReader("C:\\Users\\sharifhan\\Desktop\\metrics-out.txt"))){
					
					String sCurrentLineMetric;
					String sMethodMetric;
					
					
			        
					while ((sCurrentLineMetric = br2.readLine()) != null) {
						
						if(sCurrentLineMetric.startsWith("org.eclipse.")){
							//org.eclipse.jdt.internal.core.builder.State 24 1 0 26 95 90 5 22 1 0,8645 1714 0,1765 6 0,0000 0,1703 0 0 69,7083
							//System.out.println(sCurrentLineMetric);
							String[] lineItemMetrics = sCurrentLineMetric.split(" ");
							
							String metricName 	= lineItemMetrics[0];
							//System.out.println("Class " + className);
							//TimeUnit.MILLISECONDS.sleep(100);
							
							//System.out.println("Metric " + metricName);													

							if(className.contains(metricName)){
								//System.out.println("TRUE");
								
								while ((sMethodMetric = br2.readLine()) != null) {
									if(sMethodMetric.contains("~")){
										if(sMethodMetric.contains(methodName)){
											String CC = sMethodMetric.substring(sMethodMetric.indexOf(':') + 1).trim();
											System.out.println(CC);
											
											String _WMC		= lineItemMetrics[1];
											String _CBO		= lineItemMetrics[4];
											String _RFC		= lineItemMetrics[5];
											String _LCOM	= lineItemMetrics[6];
											String _Ca		= lineItemMetrics[7];
											String _Ce		= lineItemMetrics[8];
											String _LCOM3	= lineItemMetrics[10].replaceAll(",", ".");
											String _LCO		= lineItemMetrics[11].replaceAll(",", ".");
											
											bufferWritter.write(idNumber+","+className+","+methodName+","+startLine+","+endLine+","+CC+","+_WMC+","+_CBO+","+_RFC+","+_LCOM+","+_Ca+","+_Ce+","+_LCOM3+","+_LCO+","+defective+"\n");
											
										}
									}else{
										break;
									}
								}
								
								//System.out.println("Class " + className);
								//System.out.println("Metric " + metricName);
								/*
								double _WMC		= (lineItemMetrics.length>1) ? Double.parseDouble( lineItemMetrics[1]) : 0;
								double _CBO		= (lineItemMetrics.length>4) ? Double.parseDouble( lineItemMetrics[4]) : 0;
								double _RFC		= (lineItemMetrics.length>5) ? Double.parseDouble( lineItemMetrics[5]) : 0;
								double _LCOM	= (lineItemMetrics.length>6) ? Double.parseDouble( lineItemMetrics[6]) : 0;
								double _Ca		= (lineItemMetrics.length>7) ? Double.parseDouble( lineItemMetrics[7]) : 0;
								double _Ce		= (lineItemMetrics.length>8) ? Double.parseDouble( lineItemMetrics[8]) : 0;
								double _LCOM3	= (lineItemMetrics.length>10) ? Double.parseDouble( lineItemMetrics[10].replaceAll(",", ".")) : 0;
								double _LCO		= (lineItemMetrics.length>11) ? Double.parseDouble( lineItemMetrics[11].replaceAll(",", ".")) : 0;
								
								bufferWritter.write(idNumber+";"+className+";"+methodName+";"+_WMC+";"+_CBO+";"+_RFC+";"+_LCOM+";"+_Ca+";"+_Ce+";"+_LCOM3+";"+_LCO+";"+defective+"\n");
								*/
							}
							
													
						}
						
					}
					
					
					
				}
				
			}
			
			bufferWritter.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	
	}
}
