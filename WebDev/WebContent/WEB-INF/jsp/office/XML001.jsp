<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>XML 리더</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false);

$(document).ready(function() {
	getDataList();
	
});

/**
 * xml 조회
 */
function getDataList(){
	var param = new Map();	//파라메터 변수
	
	//divSearch영역의 폼태그의 value값을 읽어와 파라메터를 생성한다.		
	setAreaParamData(param, "divSearch");
	
	listBind.controller("/selXmlUrlReader.ajax");	//컨트롤러 url
	listBind.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind.setGridPageInfo("divGridInfo"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id	
	listBind.sendAjax();	//컨트롤러 호출
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
                
					<h3>RSS 조회
						<span class="fr">
							<button class="btn btn-sm btn-info" onclick="getDataList()">조회</button>
						</span>
					</h3>
						
					<table id="divSearch" class="table table-bordered table-condensed">
						<tr>
							<th width="10%">RSS URL</th>
							<td width="90%">
								<input type="text" id="URL" name="URL" data-label="url" 
								data-required="requird url" class="form-control input-sm" 
								value="http://blog.rss.naver.com/mogoyo1.xml" />
							</td>
						</tr>						
					</table>		
				
				 	<table class="table table-hover table-condensed table-striped">
						<thead data-headersort="gridList">
							<tr>
								<th width="10%" data-column="title">제목</th>
								<th width="50%" data-column="description">내용</th>
								<th width="15%" data-column="link">등록일자</th>
							</tr>
						</thead>
						<tbody id="gridList">			
							<tr>
								<td>{title}</td>					
								<td><a href="{link}" target="_blank">{description}</a></td>
								<td>{pubDate}</td>
							</tr>
						</tbody>
					</table>
					<div id="divGridInfo"></div>		
					
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