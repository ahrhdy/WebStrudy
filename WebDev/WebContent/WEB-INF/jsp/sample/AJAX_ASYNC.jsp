<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)AJAX 비동기</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
function ajaxAsyncSample(){
	var param = new Map();	//파라메터객체 생성
	param.put("URL", location.pathname);	//파라메터 설정 
	
	//sendJsonAjax(url, param, callback함수);
	sendJsonAjax("/common/smp/detail/selSampleDetail.ajax", param, ajaxAsyncCallBack);
}

//Ajax 비동기 콜백 함수
function ajaxAsyncCallBack(json){
	alert(JSON.stringify(json));
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
						<h2>AJAX 비동기 처리 예제
							<span class="fr">					
								<input type="button" class="btn btn-sm btn-info" value="조회" onclick="ajaxAsyncSample();"/>
							</span>			
						</h2>		
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