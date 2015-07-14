package jarbased.defects;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
 
public class DefectDatasetARFF {
 
	
	public static void main(String[] args) {
			
		/**
		 * This class takes the raw input and produce the refined WEKA model of defect-dataset.arff file.
		 * 
 		 * The output of this file is used to create defect metrics with DefectTypeDistribution.java
		 * 
		 * **/
		
		try (BufferedReader br = new BufferedReader(new FileReader("C:\\Users\\sharifhan\\Desktop\\Sharif Hanif PhD\\Software Defect Dataset\\Software Defect Dataset\\jira_issue_report.csv")))
		{
 
			String sCurrentLine;
			
			String id = "";
			String description = "";
			String priority = "";
			String project = "";
			String project_name = "";
			String title = "";
			String type = "";
			String content = "";
			
			int invalidCounter;			
			FileWriter fileWritter = new FileWriter("C:\\Users\\sharifhan\\Desktop\\defect-prediction-dataset.arff", true);
	        BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
			
			//20200,?,Minor,XMLCOMMONS,'XML Commons','[PATCH] bad imports',Improvement
	        bufferWritter.write("@relation		defect-prediction"+"\n\n");

			
			bufferWritter.write("@attribute		id				numeric"+"\n");
			
			bufferWritter.write("@attribute		description		string"+"\n");
			
			bufferWritter.write("@attribute		priority		{Trivial, Minor, Major, Critical, Blocker}"+"\n");
			
			bufferWritter.write("@attribute		project			string"+"\n");
			
			bufferWritter.write("@attribute		project_name	string"+"\n");
			
			bufferWritter.write("@attribute		title			string"+"\n");
			
			bufferWritter.write("@attribute		type			{Bug, 'New Feature', Sub-task, Improvement}"+"\n\n");
		
			bufferWritter.write("@data"+"\n\n");
			
			while ((sCurrentLine = br.readLine()) != null) {
				
				String[] lineItem = sCurrentLine.split(",");
				
				//cleaning level 1 = missing features
				
				
				id 				= (lineItem.length>1) ? lineItem[0] : "?"; 
				description 	= (lineItem.length>3) ? lineItem[2] : "?";
				priority 		= (lineItem.length>5) ? lineItem[4] : "?";
				project 		= (lineItem.length>6) ? lineItem[5] : "?";
				project_name 	= (lineItem.length>7) ? lineItem[6] : "?";
				title 			= (lineItem.length>12) ? lineItem[11] : "?";
				type 			= (lineItem.length>=13) ? lineItem[12] : "?";
				
				//cleaning level 2 = invalid features 
				
				if (description.isEmpty()){
					description = "?";
				}else if (description.contains("http://") || description.contains("https://")){
					description = "?";
				}else if (description.contains("=") || description.contains("[") || description.contains("]") || description.contains("()") || description.contains("\\") ){
					description = "?";
				}else if (description.contains(":") && description.contains("-") && description.contains("\"")){
					description = "?";
				}else if (description.contains("<") || description.contains(">") || description.contains("~") || description.contains("*")){
					description = "?";
				}else if (description.length() > 200){
					description = "?";
				}else if (description.length() < 20){
					description = "?";
				}
				
				description = (description.replace(",", " "));
				description = (description.replace("'", ""));
				
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
				
				
				//sometimes this field overlaps with other values
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
				
				project = (project.replace("'", ""));
			
				//sometimes this field overlaps with other values
				if (project_name.equalsIgnoreCase("Trivial")){
					project_name = "?";
				}else if(project_name.equalsIgnoreCase("Major")){
					project_name = "?";
				}else if(project_name.equalsIgnoreCase("Minor")){
					project_name = "?";
				}else if(project_name.equalsIgnoreCase("Blocker")){
					project_name = "?";
				}else if(project_name.equalsIgnoreCase("Closed")){
					project_name = "?";
				}else if(project_name.equalsIgnoreCase("Fixed")){
					project_name = "?";
				}else if(project_name.equalsIgnoreCase("Open")){
					project_name = "?";
				}else if(project_name.equalsIgnoreCase("Critical")){
					project_name = "?";
				}else if (project_name.contains("http://") || project_name.contains("https://")){
					project = "?";
				}else if (project_name.contains("=") || project_name.contains("[") || project_name.contains("]") || project_name.contains("()") || project_name.contains("\\") ){
					project = "?";
				}else if (project_name.contains(":") || project_name.contains("_") || project_name.contains("\"") || project_name.contains("--") || project_name.contains("(")){
					project = "?";
				}else if (project_name.contains("<") || project_name.contains(">") || project_name.contains("~") || project_name.contains("*") || project_name.contains(")")){
					project = "?";
				}else if(project_name.contains(" ") || project_name.startsWith("-") || project_name.contains("+") || project_name.contains("/") || project_name.contains(".")){
					project = "?";
				}else if(project_name.length() > 25){
					project = "?";
				}else if(project_name.length() < 3){
					project = "?";
				}
				
				project_name = (project_name.replace("'", ""));
				
				//sometimes this field overlaps with other values
				if (title.equalsIgnoreCase("Trivial")){
					title = "?";
				}else if(title.equalsIgnoreCase("Major")){
					title = "?";
				}else if(title.equalsIgnoreCase("Minor")){
					title = "?";
				}else if(title.equalsIgnoreCase("Blocker")){
					title = "?";
				}else if(title.equalsIgnoreCase("Closed")){
					title = "?";
				}else if(title.equalsIgnoreCase("Fixed")){
					title = "?";
				}else if(title.equalsIgnoreCase("Open")){
					title = "?";
				}else if(title.equalsIgnoreCase("Critical")){
					title = "?";
				}else if (title.contains("=") || title.contains("[") || title.contains("]") || title.contains("()") || title.contains("\\") ){
					description = "?";
				}else if (title.startsWith(":") || title.startsWith("-") || title.contains("\"")|| title.contains("/")){
					description = "?";
				}else if (title.contains("<") || title.contains(">") || title.contains("~") || title.contains("*") || title.contains("{")){
					description = "?";
				}else if(title.contains("|") || title.startsWith(":")){
					title = "?";
				}else if(title.length() > 150){
					title = "?";
				}else if(title.length() < 15){
					title = "?";
				}else if(title.isEmpty()){
					title = "?";
				}else if(title.length() > 2){					
					if(!Character.isAlphabetic(title.charAt(0))){
						title = "?";
					}					
				}
				
				title = (title.replace("'", ""));
				
				if (type.equalsIgnoreCase("Bug")){
					//
				}else if (type.equalsIgnoreCase("New Feature")){
					//
				}else if (type.equalsIgnoreCase("Sub-task")){
					//
				}else if (type.equalsIgnoreCase("Improvement")){
					//
				}else{
					type = "?";
				}
				
				
				//cleaning level 3 = data integrity
				invalidCounter = 0;			
				
				if (title.contains("?")) invalidCounter=invalidCounter+3;	
				if (description.contains("?")) invalidCounter=invalidCounter+2;		
				if (project.contains("?") && project_name.contains("?")) invalidCounter=invalidCounter+2;
				
				if (description.contains("?") || title.contains("?")) invalidCounter++;				
				if (project.contains("?") || project_name.contains("?")) invalidCounter++;						
				if (type.contains("?") || priority.contains("?")) invalidCounter++;
						
				//ARFF adaptor
				if(!description.equalsIgnoreCase("?")) description = "'"+description+"'";
				if(!priority.equalsIgnoreCase("?")) priority = "'"+priority+"'";
				if(!project.equalsIgnoreCase("?")) project = "'"+project+"'";
				if(!project_name.equalsIgnoreCase("?")) project_name = "'"+project_name+"'";
				if(!title.equalsIgnoreCase("?")) title = "'"+title+"'";
				if(!type.equalsIgnoreCase("?")) type = "'"+type+"'";
				
				
				if (invalidCounter<2){
					content = id+","+description+","+priority+","+project+","+project_name+","+title+","+type+"\n";
					//content = "id="+id+",description="+description+",priority="+priority+",project="+project+",project_name="+project_name+",title="+title+",type="+type+"\n";
					
					try {
						System.out.println(content);
						bufferWritter.write(content);
			    	    
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
				
			
			}
			
			bufferWritter.close();
 
		} catch (IOException e) {
			e.printStackTrace();
		}
 
	}
}
