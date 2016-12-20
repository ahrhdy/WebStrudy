<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)에디터 기능</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var editor;	//그리드에 사용될 변수 선언

$(document).ready(function() {
	// ready함수 안에 있거나 textarea태그 아래쪽에 스크립트로 선언
	editor = new Editor({"id":"editor", "toolbar":true, "mode":true, "vertical":true});
});

/* 에디터 글 넣기 */
function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	editor.pasteHtml(sHTML);
}

/* 에디터 폰트변경 */
function setDefaultFont() {
	var sDefaultFont = '궁서';
	var nFontSize = 24;
	editor.setFont(sDefaultFont, nFontSize);
}

/* 에디터 값 가져오기 */
function getContents(){
	var editText = editor.getContents();
	alert(editText);
}

/* 에디터 내용 지우기 */
function resetContent(){
	editor.clear();
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
						<h2>에디터 기능</h2>	
						
						<textarea name="editor" id="editor" rows="10" cols="100" style="display:none;"></textarea>			
						<p>
							<input type="button" class="btn btn-sm btn-primary" onclick="pasteHTML();" value="본문에 내용 넣기" />
							<input type="button" class="btn btn-sm btn-primary" onclick="getContents();" value="본문 내용 가져오기" />
							<input type="button" class="btn btn-sm btn-primary" onclick="setDefaultFont();" value="기본 폰트 지정하기 (궁서_24)" />
							<input type="button" class="btn btn-sm btn-primary" onclick="resetContent();" value="초기화" />
						</p>
						
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