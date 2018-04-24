trigger CaseTrigger on Case (
    before insert,
    before update,
    before delete,
    after insert,
    after update,
    after delete,
    after undelete) {

        new TriggerHandler()
        .bind(TriggerHandler.Evt.afterInsert, new CaseAfterInsertHandler())
        .manage();

}
