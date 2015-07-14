package jarbased.defects;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
 
public class FilteredDefectMetrics {
 
	
	public static void main(String[] args) {
		/**
		 * This class takes the defect-prediction-out.arff model which was already generated from raw data by DefectDatasetARFF.java
		 * The purpose of this class is same as the RawDefectMetrics.java.
		 * 
		 * But instead of using raw input (i.e. jira_issue_report.csv), this one uses a higher quality input.
		 * The output of this file is less noisy then the output of RawDefectMetrics.java (i.e. defect-prediction-raw-out.arff)
		 * 
		 * 
		 * **/
		
		//also change the separator ;->,
		try (BufferedReader br = new BufferedReader(new FileReader("C:\\Users\\sharifhan\\Desktop\\defect-prediction-out.arff")))
		//try (BufferedReader br = new BufferedReader(new FileReader("C:\\Users\\sharifhan\\Desktop\\Sharif Hanif PhD\\Defect-dataset-split\\report30splits\\1-jira_issue_report.csv")))
		{
 
			String sCurrentLine;

			String priority = "";
			String project = "";						
			String type = "";			
			boolean entryFound = false;
			
			
			//project_name, project_count, bug_count, new-feature_count, sub-task_count, improvement_count	
			Map<String, LineItem> defectTypeDistribution = new HashMap<>(); 
					
			FileWriter fileWritter = new FileWriter("C:\\Users\\sharifhan\\Desktop\\defect-metrics-dataset.arff", true);
	        BufferedWriter bufferWritter = new BufferedWriter(fileWritter);		
	        
	        bufferWritter.write("@relation		defect-metrics"+"\n\n");
	        
	        
	        bufferWritter.write("@attribute		name					string"+"\n");
	        bufferWritter.write("@attribute		project_count			numeric"+"\n");
	        bufferWritter.write("@attribute		bug_count				numeric"+"\n");	        
	        bufferWritter.write("@attribute		new_feature_count		numeric"+"\n");
	        bufferWritter.write("@attribute		improvement_count		numeric"+"\n");
	        bufferWritter.write("@attribute		sub_task_count			numeric"+"\n");
	        bufferWritter.write("@attribute		blocker_count			numeric"+"\n");
	        bufferWritter.write("@attribute		critical_count			numeric"+"\n");
	        bufferWritter.write("@attribute		major_count				numeric"+"\n");
	        bufferWritter.write("@attribute		minor_count				numeric"+"\n");
	        bufferWritter.write("@attribute		trivial_count			numeric"+"\n");
	        
	        bufferWritter.write("@data"+"\n\n");

	        
			while ((sCurrentLine = br.readLine()) != null) {
				
				String[] lineItem = sCurrentLine.split(",");
								
				
				//32469,'Taavi requested HTML escape support.','Minor',?,'Struts 2','Provide HTML escape support','New Feature'
				
				priority 		= (lineItem.length>3) ? lineItem[2] : "?";
				project 		= (lineItem.length>4) ? lineItem[3] : "?";
				type 			= (lineItem.length>=7) ? lineItem[6] : "?";
				
				project = (project.replace("'", ""));
				priority = (priority.replace("'", ""));
				type = (type.replace("'", ""));
				
				project.trim();
				priority.trim();
				type.trim();
				
				
				
				//already done once in earlier stage. redoing it for sanity check
				if (project.equalsIgnoreCase("Trivial")){
					project = "?";
				}else if(project.equalsIgnoreCase("Major")){
					project = "?";
				}else if(project.equalsIgnoreCase("Minor")){
					project = "?";
				}else if(project.equalsIgnoreCase("Blocker")){
					project = "?";
				}else if(project.equalsIgnoreCase("Closed")){
					project = "?";
				}else if(project.equalsIgnoreCase("Fixed")){
					project = "?";
				}else if(project.equalsIgnoreCase("Open")){
					project = "?";
				}else if(project.equalsIgnoreCase("Critical")){
					project = "?";
				}else if (project.contains("http://") || project.contains("https://")){
					project = "?";
				}else if (project.contains("=") || project.contains("[") || project.contains("]") || project.contains("()") || project.contains("\\") ){
					project = "?";
				}else if (project.contains(":") || project.contains("_") || project.contains("\"") || project.contains("--") || project.contains("(")){
					project = "?";
				}else if (project.contains("<") || project.contains(">") || project.contains("~") || project.contains("*") || project.contains(")")){
					project = "?";
				}else if(project.contains(" ") || project.startsWith("-") || project.contains("+") || project.contains("/") || project.contains(".")){
					project = "?";
				}else if(project.length() > 15){
					project = "?";
				}else if(project.length() < 3){
					project = "?";
				}
				
				
				String[] project_name_split = project.split("-");
				
				if (priority.equalsIgnoreCase("Major")){
					//
				}else if (priority.equalsIgnoreCase("Minor")){
					//
				}else if (priority.equalsIgnoreCase("Critical")){
					//
				}else if (priority.equalsIgnoreCase("Blocker")){
					//
				}else if (priority.equalsIgnoreCase("Trivial")){
					//
				}else{
					priority = "?";
				}
				
				
				
				
				
				entryFound = false; 
				
				for (Entry<String, LineItem> entry : defectTypeDistribution.entrySet()) {
					
					if(project_name_split.length==0){											
						project = "?";
						project_name_split = project.split("-");
					}
					
					if (project.contains(entry.getKey()) || entry.getKey().contains(project) || project_name_split[0].contains(entry.getKey()) || entry.getKey().contains(project_name_split[0])) {
						entryFound = true;
						
						System.out.println("Found: " + entry.getValue().getProject_name());
						entry.getValue().setProject_count(entry.getValue().getProject_count()+1);
						if (type.equalsIgnoreCase("Bug")){
							entry.getValue().setBug_count(entry.getValue().getBug_count()+1);
						}else if (type.equalsIgnoreCase("New Feature")){
							entry.getValue().setNew_feature_count(entry.getValue().getNew_feature_count()+1);
						}else if (type.equalsIgnoreCase("Sub-task")){
							entry.getValue().setSub_task_count(entry.getValue().getSub_task_count()+1);
						}else if (type.equalsIgnoreCase("Improvement")){
							entry.getValue().setImprovement_count(entry.getValue().getImprovement_count()+1);;
						}
						
						if (priority.equalsIgnoreCase("Major")){
							entry.getValue().setMajor_count(entry.getValue().getMajor_count()+1);
						}else if (priority.equalsIgnoreCase("Minor")){
							entry.getValue().setMinor_count(entry.getValue().getMinor_count()+1);							
						}else if (priority.equalsIgnoreCase("Critical")){
							entry.getValue().setCritical_count(entry.getValue().getCritical_count()+1);
						}else if (priority.equalsIgnoreCase("Blocker")){
							entry.getValue().setBlocker_count(entry.getValue().getBlocker_count()+1);
						}else if (priority.equalsIgnoreCase("Trivial")){
							entry.getValue().setTrivial_count(entry.getValue().getTrivial_count()+1);
						}
					
					}
										
					
				}
				
				if (entryFound==false){
					System.out.println("New: " + project);
					LineItem newLineItem = new LineItem();
					newLineItem.setProject_name(project_name_split[0]);
					newLineItem.setProject_count(1);
					
					if (type.equalsIgnoreCase("Bug")){
						newLineItem.setBug_count(1);
					}else if (type.equalsIgnoreCase("New Feature")){
						newLineItem.setNew_feature_count(1);
					}else if (type.equalsIgnoreCase("Sub-task")){
						newLineItem.setSub_task_count(1);
					}else if (type.equalsIgnoreCase("Improvement")){
						newLineItem.setImprovement_count(1);
					}
					
					if (priority.equalsIgnoreCase("Major")){
						newLineItem.setMajor_count(1);
					}else if (priority.equalsIgnoreCase("Minor")){
						newLineItem.setMinor_count(1);							
					}else if (priority.equalsIgnoreCase("Critical")){
						newLineItem.setCritical_count(1);
					}else if (priority.equalsIgnoreCase("Blocker")){
						newLineItem.setBlocker_count(1);
					}else if (priority.equalsIgnoreCase("Trivial")){
						newLineItem.setTrivial_count(1);
					}
					
					defectTypeDistribution.put(project_name_split[0], newLineItem);
					System.out.println("DistributionSize: " + defectTypeDistribution.size());
				}
				
				
			}
			
			
			
			for (Entry<String, LineItem> entry : defectTypeDistribution.entrySet()) {
				
				/*
				 * 	@relation		defect-metrics

					@attribute		name				string
					@attribute		project_count		numeric
					@attribute		bug_count			numeric
					@attribute		new_feature_count	numeric
					@attribute		improvement_count	numeric
					@attribute		sub_task_count		numeric
					@attribute		blocker_count		numeric
					@attribute		critical_count		numeric
					@attribute		major_count			numeric
					@attribute		minor_count			numeric
					@attribute		trivial_count		numeric
				 
				 * */
	
				
				if (entry.getValue().project_count>100 && (entry.getValue().bug_count!=0 || entry.getValue().new_feature_count!=0 || entry.getValue().sub_task_count!=0)){
							bufferWritter.write(entry.getKey() + "," 
							+ entry.getValue().project_count + "," 
							+ entry.getValue().bug_count + "," 
							+ entry.getValue().new_feature_count + "," 
							+ entry.getValue().improvement_count + "," 
							+ entry.getValue().sub_task_count + "," 
							+ entry.getValue().blocker_count + "," 
							+ entry.getValue().critical_count + "," 
							+ entry.getValue().major_count + "," 
							+ entry.getValue().minor_count + "," 
							+ entry.getValue().trivial_count +"\n");
				}				
								
			}
				
			bufferWritter.close();
 
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	
	}
}
