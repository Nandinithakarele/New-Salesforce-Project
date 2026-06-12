public class OpportunityHandler {
    

    public static void updateOpportunityCount(List<Opportunity> oppList){

        Set<Id> contactIds = new Set<Id>();

        for(Opportunity opp : oppList){
            if(opp.ContactId != null){
                contactIds.add(opp.ContactId);
            }
        }

        List<AggregateResult> aggList = [
            SELECT ContactId, COUNT(Id) oppCount
            FROM Opportunity
            WHERE ContactId IN :contactIds
            GROUP BY ContactId
        ];

        List<Contact> contactList = new List<Contact>();

        for(AggregateResult ar : aggList){

            Contact con = new Contact();
            con.Id = (Id) ar.get('ContactId');
            //con.Opportunity_Count__c = (Integer) ar.get('oppCount');

            contactList.add(con);
        }

        if(!contactList.isEmpty()){
            update contactList;
        }
    }



}