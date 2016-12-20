<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function() {
	getSampleSource();
});

function getSampleSource(){
	var param = new Map();
	param.put("URL", location.pathname);
	var json = sendSyncAjax("/common/smp/detail/selSampleDetail.ajax", param);				
	$("#divSourceView").html(json.data.SOURCE);	
	
	
}
</script>
<h2 >소스</h2>
<div id="divSourceView"></div>
