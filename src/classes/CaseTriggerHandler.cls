public with sharing class CaseTriggerHandler {

	final List<Case> newRecords;
    final Map<Id, Case> oldMap;

    public CaseTriggerHandler(List<Case> newRecords, Map<Id, Case> oldMap)
    {
        this.newRecords = newRecords;
        this.oldMap = oldMap;
    }

	public void afterInsert(){
		List<Task> newTasks = TaskServices.generateTasksForCases(this.newRecords);
		insert newTasks;
	}
}
