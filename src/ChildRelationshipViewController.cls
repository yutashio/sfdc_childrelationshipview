public with sharing class ChildRelationshipViewController {

	public String parentObjLabel { get; set; }
	public String parentObjApi { get; set; }
	public Boolean omitCreateAndLastModifiedById { get; set; }
	public List<Map<String,String>> childObjInfosMapList { get; set; }


	public void init(){
		this.parentObjLabel = null;
		this.parentObjApi = null;
		this.omitCreateAndLastModifiedById = null;
	}

	public void execute() {

		this.childObjInfosMapList = new List<Map<String,String>>();

		Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
		for (String key : gd.keySet()) {
			String targetObject = gd.get(key).getDescribe().getLabel();
			if(parentObjLabel == targetObject){
				parentObjApi = key;
			}
		}

		Schema.DescribeSobjectResult dsr = Schema.getGlobalDescribe().get(parentObjApi).getDescribe();
		List<Schema.ChildRelationship> crList = dsr.getChildRelationships();

		for(Schema.ChildRelationship cr : crList){
			Map<String,String> childObjMap = new Map<String,String>();

			childObjMap.put('objectLabel', cr.getChildSObject().getDescribe().getLabel());

			if (String.isBlank(String.valueOf(cr.getChildSObject()))) {
				childObjMap.put('objectAPI', '-');
			}else {
				childObjMap.put('objectAPI', String.valueOf(cr.getChildSObject()));
			}

			if(cr.getChildSObject().getDescribe().isCustom()){
				childObjMap.put('objectSetting', 'Custom');
			}else {
				childObjMap.put('objectSetting', 'Standard');
			}

			childObjMap.put('fieldLabel', cr.getField().getDescribe().getLabel());

			if (String.isBlank(String.valueOf(cr.getField()))) {
				childObjMap.put('fieldAPI', '-');
			}else {
				childObjMap.put('fieldAPI', String.valueOf(cr.getField()));
			}

			if(cr.getField().getDescribe().isCustom()){
				childObjMap.put('fieldSetting', 'Custom');
			}else {
				childObjMap.put('fieldSetting', 'Standard');
			}

			if (String.isBlank(cr.getRelationshipName())) {
				childObjMap.put('childRelationLabel', '-');
			}else {
				childObjMap.put('childRelationLabel', cr.getRelationshipName());
			}

			childObjMap.put('cascadeDelete', String.valueOf(cr.isCascadeDelete()));

			if (omitCreateAndLastModifiedById && (childObjMap.get('fieldAPI') == 'CreatedById' || childObjMap.get('fieldAPI') == 'LastModifiedById')) {

			}else {
				childObjInfosMapList.add(childObjMap);
			}
		}
	}

	public void search(){
		try {
			execute();
		} catch(Exception e) {
			ApexPages.addMessages(e);
		}
	}

	public void clear(){
		init();
	}
}
