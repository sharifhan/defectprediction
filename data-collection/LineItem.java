package jarbased.defects;

public class LineItem {
	//project_name, project_count, bug_count, new-feature_count, sub-task_count, improvement_count, trivial_count, minor_count, major_count, critical_count, blocker_count			
	  String project_name = "";
	  int project_count = 0;
	  int bug_count = 0;
	  int new_feature_count = 0;
	  int sub_task_count = 0;
	  int improvement_count = 0;
	  
	  int trivial_count = 0;
	  int minor_count = 0;
	  int major_count = 0;
	  int critical_count = 0;
	  int blocker_count = 0;
	
		public String getProject_name() {
		return project_name;
		}
	  
	  	public void setProject_name(String project_name) {
			this.project_name = project_name;
		}
	  	
	  	
	
		public int getProject_count() {
			return project_count;
		}
		
		public void setProject_count(int project_count) {
			this.project_count = project_count;
		}
		
		public int getBug_count() {
			return bug_count;
		}
		
		public void setBug_count(int bug_count) {
			this.bug_count = bug_count;
		}
		
		public int getNew_feature_count() {
			return new_feature_count;
		}
		
		public void setNew_feature_count(int new_feature_count) {
			this.new_feature_count = new_feature_count;
		}
		
		public int getSub_task_count() {
			return sub_task_count;
		}
		
		public void setSub_task_count(int sub_task_count) {
			this.sub_task_count = sub_task_count;
		}
		
		public int getImprovement_count() {
			return improvement_count;
		}
		
		public void setImprovement_count(int improvement_count) {
			this.improvement_count = improvement_count;
		}

		public int getTrivial_count() {
			return trivial_count;
		}

		public void setTrivial_count(int trivial_count) {
			this.trivial_count = trivial_count;
		}

		public int getMinor_count() {
			return minor_count;
		}

		public void setMinor_count(int minor_count) {
			this.minor_count = minor_count;
		}

		public int getMajor_count() {
			return major_count;
		}

		public void setMajor_count(int major_count) {
			this.major_count = major_count;
		}

		public int getCritical_count() {
			return critical_count;
		}

		public void setCritical_count(int critical_count) {
			this.critical_count = critical_count;
		}

		public int getBlocker_count() {
			return blocker_count;
		}

		public void setBlocker_count(int blocker_count) {
			this.blocker_count = blocker_count;
		}
		  
		 

}
