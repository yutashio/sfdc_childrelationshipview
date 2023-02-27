public with sharing class RedirectObjManagerController {

	public PageReference init(){
		String objectLabel = ApexPages.currentPage().getParameters().get('objectLabel');
		SObject entityDefId = getEntityDefId(objectLabel);
		PageReference target = new PageReference('/lightning/setup/ObjectManager/'+entityDefId.get('EntityDefinitionId')+'/Details');
		target.setRedirect(true);
		return target;
	}

	public SObject getEntityDefId(String objectLabel){
		return [SELECT EntityDefinitionId FROM FieldDefinition WHERE EntityDefinition.QualifiedApiName= :objectLabel LIMIT 1];
	}
}