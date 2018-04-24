public with sharing class CaseAfterInsertHandler implements TriggerHandler.HandlerInterface{
	public void handle() {
		List<Task> newTasks = TaskServices.generateTasksForCases((List<Case>) Trigger.new);
		insert newTasks;
	}
}
