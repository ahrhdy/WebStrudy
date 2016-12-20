<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>사용자화면관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind01 = new ListBind("gridList01", false);
var listBind02 = new ListBind("gridList02", false);

$(document).ready(function() {
	getUserList();
	
	$("#gridList01").on("click","tr", getAutList);	
});

function getUserList(){
	var param = new Map();	//파라메터 변수
	setAreaParamData(param, "divSearch");
	listBind01.controller("/aut/selEmpList.ajax");	//컨트롤러 url (리스트 처리용)
	listBind01.setHeaderFix(true);	// (유무, 높이) 그리드 헤더 고정 true, 기본값은 false (테이블 그리드일때만 사용가능함)
	listBind01.setGridPageInfo("divGridInfo01"); //그리드 행 전체 수 
	listBind01.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind01.sendAjax();	//컨트롤러 호출
}

function getAutList(){
	var param = new Map();	//파라메터 변수
	var row = listBind01.rowIdxData($(this).index()); //그리드의 ROW값	
	param.put("USER_ID", row.USER_ID);
	jsonAutoMapping(row, "divDetail");
	
	listBind02.controller("/aut/selAutList.ajax");	//컨트롤러 url (리스트 처리용)
	listBind02.setHeaderFix(true);	// (유무, 높이) 그리드 헤더 고정 true, 기본값은 false (테이블 그리드일때만 사용가능함)
	listBind02.setGridPageInfo("divGridInfo02"); //그리드 행 전체 수 
	listBind02.setCallBack(setAutListChecked); //그리드 조회 후 콜백 함수
	listBind02.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind02.sendAjax();	//컨트롤러 호출		
}

function setAutListChecked(json){
	
	//그리드 생성 후 권한있는 프로그램ID에는 체크박스 처리
	for(var i=0; i<json.data.length; i++){
		if(json.data[i].PGM_YN == "Y"){
			$("input[name='rowAutCheck']").eq(i).prop("checked", true);
		}else{
			$("input[name='rowAutCheck']").eq(i).prop("checked", false);
		}
	}
}

function setData(){
	var param = new Map();	
	param.put("USER_ID", $("#divDetail #USER_ID").val());
	param.put("listData", listBind02.getJsonStringDataChecked("rowAutCheck")); //그리드의 선택 체크박스 이름
	sendJsonAjax("/aut/insAut.ajax", param, setDataCallBack);	
}

function setDataCallBack(json){
	alert("저장되었습니다.");
}
</script>
</head>
<body>
	
	<div id="wrapper">

	<!-- 상단 메뉴 START -->
	<%@ include file="/WEB-INF/jsp/include/IncTop.jsp"%>
	<!-- 상단 메뉴 END -->

        <div id="page-wrapper">

            <div class="container-fluid">
               
                <div class="row">
                    <div class="col-lg-6">
						<h3>사용자목록
							<span class="fr">
								<button class="btn btn-sm btn-default" onclick="initForm('divSearch');">초기화</button>
								<button class="btn btn-sm btn-info" onclick="getUserList();">조회</button>
							</span>
						</h3>
						
						<table id="divSearch" class="table table-bordered table-condensed">
							<tr>
								<th width="10%">아이디</th>
								<td width="40%"><input type="text" id="USER_ID" name="USER_ID" class="form-control input-sm" value="" /></td>
								<th width="10%">이름</th>
								<td width="40%"><input type="text" id="USER_NAME" name="USER_NAME" class="form-control input-sm" value="" /></td>
							</tr>						
						</table>		
									
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="40%">아이디</th>
									<th width="60%">이름</th>
								</tr>
							</thead>
							<tbody id="gridList01" >
								<tr class="curser-pointer">
									<td>{USER_ID}</td>
									<td>{USER_NAME}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo01"></div>	                    
                    </div>
                    
                    <div class="col-lg-6">
						<h3>화면권한
							<span class="fr">
								<input type="button" class="btn btn-sm btn-primary" value="저장" onclick="setData();"/>
							</span>
						</h3>	
						
						<table id="divDetail" class="table table-bordered table-condensed">
							<tr>
								<th width="10%">아이디</th>
								<td width="40%"><input type="text" id="USER_ID" name="USER_ID" class="form-control input-sm" value="" readonly /></td>
								<th width="10%">이름</th>
								<td width="40%"><input type="text" id="USER_NAME" name="USER_NAME" class="form-control input-sm" value="" readonly /></td>
							</tr>						
						</table>								
						<table class="table table-hover table-condensed table-striped">
						<thead>
							<tr>
								<th width="10%"><input type="checkbox" name="checkAll" onclick="checkAll(this, 'rowAutCheck');" /></th>
								<th width="45%">프로그램ID</th>
								<th width="45%">프로그램명</th>
							</tr>
						</thead>
						<tbody id="gridList02" >
							<tr>
								<td><input type="checkbox" name="rowAutCheck" /></td>
								<td>{PGM_ID}</td>
								<td>{PGM_NAME}</td>				
							</tr>
						</tbody>
						</table>
						<div id="divGridInfo02"></div>		                    
                    </div>                    
                </div>
                <!-- /.row -->              	

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->
	
	</div>
	<!-- /#wrapper -->
</body>
</html>