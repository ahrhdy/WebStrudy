<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)셀렉트박스 설정</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var comboBind = new ComboBind("USER_LIST"); //셀렉트 박스 값설정 객체 선언 및 id
var comboBindName = new ComboBind(""); //셀렉트 박스 값설정 객체 선언

$(document).ready(function() {
	setComboBoxById();
	setComboBoxByName();
});

/* 콤보박스 설정(ID값 기반) */
function setComboBoxById(){
	//셀렉트박스에 정보 설정할 url - json타입
	comboBind.controller("/common/emp/list/selEmpList.ajax");
	
	//셀렉트박스 value값에 설정할 json Key값 (설정없을시 기본값 - CODE_VAL)
	comboBind.setValueKey("USER_ID");
	
	//셀렉트박스 text값에 설정헐 json key값  (설정없을시 기본값 - CODE_NAME)
	comboBind.setTextKey("USER_NAME");
	
	//셀렉트박스값 설정
	comboBind.bind();
}

/* 콤보박스 설정(NAME값 기반) */
function setComboBoxByName(){
	//셀렉트박스에 정보 설정할 url - json타입
	comboBindName.controller("/common/emp/list/selEmpList.ajax");
	
	//셀렉트박스 value값에 설정할 json Key값 (설정없을시 기본값 - CODE_VAL)
	comboBindName.setValueKey("USER_ID");
	
	//셀렉트박스 text값에 설정헐 json key값 (설정없을시 기본값 - CODE_NAME)
	comboBindName.setTextKey("USER_NAME");
	
	//셀렉트박스 값을 설정할 셀렉트박스 NAME값
	comboBindName.setComboName("USER_NAME");
	
	//셀렉트박스값 설정
	comboBindName.bind();	
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
	
					<!-- 컨텐츠 START -->
					<div class="col-lg-6">
						<h2>셀렉트박스 설정</h2>
						
						<table id="divDetail" class="table">	
						<tr>
							<th>셀렉트박스 id값 이용 설정</th>
							<td>
								<select id="USER_LIST" name="USER_LIST" class="form-control input-sm" >
								</select>
							</td>
							<th>셀렉트박스 name값 이용 설정</th>
							<td>
								<select name="USER_NAME" class="form-control input-sm" >
								</select>
								<br/>
								<select name="USER_NAME" class="form-control input-sm" >
								</select>
								<br/>
								<select name="USER_NAME" class="form-control input-sm" >
								</select>
							</td>				
						</tr>											
						</table>			
						
					</div>
					<!-- 컨텐츠 END -->
					
					<!-- 소스 뷰어 START -->
					<div class="col-lg-6">
						<%@ include file="sourceView.jsp"%>
					</div>
					<!-- 소스 뷰어 END -->
		
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