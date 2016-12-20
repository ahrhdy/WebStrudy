<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false);
var comboBind01 = new ComboBind("BRD_KINDCD");
var comboBind02 = new ComboBind("BRD_AUTH_KINDCD");
var comboBind03 = new ComboBind("BRD_DISP_KINDCD");

$(document).ready(function() {
	getDataList();
	comboBind01.setComboName("BRD_KINDCD");
	comboBind01.setCodeSection("CD003");	
	comboBind02.setCodeSection("CD004");
	comboBind03.setCodeSection("CD005");
	
	$("#gridList").on("click","tr", getDetail);	
});


function getDataList(){
	var param = new Map();	//파라메터 변수
	
	//divSearch영역의 폼태그의 value값을 읽어와 파라메터를 생성한다.		
	setAreaParamData(param, "divSearch");
	
	listBind.controller("/brd/selBrdKindList.ajax");	//컨트롤러 url
	listBind.setHeaderFix(true);
	listBind.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind.setGridPageInfo("divGridInfo01"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind.sendAjax();	//컨트롤러 호출
}

function getDetail(){
	var row = listBind.rowIdxData($(this).index()); //그리드의 ROW값
	jsonAutoMapping(row, "divDetail");	
}

function setData(){
	var param = new Map();	
	var validation = new Validation("divDetail");
	
	if(!validation.check()){
		return false;
	}
	
	setAreaParamData(param, "divDetail");
	sendJsonAjax("/brd/insBrd04.ajax", param, setDataCallBack);	
}

function setDataCallBack(){
	alert("저장되었습니다.");
	getDataList();
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
						<h3>게시판 목록
							<span class="fr">					
								<input type="button" class="btn btn-sm btn-info" value="조회" onclick="getDataList();"/>
							</span>
						</h3>
						
						<table id="divSearch" class="table table-bordered table-condensed">
							<tr>
								<th width="15%">게시판종류</th>
								<td width="35%">
									<select id="BRD_KINDCD" name="BRD_KINDCD" class="form-control input-sm">
									</select>
								</td>
							</tr>												
						</table>		
									
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="20%">게시판종류</th>						
									<th width="20%">게시판권한</th>
									<th width="20%">게시표현</th>
									<th width="20%">파일첨부</th>
									<th width="20%">첨부 수</th>
								</tr>
							</thead>
							<tbody id="gridList">
								<tr class="curser-pointer">
									<td>{BRD_KINDCD_NM}</td>
									<td>{BRD_AUTH_KINDCD_NM}</td>
									<td>{BRD_DISP_KINDCD_NM}</td>
									<td>{FILE_ATTACH_YN}</td>
									<td>{FILE_ATTACH_CNT}</td>
								</tr>
							</tbody>
						</table>	
						<div id="divGridInfo01"></div>
					</div>
					
					<div class="col-lg-6">
			
						<div id="divDetail">
							<h3>상세</h3>
							<table class="table table-bordered">			
							<tr>
								<th>게시판종류</th>
								<td colspan="3">
									<select id="BRD_KINDCD" name="BRD_KINDCD" class="form-control input-sm" data-label="게시판종류" data-required="requird" >
									</select>						
								</td>
							</tr>
							<tr>
								<th>게시판권한</th>
								<td colspan="3">
									<select id="BRD_AUTH_KINDCD" name="BRD_AUTH_KINDCD" class="form-control input-sm" data-label="게시판권한" data-required="requird" >
									</select>						
								</td>
							</tr>
							<tr>
								<th>게시판표현</th>
								<td colspan="3">
									<select id="BRD_DISP_KINDCD" name="BRD_DISP_KINDCD" class="form-control input-sm" data-label="게시판표현" data-required="requird" >
									</select>						
								</td>
							</tr>
							<tr>
								<th width="20%">파일 첨부 여부</th>
								<td width="30%">
									<input type="radio" id="FILE_ATTACH_YN" name="FILE_ATTACH_YN" data-label="파일첨부여부" data-required="requird" value="Y" />예 
									<input type="radio" name="FILE_ATTACH_YN" value="N" />아니오						
								</td>
								<th width="20%">파일 첨부 수</th>
								<td width="30%">
									<input type="text" id="FILE_ATTACH_CNT" name="FILE_ATTACH_CNT" data-label="파일첨부수" data-required="requird number" class="form-control input-sm" value="" />					
								</td>					
							</tr>																
							</table>	
							<div class="text-center">
								<button class="btn btn-sm btn-primary" onclick="setData();">저장</button>
								<button class="btn btn-sm btn-danger" onclick="">삭제</button>
							</div>				
						</div>
			
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