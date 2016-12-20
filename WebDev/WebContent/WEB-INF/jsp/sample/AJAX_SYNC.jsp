<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)AJAX 동기</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
function ajaxSyncSample(){
	var param = new Map();	//파라메터객체 생성
	param.put("URL", location.pathname);	//파라메터 설정 
	
	//sendSyncAjax(url, param) - AJAX 동기 호출 함수 return값 : json
	var json = sendSyncAjax("/common/smp/detail/selSampleDetail.ajax", param);
	alert(JSON.stringify(json));	//로그창에 AJAX결과 정보 출력
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
						<h2>AJAX 동기 처리 예제
							<span class="fr">					
								<input type="button" class="btn btn-sm btn-info" value="조회" onclick="ajaxSyncSample();"/>
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