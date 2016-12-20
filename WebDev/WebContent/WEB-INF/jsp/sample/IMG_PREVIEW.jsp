<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)이미지 미리보기</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">

/**
 * 파일 업로드
 */
function imgUpload(){
	var param = new Map();
	sendFormAjax("MyForm", param, "/fileUpload.fileup", imgUploadCallback);		
}

/**
 * 파일 업로드 콜백
 */
function imgUploadCallback(json){
	$("#PREVIEW_IMG").attr("src", "/download.do?uuid="+json.data.fileName+"&name="+json.data.originalFileName);
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
						<h2>이미지 미리보기</h2>
						
						<form enctype="multipart/form-data" id="MyForm" name="MyForm" method="post">
						<table class="table">
							<tbody>
								<tr>
									<td>
										<a href="#" class="thumbnail">
											<img id="PREVIEW_IMG" class="img-responsive" src="" alt="이미지 미리보기" title="이미지 미리보기">
										</a>						
									</td>
								</tr>
								<tr>
									<td>
										<input type="file" id="fileUp" name="fileUp"  data-label="파일" data-required="requird" class="fl" />
										<input type="submit" value="업로드" class="btn btn-info btn-sm fr" onclick="imgUpload();" />
									</td>
								</tr>
							</tbody>
						</table>		
						</form>				
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