<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)유효성 검사</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">

$(document).ready(function() {
	
});

/* 유효성검사 처리 */
function checkValied(){
	// 유효성검사 체크 할 항목
	// 필수, 최소글자, 숫자만, 날자형식, 영어만, 영어&숫자 입력,메일양식, 홈페이지양식, 비번&재확인, 기간? from to,	
	var valid = new Validation("divDetail"); //유효성 검사 처리할 form 영역 또는 div 영역 id 
	if(valid.check()){ //check(); false값이 리턴되면 유효성 검사 통과 실패.
		var param = new Map();
		
		setAreaParamData(param, "divDetail");
		alert(JSON.stringify(param));
	}

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
						<h2>유효성 검사
							<span class="fr">					
								<button class="btn btn-sm btn-default" onclick="initForm('');">초기화</button>
								<button class="btn btn-sm btn-info" onclick="checkValied();">유효성 검사</button>				
							</span>			
						</h2>
						
						<table id="divDetail" class="table">
						<tr>
							<th width="10%">이름</th>
							<td width="40%">
								<input type="text" id="FIRST_NAME" name="FIRST_NAME" data-label="이름" data-required="requird eng" class="form-control input-sm" value="" />
							</td>
							<th width="10%">사번</th>
							<td width="40%">
								<input type="text" id="EMPLOYEE_ID" name="EMPLOYEE_ID" data-label="사번" data-required="requird number minlength:3" class="form-control input-sm" value="" />
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" id="PASSWORD" name="PASSWORD" data-label="비밀번호" data-required="requird minlength:8" class="form-control input-sm" value="" placeholder="Enter password"/>
							</td>
							<th>재확인</th>
							<td>
								<input type="password" id="REPASS" name="REPASS" data-label="재확인" data-required="requird equals:PASSWORD" class="form-control input-sm" value="" />
							</td>
						</tr>		
						<tr>
							<th>직업</th>
							<td>
								<select id="JOB_ID" data-required="requird" data-label="직업" class="form-control input-sm" >
									<option value="">선택</option>
									<option value="프로그래머">프로그래머</option>
									<option value="프로게이머">프로게이머</option>
									<option value="프로게이">프로게이</option>
								</select>
							</td>
							<th>입사일</th>
							<td>
								<input type="text" id="HIRE_DATE" name="HIRE_DATE" data-label="입사일" data-required="requird dateFormat:yyyy-mm-dd" class="form-control input-sm" data-datepicker="yy-mm-dd" value="" />
							</td>
						</tr>
						<tr>
							<th>시작</th>
							<td>
								<input type="text" id="START_DATE" name="START_DATE" data-label="시작" data-required="requird dateFormat:yyyy.mm.dd" class="form-control input-sm" data-datepicker="yy.mm.dd" value="" />
							</td>
							<th>종료</th>
							<td>
								<input type="text" id="END_DATE" name="END_DATE" data-label="종료" data-required="requird dateFormat:yyyymmdd" class="form-control input-sm" data-datepicker="yymmdd" value="" />
							</td>
						</tr>			
						<tr>
							<th>이메일</th>
							<td>
								<input type="text" id="EMAIL" name="EMAIL" data-label="이메일" data-required="email" class="form-control input-sm" value="" />
							</td>
							<th>전화번호</th>
							<td>
								<input type="text" id="PHONE_NUMBER" data-label="전화번호" name="PHONE_NUMBER" data-required="tel" class="form-control input-sm" value="" />
							</td>
						</tr>
						<tr>
							<th>연봉</th>
							<td>
								<input type="text" id="SALARY" name="SALARY" data-label="연봉" data-required="number" class="form-control input-sm" value="" />
							</td>
							<th>라디오</th>
							<td>
								<label class="radio-inline"><input type="radio" id="CHOICE" data-label="라디오" name="CHOICE" data-required="requird" value="Y">Option 1</label>
								<label class="radio-inline"><input type="radio" name="CHOICE" value="N">Option 2</label>
							</td>
						</tr>		<tr>
							<th>최소</th>
							<td>
								<input type="text" id="MIN" name="MIN" data-label="최소" data-required="number min:5" class="form-control input-sm" value="" />
							</td>
							<th>최대</th>
							<td>
								<input type="text" id="MAX" name="MAX" data-label="최대" data-required="number max:5" class="form-control input-sm" value="" />
							</td>
						</tr>
						<tr>
							<th>URL 주소</th>
							<td colspan="3">
								<input type="text" id="URL" name="URL" data-label="인터넷주소" data-required="url" class="form-control input-sm" />
							</td>
						</tr>			
						<tr>
							<th>체크박스</th>
							<td colspan="3">
								<label class="checkbox-inline"><input type="checkbox" data-label="체크박스" id="CHK1" name="CHK1" value="Y">Option 1</label>
								<label class="checkbox-inline"><input type="checkbox" data-label="체크박스" id="CHK2" name="CHK2" value="Y">Option 2</label>
								<label class="checkbox-inline"><input type="checkbox" data-label="체크박스" id="CHK3" name="CHK3" value="Y">Option 3</label>				
							</td>
						</tr>		
						<tr>
							<th>상세입력</th>
							<td colspan="3">
								<textarea  id="DETAIL" name="DETAIL" data-label="상세입력" class="form-control input-sm" rows="5"></textarea>
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