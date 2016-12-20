<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)날짜 선택</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">

$(document).ready(function() {
	//시작일자id, 종료일자id, -일, 포맷('-' or '.') 기본값 "-"
	setDateBetween("startDate", "endDate", 0, "-");
});
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
						<h2>날짜 선택
							<span class="fr">					
								<button class="btn btn-sm btn-info" onclick='setDateBetween("startDate", "endDate", 0, "-");'>오늘</button>
								<button class="btn btn-sm btn-info" onclick='setDateBetween("startDate", "endDate", 3, "-");'>3일 전</button> 
								<button class="btn btn-sm btn-info" onclick='setDateBetween("startDate", "endDate", 7, "-");'>1주일 전</button>
								<button class="btn btn-sm btn-info" onclick='setDateBetween("startDate", "endDate", 30, "-");'>1달 전</button>
								<button class="btn btn-sm btn-info" onclick='setDateBetween("startDate", "endDate", 365, "-");'>1년 전</button>					
							</span>			
						</h2>
						
						<table class="table table-hover table-condensed table-striped">
							<tr>
								<td>기간 : </td>
								<td>
									<input type="text" id="startDate" class="form-control input-sm" data-datepicker="yy-mm-dd" value="" />
								</td>
								<td></td>
								<td>
									<input type="text" id="endDate" class="form-control input-sm" data-datepicker="yy-mm-dd" value="" />
								</td>
							</tr>
						</table>
					</div>
					<!-- 컨텐츠 END -->
					
					<!-- 소스 뷰어 START -->
					<div class="col-md-6">
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