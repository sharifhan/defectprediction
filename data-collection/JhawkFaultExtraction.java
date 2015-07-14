package classbased.defects;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;


public class JhawkFaultExtraction {
 
	
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
			
			FileWriter fileWritter = new FileWriter("C:\\Users\\sharifhan\\Desktop\\eclipse-jhawk-metrics.csv", true);
	        BufferedWriter bufferWritter = new BufferedWriter(fileWritter);	
	        
			while ((sCurrentLine = br.readLine()) != null) {
				
				/*
				1000;org.eclipse.jdt.core.antadapter.org.eclipse.jdt.core.CheckDebugAttributes.java;execute;30;60;0
				
				Details of classes for Package org.eclipse.jdt.internal.compiler.batch
				Details of methods for Class ClasspathDirectory

				org.eclipse.jdt.internal.compiler.batch,ClasspathDirectory,1,1,2,15,12,134,44,0,02,2,0,0,3,1,2,0,2,50,0,0,0,0,0,53,77,10,4,0,5,3,0
				*/
				String[] lineItem = sCurrentLine.split(";");				
				idNumber 	= lineItem[0];
				className 	= lineItem[1];
				methodName 	= lineItem[2];
				startLine 	= lineItem[3];
				endLine 	= lineItem[4];
				defective 	= lineItem[5];
				
				try (BufferedReader br2 = new BufferedReader(new FileReader("C:\\Users\\sharifhan\\Desktop\\eclipse-fault-metrics-v3.csv"))){					
					String sJhawkCurrentLine;
					String jhawkClassName=null;			        
					while ((sJhawkCurrentLine = br2.readLine()) != null) {						
						if(sJhawkCurrentLine.startsWith("Details of methods for Class")){
							jhawkClassName = sJhawkCurrentLine.substring(29, sJhawkCurrentLine.length());
							continue;
						}
						
						if(sJhawkCurrentLine.startsWith("Class overview for class")){							
							continue;
						}
						
						if(sJhawkCurrentLine.startsWith("Package overview of package")){							
							continue;
						}
						
						if(sJhawkCurrentLine.startsWith("org.eclipse.")){							
							String[] jhawkLineItemMetrics = sJhawkCurrentLine.split(",");							
							String jhawkPackageName = jhawkLineItemMetrics[0];
							String jhawkMethodName = jhawkLineItemMetrics[1];
							if(jhawkClassName.equals(jhawkMethodName)){
								jhawkMethodName="<init>";								
							}
							if(isNumeric(jhawkMethodName)){
								continue;								
							}
							//System.out.println("JHawk Line: " + jhawkPackageName);
							String m1 = jhawkLineItemMetrics[2];
							String m2 = jhawkLineItemMetrics[3];
							String m3 = jhawkLineItemMetrics[4];
							String m4 = jhawkLineItemMetrics[5];
							String m5 = jhawkLineItemMetrics[6];
							String m6 = jhawkLineItemMetrics[7];
							String m7 = jhawkLineItemMetrics[8];
							String m8 = jhawkLineItemMetrics[9];
							String m9 = jhawkLineItemMetrics[10];
							String m10 = jhawkLineItemMetrics[11];
							String m11 = jhawkLineItemMetrics[12];
							String m12 = jhawkLineItemMetrics[13];
							String m13 = jhawkLineItemMetrics[14];
							String m14 = jhawkLineItemMetrics[15];
							String m15 = jhawkLineItemMetrics[16];
							String m16 = jhawkLineItemMetrics[17];
							String m17 = jhawkLineItemMetrics[18];
							String m18 = jhawkLineItemMetrics[19];
							String m19 = jhawkLineItemMetrics[20];
							String m20 = jhawkLineItemMetrics[21];
							String m21 = jhawkLineItemMetrics[22];
							String m22 = jhawkLineItemMetrics[23];
							String m23 = jhawkLineItemMetrics[24];
							String m24 = jhawkLineItemMetrics[25];
							String m25 = jhawkLineItemMetrics[26];
							String m26 = jhawkLineItemMetrics[27];
							String m27 = jhawkLineItemMetrics[28];
							String m28 = jhawkLineItemMetrics[29];
							String m29 = jhawkLineItemMetrics[30];
							String m30 = jhawkLineItemMetrics[31];
							String m31 = jhawkLineItemMetrics[32];

							/*
							1000;org.eclipse.jdt.core.antadapter.org.eclipse.jdt.core.CheckDebugAttributes.java;execute;30;60;0
							
							Details of classes for Package org.eclipse.jdt.internal.compiler.batch
							Details of methods for Class ClasspathDirectory

							org.eclipse.jdt.internal.compiler.batch,ClasspathDirectory,1,1,2,15,12,134,44,0,02,2,0,0,3,1,2,0,2,50,0,0,0,0,0,53,77,10,4,0,5,3,0
							*/

							if(className.contains(jhawkPackageName) && className.contains(jhawkClassName)){
								//System.out.println("Package: " + jhawkPackageName);
								//String line = idNumber+","+className.replace(";", ",")+","+methodName+","+startLine+","+endLine+","+jhawkPackageName+","+jhawkMethodName+","+m1+","+m2+","+m3+","+m4+","+m5+","+m6+","+m7+","+m8+","+m9+","+m10+","+m11+","+m12+","+m13+","+m14+","+m15+","+m16+","+m17+","+m18+","+m19+","+m20+","+m21+","+m22+","+m23+","+m24+","+m25+","+m26+","+m27+","+m28+","+m29+","+m30+","+m31;
								if(methodName.equals(jhawkMethodName)){
									String line = sCurrentLine+","+sJhawkCurrentLine;
									System.out.println("Line: " + line);
									bufferWritter.write(line);
									bufferWritter.write("\n");
								}
							
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
	
	public static boolean isNumeric(String str)  
	{  
	  try  
	  {  
	    double d = Double.parseDouble(str);  
	  }  
	  catch(NumberFormatException nfe)  
	  {  
	    return false;  
	  }  
	  return true;  
	}
}
