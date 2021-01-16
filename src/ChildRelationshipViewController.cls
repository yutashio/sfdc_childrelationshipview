public with sharing class ChildRelationshipViewController {

	public String parentObjLabel { get; set; }
	public String parentObjApi { get; set; }
	public Boolean omitCreateAndLastModifiedById { get; set; }
	public List<List<String>> childObjInfos { get; set; }
	public List<List<String>> childObjInfosOverThousands { get; set; }


	public void init(){
		this.parentObjLabel = null;
		this.parentObjApi = null;
		this.omitCreateAndLastModifiedById = null;
	}

	public void execute() {

		this.childObjInfos = new List<List<String>>();
		this.childObjInfosOverThousands = new List<List<String>>();

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
			List<String> childObjList = new List<String>();

			childObjList.add(cr.getChildSObject().getDescribe().getLabel());

			if (String.isBlank(String.valueOf(cr.getChildSObject()))) {
				childObjList.add('-');
			}else {
				childObjList.add(String.valueOf(cr.getChildSObject()));
			}

			childObjList.add(cr.getField().getDescribe().getLabel());

			if (String.isBlank(String.valueOf(cr.getField()))) {
				childObjList.add('-');
			}else {
				childObjList.add(String.valueOf(cr.getField()));
			}

			if (String.isBlank(cr.getRelationshipName())) {
				childObjList.add('-');
			}else {
				childObjList.add(cr.getRelationshipName());
			}

			childObjList.add(String.valueOf(cr.isCascadeDelete()));

			if (omitCreateAndLastModifiedById && (childObjList.get(3) == 'CreatedById' || childObjList.get(3) == 'LastModifiedById')) {

			}else {
				if(childObjInfos.size()<1000){
					childObjInfos.add(childObjList);
				}else {
					childObjInfosOverThousands.add(childObjList);
				}
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
