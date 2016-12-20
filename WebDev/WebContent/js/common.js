//전역 변수 설정
var COL_LEFT_TAG = "{",	//그리드 생성시 컬럼의 시작 태그
	COL_RIGHT_TAG = "}",//그리드 생성시 컬럼의 마지막 태그
	PARAM_CURPAGE = "CurPage",	// 그리드 페이징처리에 사용되는 현재페이지 파라메터 키값
	PARAM_ROWCOUNT = "RowCount",// 그리드 페이징처리에 사용되는 보여줄 ROW수의 키값
	DATABASE_TYPE = false,	// DB에 따른 페이징 파라메터 값 설정 변수
	NO_DATA_MESSGE = "조회 데이터가 없습니다.",	//그리드 조회 데이터가 없을때 그리드에 표현될 문구
	GRID_JSON_DATA = "gridJsonData",//그리드에 저장되는 JSON 속성정보
	LOG_MODE = false;//로그보이기 여부
	LOG_DISP_ID = "logContents",//js로그 화면 id값
	IFRM_PDFVIWER_ID = "iFrmPdfView",//iframe PDF 뷰어 ID
	DAUM_MAP_API_KEY = "3fca7a84d691d1805b09042e80b8eda6";

$(document).ready(function(){
	initLogDisplay(); // log 창 초기화
	initjqDatePicker(); //jquery datepicker input스캔	
	initLayerPopup(); //레이어 팝업 공지 처리
	initCommonCode();
});

/* AJAX 통신 후 서버쪽에서 ERROR가 있는 경우 */
$( document ).ajaxComplete(function( event, request, settings ) {
	if(request["responseJSON"]["errorMessage"] != null){
		alert(request["responseJSON"]["errorMessage"]);
	}	
	logWrite("url : "+settings.url);
	logWrite("param : "+settings.data);
	logWrite("<br/>");
}).ajaxError(function(event, request, setting){
	logWrite("★★★★★★★★★★★★★ ERROR ★★★★★★★★★★★★★");
	logWrite("url : " +setting.url);
	logWrite("param : " + setting.data);
	logWrite("status : " + request.status);
	logWrite("<br/>");
	alert("[ajax error] => URL : " +setting.url+", STATUS : " + request.status);
});

/**
 * 공통코드 호출
 */
function initCommonCode(){
	if(!localStorage.COMMON_CODE){
		var param = new Map();	
		sendJsonAjax("/common/cde/list/selCodeDetailList.ajax", param, initCommonCodeCallBack);		
	}
}

/**
 * 공통코드 localStorage 저장
 */
function initCommonCodeCallBack(json){
	localStorage.setItem("COMMON_CODE", JSON.stringify(json.data));
}

/**
 * 레이어팝업 공지 조회
 */
function initLayerPopup(){
	var param = new Map();
	param.put("PGM_URL", window.location.pathname);
	sendJsonAjax("/common/lnt/detail/selLntDetail.ajax", param, initLayerPopupCallBack);
}

/**
 * 레이어팝업 공지 화면 처리
 */
function initLayerPopupCallBack(json){
	if(json.data != null && !getCookie(json.data.PGM_ID)){
		var selOneDay = "<div><input id='checkNotice01' name='checkNotice' type='radio' value='Day' /><label for='checkNotice01'>1일간 보지 않기</label>&nbsp;",
			selMonth = "<input id='checkNotice02' name='checkNotice' type='radio' value='Month' /><label for='checkNotice02'>한달간 보지 않기</label></div>",
			layerId = json.data.PGM_ID,
			closeButton = "<div class=\"fr btn glyphicon glyphicon-remove\" onclick=\"layerPopupClose('"+layerId+"');\"></div>";
		$("body").append("<div id='"+layerId+"' class='layer' style='z-index:-9999;'></div>");
		$("#"+layerId).css({
			"left" : json.data.POS_X,
			"top" : json.data.POS_Y,
			"z-index" : 9999,
			"position" : "fixed"
		}).html(closeButton + json.data.CONTENTS + selOneDay + selMonth);		
	}
}

/**
 * 레이어팝업 닫기 이벤트
 */
function layerPopupClose(layerId){
	$("#"+layerId).fadeOut(500);
	var checkVal = $("input[name='checkNotice']:checked").val();
	
	if(checkVal == "Day"){
		setCookie(layerId, checkVal, 1);
	}else if(checkVal == "Month"){
		setCookie(layerId, checkVal, 30);
	}
}


/*
 * jquery datepicker 속성을 스캔 처리
 */
function initjqDatePicker(){
	$("[data-datepicker]").datepicker({
		changeMonth: true,          
		changeYear: true,
		dateFormat : "yy-mm-dd",
        showButtonPanel: true, 
        currentText: '오늘', 
        closeText: '닫기',
		dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
		dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
		monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	}).each(function(){
		$(this).datepicker("option", "dateFormat", $(this).attr("data-datepicker"));
	});	
}

/*
 * 화면 로드시 로그 창 생성
*/
function initLogDisplay(){
	
	if(LOG_MODE){
		var logDivWid = 400, 
			logDivHei = 200, 
			xPos = $(window).width() - logDivWid - 16,
			yPos = $(window).height() - logDivHei,
			htmlTag = [];
		
		htmlTag.push("<div>");
		htmlTag.push("<span class='fr'><span id='logClear' style='cursor: pointer;' class='glyphicon glyphicon-trash'></span>");
		htmlTag.push("<span class='fr'><span id='logClose' style='cursor: pointer;' class='glyphicon glyphicon-remove'></span>");
		htmlTag.push("</span></div>");
		htmlTag.push("<div id='"+LOG_DISP_ID+"'></div>");
		
		$("body").append("<div id='logDiv'></div>");		
		
		var $selecter = $("#logDiv");
		$selecter.css({
			"width" : logDivWid,
			"height" : logDivHei,
			"position" : "fixed",
			"left" : xPos,
			"top" : yPos,
			"background-color" : "#000"
		}).addClass("opacity60").html(htmlTag.join(""));	
		
		$("#"+LOG_DISP_ID).css({
			"width" : logDivWid,
			"height" : logDivHei,
			"overflow-y" : "scroll",
			"color" : "#FFF",
			"padding" : "5px"
		}).addClass("word-wrap");
		
		$(window).off("resize").on("resize", function(){
			$selecter.css("left", $(window).width() - logDivWid - 16).css("top", $(window).height() - logDivHei);			
		});
		
		//로그창 화면 닫기
		$("#logClose").on("click", function(){
			$selecter.fadeOut("slow");
		});
		
		//로그창 클리어
		$("#logClear").on("click", function(){
			$("#"+LOG_DISP_ID).empty();
		});
	}
}

/*
 * 로그창에 로그 쓰기
*/
function logWrite(txt){
	if(LOG_MODE){
		var $selecter = $("#"+LOG_DISP_ID);
		if(typeof txt == "object"){
			$selecter.append(JSON.stringify(txt) +"<br/>");
		}else{
			$selecter.append(txt +"<br/>");
		}	
		
		var el = document.getElementById(LOG_DISP_ID);
		if(el.scrollHeight > 0){
			el.scrollTop = el.scrollHeight;
		}
	}
}

/*
*	java HashMap을 흉내낸 객체
*/
var Map = function(){
	this.map = {};
};

Map.prototype = {
	put : function(key, value) {		
		this.map[key] = value;
	},	
	get : function(key) {
		return this.map[key];
	},
	containsKey : function(key) {
		for(var prop in this.map){
			if(key == prop){
				return true;
			}
		}
		return false;
	},
	containsValue : function(value){
		for(var key in this.map){
			if(value == this.map[key])
			{
				return true;
			}
		}
		return false;
	},
	size : function(){
		var count = 0;
		for(var prop in this.map){
			count++;
		}
		return count;
	},
	clear : function(){
		this.map = {};
	},
	setJson : function(json){
		for(var key in json){
			this.map[key] = json[key];
		}		
	}
};

/*
*	ajax json으로 그리드 바인딩 처리
*/
var ListBind = function(tagId, pagingMode){
	this.tagId = tagId;
	this.param = {};	// 컨트롤러쪽으로 보낼 파라메터
	this.callbackFunction;	//그리드 생성후 콜백함수
	this.option = {
		url : '', //그리드 바인딩시 호출할 컨트롤러 주소
		currentPage : 1, //페이징 처리시에 현재페이지 기본값
		rowCount : 10, //그리드에 보여줄 row 수 기본값
		pagingSupport : pagingMode, //그리드의 페이징기능 사용유무 true, false
		pagingDispId : '', //페이징처리 할때 페이지번호 보여줄 태그 id 값
		pagingInfoId : '', //그리드의 전체 카운트, 현재페이지 정보 보여줄 id 값
		headerFixSupport : false, //그리드의 헤더고정 후 스크롤 기능 처리 유무
		headerFixState : false, //그리드의 헤더고정 처리 유무 상태값
		height : 500, //그리드 헤더고정 스크롤 기능 처리시 그리드의 기본 높이 값
		excelColumn : '', //그리드 엑셀 다운로드 컬럼명(영어) a,b,c
		excelLabel : '', //그리드 엑셀 다운로드 라벨명(한글) 번호,제목,작성자
		pdfColumn : '', //그리드 PDF 다운로드 컬럼명(영어) a,b,c
		pdfLabel : '', //그리드 PDF 다운로드 라벨명(한글) 번호,제목,작성자
		pdfTitle : '', //그리드 PDF에 보여줄 제목
		jsonDataKey : 'data', //그리드 json 키값
		jsonCountKey : 'count' //그리드 json 카운트 키값(페이징처리) 
	};

	$(document).ready(function(){		
		ListBind.prototype._initJsonGrid(tagId);
	});
};

ListBind.prototype = {
	_initJsonGrid : function(gridId){		
		var gridRowTag = document.getElementById(gridId).innerHTML;	//그리드가 표현될 ROW 태그
		$.data(document, gridId, gridRowTag);			//key, value로 저장하여 원본태그 값을 저장한다.
		//$("#"+gridId).children().remove();
		ListBind.prototype._gridEmptyDisplay(gridId);
	},
	controller : function(url){
		this.option["url"] = url;
	},
	setRowCount : function(count){
		this.option["rowCount"] = count;
	},
	setParam : function(param){
		this.param = param;
	},
	setPageId : function(pageDisId){
		this.option["pagingDispId"] = pageDisId;
	},
	setGridPageInfo : function(pagingInfoId){
		this.option["pagingInfoId"] = pagingInfoId;
	},
	setHeaderFix : function(supportMode, heigth){
		this.option["headerFixSupport"] = supportMode;
		if(heigth == undefined){
			var tmpHeight = Math.floor($(document).height() - $("#"+this.tagId).offset().top - 35);
			this.option["height"] = (tmpHeight < 150) ? 150 : tmpHeight;
		}else{
			this.option["height"] = heigth;
		}
		
		if(supportMode && !this.option["headerFixState"]){   
			ListBind.prototype.gridHeaderFixed(this.tagId, this.option["height"]);
			this.option["headerFixState"] = true;
		}		
		
	},
	setCallBack : function(funcName){
		this.callbackFunction = funcName;
	},
	bindGrid : function(json){
		var _tagId = this.tagId, _option = this.option;
		 
		ListBind.prototype._jsonGridBind(_tagId, json); 
		
		if(_option.pagingInfoId != ""){
			var info = "전체 : "+json.length +"개";
			$("#"+_option["pagingInfoId"]).text(info);			
		}		
		
		if(_option.headerFixSupport){
			ListBind.prototype._gridWidthSync(_tagId);			
		}    
		ListBind.prototype._gridDataSort(); //헤더클릭시 정렬기능 이벤트 처리	  
	},	
	sendAjax : function(){		
		this.option.currentPage = 1; //조회시 1부터 초기화
		var	_tagId = this.tagId,
			_option = this.option,
			_function = this.callbackFunction,
			_curPage = this.option.currentPage,	//현재 페이지
			_rowCnt = this.option.rowCount,	//그리드에 보여줄 row수
			paramMap = this.param["map"];

		/*
		if(document.location.hash){
			_curPage =  document.location.hash.replace("#","");
		}
		*/
		
		if(DATABASE_TYPE){
			paramMap[PARAM_CURPAGE] = (_curPage -1) * _rowCnt + 1 ;  /* 오라클 */
		}else{
			paramMap[PARAM_CURPAGE] = (_curPage == 1)?0:(_curPage -1) * _rowCnt;  /* 프레임웤 */
		}
		
		paramMap[PARAM_ROWCOUNT] = _rowCnt;
		
		ListBind.prototype._sendGridAjax(_tagId, paramMap, _option, _function);			
		
		//페이징 버튼 클릭시 처리
		if(_option.pagingSupport){
			
			$("#"+_option.pagingDispId).off("click").on("click", "a, img",function(){
				_curPage = $(this).attr("data-pageNo");
				_option.currentPage = _curPage;
				
				if(DATABASE_TYPE){
					paramMap[PARAM_CURPAGE] = (_curPage -1) * _rowCnt + 1 ;
				}else{
					paramMap[PARAM_CURPAGE] = (_curPage == 1)?0:(_curPage -1) * _rowCnt;
				}
				ListBind.prototype._sendGridAjax(_tagId, paramMap, _option, _function);							
			});
						
		}		
	},
	_sendGridAjax : function(gridId, param, option, callbackFunction){
		$.ajax({
			type: "post",
			url: option.url,
			data: param,
			dataType: "json",
		    success: function (json) {	
		    	
		    	if(json.errorMessage != undefined){
		    		return false;
		    	}
		    	
				if(json[option.jsonDataKey].length > 0){				
					
					ListBind.prototype._jsonGridBind(gridId, json[option.jsonDataKey]);					
					
					if(option.pagingSupport){ 
						ListBind.prototype._jsonPagingBind(option.pagingDispId, json[option.jsonCountKey], option.currentPage, param[PARAM_ROWCOUNT]);
					}
					if(option.pagingInfo != ""){
						var info = "";
						
						if(option.pagingSupport){
							info = "전체 : "+json[option.jsonCountKey]+"개  / 현재 "+option.currentPage+"페이지";
						}else{
							info = "전체 : "+json[option.jsonDataKey].length +"개";
						}						
						$("#"+option["pagingInfoId"]).text(info);						
					}
					//그리드 틀고정 사용 시 width 동기화 					
					if(option.headerFixSupport){
						ListBind.prototype._gridWidthSync(gridId);				
					}
					ListBind.prototype._gridDataSort();	//헤더클릭시 정렬기능 이벤트 처리
				}else{
					$("#"+option.pagingDispId).html("");
					ListBind.prototype._gridEmptyDisplay(gridId);
				}
				
				if(typeof callbackFunction === 'function'){				
					callbackFunction(json);
				}
		    }
		});		
	},
	_jsonGridBind : function(gridId, data){
		var $selecter = $("#"+gridId),
			col_left = COL_LEFT_TAG,
			col_right = COL_RIGHT_TAG,
			gridRowHtml = $.data(document, gridId), //setGridConfig 함수에서 저장된 ROW 태그
			arrTagInfo = [],
			arr_column = [],
			dataLenth = data.length;		
		$selecter.empty().data(GRID_JSON_DATA, data);	//json값을 그리드의 id.data에 저장한다.
		
		if(dataLenth > 0){
			for (var prop in data[0]) {
				arr_column.push(prop);
			}
		}
		
		for ( var i = 0; i < dataLenth; i++) {
			data[i]["INDEX"] = i; //그리드 row index 값 설정
			var tmpHtml = gridRowHtml;	
			for (var j=0, columLength = arr_column.length; j < columLength; j++) {
				tmpHtml = tmpHtml.split(col_left + arr_column[j] + col_right).join(data[i][arr_column[j]]); 
			}
			arrTagInfo.push(tmpHtml);	
		}		
		$selecter.html(arrTagInfo.join(""));
	},
	_jsonGridBindAppend : function(gridId, data){
		var $selecter = $("#"+gridId),	
			gridTag = $.data(document, gridId), //setGridConfig 함수에서 저장된 ROW 태그
			arrTagInfo = [],
			arr_column = [],
			dataLenth = data.length,
			col_left = COL_LEFT_TAG,
			col_right = COL_RIGHT_TAG;		
		
		if($selecter.data(GRID_JSON_DATA) == undefined){
			$selecter.data(GRID_JSON_DATA, data);	//json값을 그리드의 id.data에 저장한다.
			$selecter.children().remove();
		}else{
			$.merge($selecter.data(GRID_JSON_DATA), data); // 기존의 json값과 새로운 json값 병합
		}	
		
		if(dataLenth > 0){
			for (var prop in data[0]) {
				arr_column.push(prop);
			}
		}		
		
		for ( var i = 0; i < dataLenth; i++) {
			data[i]["INDEX"] = i; //그리드 row index 값 설정
			var tmpHtml = gridTag;	
			for (var j=0, columLength = arr_column.length; j < columLength; j++) {
				tmpHtml = tmpHtml.split(col_left +  arr_column[j] + col_right).join(data[i][arr_column[j]]); 
			}
			arrTagInfo.push(tmpHtml);	
		}		
		$selecter.append(arrTagInfo.join(""));		
	},
	_jsonPagingBind : function(tagId, rowCount, nowPage, viewRow){
		var pagingNumCnt = 5,	// 보여줄 페이지의 수 (n페이지씩 보여줌)
			lastPage = Math.ceil(rowCount/viewRow),	//마지막페이지
			pageIndex = Math.ceil(nowPage/pagingNumCnt),	//페이지 시작 위치
			beginIndex = (pageIndex == 1)?1:(pageIndex-1) * pagingNumCnt + 1, //페이지 이전,현재,다음 위치
			arrHtml = [];
		
		arrHtml.push("<ul  class=\"pagination\">");	
		arrHtml.push("<li><a href=\"#1\" data-pageNo=\"1\" aria-label=\"Previous\"><span aria-hidden=\"true\">&laquo;</span></a></li>");
		if(beginIndex>1){
			arrHtml.push("<li><a href=\"#"+(beginIndex-1)+"\" data-pageNo='"+(beginIndex-1)+"' >Prev</a></li>");
		}		
		for(var i = beginIndex; i < beginIndex + pagingNumCnt; i++){
			if(i<=lastPage){
				arrHtml.push("<li><a href=\"#"+i+"\" data-pageNo="+i+" >"+i+"</a></li>");
			}
		}		
		if(pageIndex != Math.ceil(lastPage/pagingNumCnt)){
			arrHtml.push("<li><a href=\"#"+(beginIndex+pagingNumCnt)+"\" data-pageNo='"+(beginIndex+pagingNumCnt)+"' >Next</a></li>");
		}
		arrHtml.push("<li><a href=\"#"+lastPage+"\" data-pageNo='"+lastPage+"' aria-label=\"Next\"><span aria-hidden=\"true\">&raquo;</span></a></li>");	
		arrHtml.push("</ul>");	
		
		$("#"+tagId).html(arrHtml.join("")).find("li").each(function(){
			if($(this).text()==nowPage ){
				$(this).addClass("active");
			}
		});
	},
	_gridDataSort : function(){
		var b_sort = true, $header = $("[data-headersort]");
		
		$header.off("click").on("click" ,function(e){
			var gridId = this.getAttribute("data-headersort"),
				jsonData = $("#"+gridId).data(GRID_JSON_DATA),
				columnKey = e.target.getAttribute("data-column");		
			
			if(b_sort){
				jsonData.sort(function(a,b) {
				    if (a[columnKey] < b[columnKey]){
				    	return 1;
				    }
				    if(a[columnKey] > b[columnKey]){
				    	return -1;
				    }		        
				    return 0;
				});	
				b_sort = false;
			}else{
				jsonData.sort(function(a,b) {
				    if (a[columnKey] < b[columnKey]){
				    	return -1;
				    }
				    if(a[columnKey] > b[columnKey]){
				    	return 1;
				    }		        
				    return 0;
				});	
				
				b_sort = true;
			}		
			
			ListBind.prototype._jsonGridBind(gridId, jsonData);
			ListBind.prototype._gridWidthSync(gridId);
			
		}).css("cursor","pointer");
	},
	gridHeaderFixed : function(tagId, height){
		var $tagId = $("#"+tagId),		
			gridWidth = $tagId.parent().css("width"),
			tableCss = $tagId.parent().attr("class"),
			gridHeaderId = tagId + "_HEADER";
		
		$tagId.unwrap();			
		$tagId.prev().wrap("<table id='"+gridHeaderId+"' class=\""+tableCss+"\" style=\"margin-bottom:0px;\"></table>");
		$tagId.wrap("<div><table class=\""+tableCss+"\"></table></div>");
		$tagId.parent().css("width", gridWidth);
		$tagId.parent().parent().css("height", height).css({
			"overflow-y" : "scroll",
			"overflow-x" : "hidden"
		});
		
		$("#"+gridHeaderId).css("width", gridWidth);
		
		//테이블 사이즈 변경 시 td사이즈 재조정
		$(window).off("resize").on("resize", function(){
			$tagId.parent().css("width", $("#"+gridHeaderId).width());
			ListBind.prototype._gridWidthSync(tagId);
		});
	},
	_gridWidthSync : function(tagId){
		
		var widths = [], colcnt = $("#"+tagId+"_HEADER").find("thead > tr:eq(0)").children().size();
		
		if(colcnt == 0){
			return false;
		}	
		
		$("#"+tagId+"_HEADER").find("thead > tr:eq(0)").children().each( function(i, element) {
			widths[i] = $(element).width();
		});	
		
		$("#"+tagId+"> tr:eq(0)").children().each( function(i, element) {
			$(element).css("width", widths[i] + "px");
		});		
	},
	_gridEmptyDisplay : function(tagId){
		var html = $.parseHTML($.data(document, tagId)),
	    nodeNames = [],
	    emptyTag = "";
	
		$.each( html, function( i, el ) {							
			nodeNames[i] = el.nodeName;
		});
		//alert(JSON.stringify(nodeNames));
		if("#text"==nodeNames[0]){
			if("TR" == nodeNames[1]){
				emptyTag = "<tr><td colspan='20' style='text-align:center;'>"+NO_DATA_MESSGE+"</td></tr>";
			}else{						
				emptyTag = "<div>"+NO_DATA_MESSGE+"</div>";
			}
		}else{
			if("TR" == nodeNames[0]){
				emptyTag = "<tr><td colspan='20'>"+NO_DATA_MESSGE+"</td></tr>";
			}else{						
				emptyTag = "<div>"+NO_DATA_MESSGE+"</div>";
			}						
		}
	
		$("#"+tagId).removeData().html(emptyTag);		
	},
	setExcelColumn : function(column){
		this.option["excelColumn"] = column;
	},
	setExcelLabel : function(label){
		this.option["excelLabel"] = label;
	},
	excelDownLoad : function(){
		var url = "/common/json/download.excel",
			strJson = JSON.stringify($("#"+this.tagId).data(GRID_JSON_DATA)),
			strColumn = this.option.excelColumn.trim(),
			strLabel = this.option.excelLabel.trim(),
			formHtml = [];
		
		formHtml.push("<form id='jsonExcelForm' method='post' action='"+url+"' >");
		formHtml.push("<input type='text' name='jsonExcelData' value='"+strJson+"' /> ");
		formHtml.push("<input type='text' name='jsonExcelColumn' value='"+strColumn+"' /> ");
		formHtml.push("<input type='text' name='jsonExcelLabel' value='"+strLabel+"' /> ");
		formHtml.push("</form>");
		
		$("body").append(formHtml.join(""));
		$("#jsonExcelForm").submit().remove();		
	},
	setPdfColumn : function(column){
		this.option["pdfColumn"] = column;
	},
	setPdfLabel : function(label){
		this.option["pdfLabel"] = label;
	},
	setPdfTitle : function(title){
		this.option["pdfTitle"] = title;
	},
	rowIdxData : function(idx){
		return  $("#"+this.tagId).data(GRID_JSON_DATA)[idx];
	},
	_rowData : function(tagId, idx){
		return  $("#"+tagId).data(GRID_JSON_DATA)[idx];
	},	
	rowColumn : function(idx, column){
		return  $("#"+this.tagId).data(GRID_JSON_DATA)[idx][column];
	},
	rowEdit : function(idx){
		var $gridId = $("#"+this.tagId),	
			jsonData = ListBind.prototype._rowData(this.tagId, idx),
			datePickerYn = false;
		
		$gridId.children().eq(idx).find("[data-input]").each(function(){
			var $obj = $(this),
				inputType   = $obj.data("input"),
				columnName  = $obj.data("column"),
				inputCss    = $obj.data("class"),
				datePicker  = $obj.data("datepicker"),
				columnValue = jsonData[columnName],
				inputTag = [];
			
			if(inputType=="text"){
				inputTag.push("<input ");
				inputTag.push("type='"+inputType+"' ");
				inputTag.push("name='"+columnName+"' ");				
				inputTag.push("value='"+columnValue+"' ");
				inputTag.push("style=\"width:100%;\" ");
				inputTag.push("class='"+inputCss+"' ");								
				if(datePicker){
					datePickerYn = true;
					inputTag.push("data-datepicker=\""+datePicker+"\" ");						
				}				
				inputTag.push("/>");
				$obj.html(inputTag.join(""));
			}
			//var fn = window[$obj.data("bind")];
			//fn($obj.find("select"), columnValue);
		});
				
		if(datePickerYn){
			initjqDatePicker();	// datePicker 이벤트 처리
		}		
	},
	rowSave : function(idx){
		var $gridId = $("#"+this.tagId), jsonData = ListBind.prototype._rowData(this.tagId, idx);
		
		$gridId.children().eq(idx).find("[type='text'], select").each(function(i){			
			$(this).parent().text($(this).val());
			jsonData[$(this).attr("name")] = $(this).val();
		});
		
		$gridId.children().eq(idx).addClass("info");	//변경된로우 표시
		$gridId.data(GRID_JSON_DATA)[idx] = jsonData;	//그리드 JSON 값 수정
		return jsonData;
	},
	rowUp : function(idx){
		if(idx == 0){
			alert("그리드의 최상단입니다.");
			return false;
		}
		var $gridId = $("#"+this.tagId),
			jsonData01 = ListBind.prototype._rowData(this.tagId, idx),
			jsonData02 = ListBind.prototype._rowData(this.tagId, idx-1);
		
		$gridId.data(GRID_JSON_DATA)[idx-1] = jsonData01; //위그리드에 데이터 SET
		$gridId.data(GRID_JSON_DATA)[idx] = jsonData02; //아래그리드에 데이터 SET
		ListBind.prototype._jsonGridBind(this.tagId, $gridId.data(GRID_JSON_DATA));
		
	},
	rowDown : function(idx){
		var $gridId = $("#"+this.tagId);	
		
		if(idx == $gridId.data(GRID_JSON_DATA).length-1){
			alert("그리드의 최하단입니다.");
			return false;
		}	
		
		var jsonData01 = ListBind.prototype._rowData(this.tagId, idx); //아래로 이동할 ROW
		var jsonData02 = ListBind.prototype._rowData(this.tagId, idx+1); //위로로 올라갈 ROW
		
		$gridId.data(GRID_JSON_DATA)[idx+1] = jsonData01; //아래그리드에 데이터 SET
		$gridId.data(GRID_JSON_DATA)[idx] = jsonData02; //위그리드에 데이터 SET
		ListBind.prototype._jsonGridBind(this.tagId, $gridId.data(GRID_JSON_DATA));		
	},
	rowDeleteIndex : function(index){
		var arrJsonData = [], jsonList =  $("#"+this.tagId).data(GRID_JSON_DATA);
		
		for(var i = 0, jsonLen = jsonList.length; i < jsonLen; i++){
			if(index != i){
				arrJsonData.push(jsonList[i]);
			}			
		}
		
		ListBind.prototype._jsonGridBind(this.tagId, arrJsonData);
	},
	rowDelete : function(inputType, name){
		if(inputType == "radio" || inputType == "checkbox"){
			
			var arrMoveData = [], $selecter = $("#"+this.tagId);

			$selecter.find("[name='"+name+"']:"+inputType).each(function(i){
				if(!this.checked){
					arrMoveData.push($selecter.data(GRID_JSON_DATA)[i]);
				}
			});
			ListBind.prototype._jsonGridBind(this.tagId, arrMoveData);
			
		}else{
			return false;
		}

	},
	rowAdd : function(jsonData){
		var arrJson = [];
		arrJson.push(jsonData);
		ListBind.prototype._jsonGridBindAppend(this.tagId, arrJson);
	},
	rowMove : function(idx, gridObject){
		gridObject.rowAdd($("#"+this.tagId).data(GRID_JSON_DATA)[idx]);
	},
	getSum : function(column){
		var jsonData = $("#"+this.tagId).data(GRID_JSON_DATA), result = 0;
		for(var i = 0, jsonLen = jsonData.length; i < jsonLen; i++){
			result = result + jsonData[i][column];
		}
		return result;
	},
	validation : function(){
		var $gridId = $("#"+this.tagId),
			regExpNumber = /^[0-9]*$/,
			regExpEng    = /^[a-zA-Z]+$/,
			regExpTel    = /^(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]))-(\d{3,4})-(\d{4})$/,
			regExpCell   = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/,
			regExpEmail  = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/,
			regExpLang   = /^[a-zA-Z0-9]+$/,
			regExpUrl    = /^((http(s?))\:\/\/)([0-9a-zA-Z\-]+\.)+[a-zA-Z]{2,6}(\:[0-9]+)?(\/\S*)?$/,
			returnValue = true,
			regExpDate01   = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/,
			regExpDate02   = /^(19|20)\d{2}\.(0[1-9]|1[012])\.(0[1-9]|[12][0-9]|3[0-1])$/,
			regExpDate03   = /^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/;		
		
		$gridId.find("[data-required]").each(function(){
			var $formObj	= $(this),
				formValue	= $formObj.text(),				
				requirdList	= [],
				requiredOption = $formObj.data("required");
							
			requirdList = requiredOption.split(" ");
			
			$formObj.removeClass("danger");
			
			for(var i = 0, reqCount = requirdList.length; i < reqCount; i++){
				if(requirdList[i] == "requird"){
					
					if("" == formValue.trim()){
						$formObj.addClass("danger");
						returnValue = false;
						break;								
					}
					
				}else if(requirdList[i] == "number"){
					if(!regExpNumber.test(formValue) && formValue!=""){
						$formObj.addClass("danger");	
						returnValue = false;
						break;							
					}					
				}else if(requirdList[i] == "eng"){
					if(!regExpEng.test(formValue) && formValue!=""){
						$formObj.addClass("danger");	
						returnValue = false;
						break;							
					}
				}else if(requirdList[i] == "lang&number"){
					if(!regExpLang.test(formValue) && formValue!=""){
						$formObj.addClass("danger");					
						break;
					}
				}else if(requirdList[i] == "tel"){
					if(!regExpTel.test(formValue) && formValue!=""){
						$formObj.addClass("danger");
						returnValue = false;
						break;
					}
				}else if(requirdList[i] == "cellphone"){
					if(!regExpCell.test(formValue) && formValue!=""){
						$formObj.addClass("danger");
						returnValue = false;
						break;
					}
				}else if(requirdList[i] == "email"){
					if(!regExpEmail.test(formValue) && formValue!=""){
						$formObj.addClass("danger");	
						returnValue = false;
						break;
					}
				}else if(requirdList[i] == "url"){
					
					if(!regExpUrl.test(formValue) && formValue!=""){
						$formObj.addClass("danger");	
						returnValue = false;
						break;
					}
					
				}else if(requirdList[i].indexOf("minlength") > -1){						
					var optionSize = requirdList[i].split(":")[1];						
					if(formValue.length < optionSize && formValue!=""){
						$formObj.addClass("danger");	
						returnValue = false;
						break;
					}
				}else if(requirdList[i].indexOf("dateFormat") > -1){
					var dateFormat = requirdList[i].split(":")[1],
					regExpDate = regExpDate01;
				
					if(dateFormat == "yyyy-mm-dd"){
						regExpDate = regExpDate01;
					}else if(dateFormat == "yyyy.mm.dd"){
						regExpDate = regExpDate02;
					}else if(dateFormat == "yyyymmdd"){
						regExpDate = regExpDate03;
					}
					
					if(!regExpDate.test(formValue) && formValue!=""){
						$formObj.addClass("danger");	
						returnValue = false;
						break;								
					}
				}else if(requirdList[i].indexOf("min") > -1){
					var minNumber = requirdList[i].split(":")[1];
					if(parseInt(minNumber) > parseInt(formValue) && formValue!=""){
						$formObj.addClass("danger");	
						returnValue = false;
						break;							
					}
				}else if(requirdList[i].indexOf("max") > -1){
					var maxNumber = requirdList[i].split(":")[1];
					if(parseInt(maxNumber) < parseInt(formValue) && formValue!=""){
						$formObj.addClass("danger");	
						returnValue = false;
						break;								
					}						
				}
					
			}	
						
			
		});
		
		return returnValue;
		
	},
	hidden : function(columnName){
		var $gridId = $("#"+this.tagId),
			idx = $gridId.parent().find("[data-column='"+columnName+"']").index();
		
		$gridId.children().each(function(){
			$(this).children().eq(idx).hide();
		});
		$gridId.parent().find("thead").children().children().eq(idx).hide();		
	},
	show : function(columnName){
		var $gridId = $("#"+this.tagId),
			idx = $gridId.parent().find("[data-column='"+columnName+"']").index();
		
		$gridId.children().each(function(){
			$(this).children().eq(idx).show();
		});
		$gridId.parent().find("thead").children().children().eq(idx).show();		
	},
	getJsonData : function(){
		var grid_list_data = $("#"+this.tagId).data(GRID_JSON_DATA);
		
		if(grid_list_data == undefined){
			grid_list_data = [];
		}	
		
		return grid_list_data;
	},
	getJsonStringData : function(){
		var grid_list_data = $("#"+this.tagId).data(GRID_JSON_DATA);
		
		if(grid_list_data == undefined){
			grid_list_data = [];
		}		
		return JSON.stringify(grid_list_data);
	},
	getJsonDataChecked : function(chkboxName){
		var jsonData = $("#"+this.tagId).data(GRID_JSON_DATA), resultJson = [];
		$("input[name='"+chkboxName+"']").each(function(idx){
			if($(this).prop("checked")){
				resultJson.push(jsonData[idx]);
			}
		});
		return resultJson;
	},
	getJsonStringDataChecked : function(chkboxName){
		var jsonData = $("#"+this.tagId).data(GRID_JSON_DATA), resultJson = [];
		$("input[name='"+chkboxName+"']").each(function(idx){
			if($(this).prop("checked")){
				resultJson.push(jsonData[idx]);
			}
		});
		return JSON.stringify(resultJson);		
	},
	clear : function(){
		ListBind.prototype._gridEmptyDisplay(this.tagId);
	},
	jsonReaderList : function(key){
		this.option["jsonDataKey"] = key;
	},
	jsonReaderCount : function(key){
		this.option["jsonCountKey"] = key;
	}
};

/* 콤보박스 바인드 기능 NEW 버전 */
var ComboBind = function(tagId, cd_sec){
	this.tagId      = tagId; //셀렉트박스의 id 속성
	this.param = new Map(); // 컨트롤러쪽으로 보낼 파라메터
	this.url        = "/defualtCodeList.do"; //기본으로 설정된 콘트롤러 주소
	this.option = {
		inputName : '', // 셀렉트박스의 name 속성
		valueKey : 'CODE_VAL', //셀렉트 박스의 value 키값
		textKey : 'CODE_NAME', //셀렉트박스의 text 키값
		defaultValue : '선택', //셀렉트박스에 보여줄 기본 값
		defaultConfig : true, //셀렉트박스의 기본값 설정 유무
		selectValue : '' //셀렉트박스에 데이터바인딩 후 선택될 값
	};
};

ComboBind.prototype = {
		controller : function(url){
			this.url = url;
		},
		setComboName : function(inputName){
			this.option["inputName"] = inputName;
		},
		setDefualt : function(defaultConfig){;
			this.option["defaultConfig"] = defaultConfig;
		},
		setValueKey : function(valKey){;
			this.option["valueKey"] = valKey;
		},
		setTextKey : function(txtKey){
			this.option["textKey"] = txtKey;
		},
		setDefaultVal : function(defaultValue){
			this.option["defaultValue"] = defaultValue;
		},
		setParam : function(param){
			this.param = param;
		},
		selected : function(selectValue){
			this.option["selectValue"] = selectValue;
		},
		bind : function(){
			var _tagId  = this.tagId,
				_url    = this.url,
				_param  = this.param,
				_option = this.option;
			
			$.ajax({
				type: "post",
				url: _url,
				data: _param["map"],
				dataType: "json",
			    success: function (json) {
			    	var arrHtml = [];				    	
			    	//셀렉트박스의 기본값 설정
			    	if(_option["defaultConfig"]){			    		
			    		arrHtml.push("<option value=\"\">"+_option["defaultValue"]+"</option>");
			    	}
			    	//셀렉트박스 내용 설정
			    	for(var i = 0, dataLen =json.data.length ; i < dataLen; i++){
			    		arrHtml.push("<option value='"+json["data"][i][_option["valueKey"]]+"'>");
			    		arrHtml.push(json["data"][i][_option["textKey"]]);
			    		arrHtml.push("</option>");
			    	}
			    	// id or name으로 셀렉트박스 데이터 바인딩 
			    	if(_tagId != ""){
			    		$("#"+_tagId).html(arrHtml.join("")).val(_option["selectValue"]);	
			    	}
			    	if(_option["inputName"]){
			    		$("select[name='"+_option["inputName"]+"']").html(arrHtml.join("")).val(_option["selectValue"]);	
			    	}	
			    }
			});
		},
		setCodeSection : function(cd_sec){
			var codeList = jQuery.parseJSON(localStorage.COMMON_CODE),
				arrHtml = [],
				_tagId  = this.tagId,
				_option = this.option;
			
	    	//셀렉트박스의 기본값 설정
	    	if(_option["defaultConfig"]){			    		
	    		arrHtml.push("<option value=\"\">"+_option["defaultValue"]+"</option>");
	    	}
	    	
	    	//셀렉트박스 내용 설정
	    	for(var i=0, codeLen = codeList.length; i < codeLen; i++){
	    		if(codeList[i]["CD_SEC"] == cd_sec){
		    		arrHtml.push("<option value='"+codeList[i]["CD_KEY"]+"'>");
		    		arrHtml.push(codeList[i]["CD_VALUE"]);
		    		arrHtml.push("</option>");
	    		}
	    	}
	    	
	    	// id or name으로 셀렉트박스 데이터 바인딩 
	    	if(_tagId){
	    		$("#"+_tagId).html(arrHtml.join("")).val(_option["selectValue"]);	
	    	}
	    	
	    	if(_option["inputName"]){
	    		$("select[name='"+_option["inputName"]+"']").html(arrHtml.join("")).val(_option["selectValue"]);	
	    	}    	
		}
};

var Request = function()
{
	this.getParameter = function(name){
		var rtnval = "",
			nowAddress = unescape(location.href),
			parameters = (nowAddress.slice(nowAddress.indexOf("?")+1,nowAddress.length)).split("&");
 
		for(var i = 0, pramLen =  parameters.length; i < pramLen; i++){
			var varName = parameters[i].split("=")[0];
			if(varName.toUpperCase() == name.toUpperCase()){
				rtnval = parameters[i].split("=")[1];
				break;
			}
		}
        return rtnval;
    };
};


/*
 * jquery.form.js 을 사용한 비동기 파일업로드 처리 기능
 */
function sendFormAjax(formId, param, sendUrl, successFunction, failFunction){		
	var $formObj = $("#"+formId);

	$("input[param]").remove();
	for(var key in param.map){
		$formObj.append($("<input>", { param : "true", type: "hidden", name: key, value: param.map[key]}));
	}

	$formObj.ajaxForm({
		type: "post",
		url: sendUrl,
		dataType: "json",
		uploadProgress: function(event, position, total, percentComplete){
			//$("<br/><span>position : "+position+" / total : "+total+" / percentComplete : "+percentComplete+"</span>").appendTo("body");
	    },
		beforeSubmit:function() { 
			displayLoading(true);
	    },
	    error: function(a, b, c){			
	        if(typeof failFunction === 'function'){
	        	failFunction(a,b,c);
	        }
	        $("input[param]").remove();
	        displayLoading(false);
	    },
	    success: function (data) {
    		if(typeof successFunction === 'function'){
	    		successFunction(data);
	    	}		    	
    		$("input[param]").remove();
	    	displayLoading(false);
	    }
	});
}

function sendJsonAjax(sendUrl, param, successFunction){
	$.ajax({
		type: "post",
		url: sendUrl,
		data: param["map"],
		dataType: "json",
	    success: function (json) {	 
	    	
	    	if(json.errorMessage != undefined){
	    		return false;
	    	}
	    	
    		if(typeof successFunction === 'function'){
	    		successFunction(json);
	    	}
	    }
	});
}

function sendSyncAjax(sendUrl, param){
	var result = {};
	$.ajax({
		async: false,
		type: "post",
		url: sendUrl,
		data: param["map"],
		dataType: "json",
	    success: function (json) {
	    	if(json.errorMessage != undefined){
	    		return false;
	    	}else{
	    		result = json;
	    	}	    	
	    }
	});
	
	return result;
}

function getAjaxHtml(htmlUrl, tagId){
	$.ajax({
		type: "post",
		async: false,
		url: htmlUrl,
		dataType: "html",
	    success: function(html) {
			if(tagId!=null){
				$("#"+tagId).html(html);
			}else{
				$("body").append(html);
			}
	    }
	});
}

/* iframe으로 html 파일을 갖고와 화면에 레이어로 보여준다. */
function getIframeHtml(pageUrl, tagId){
	var iframeId = tagId + "_iFrame",
		$layer = $("#"+tagId),
		winWid = $(window).width(),
		winHig = $(window).height(),
		layWid = $layer.width();
	
	$layer.html("<div class=\"fr btn glyphicon glyphicon-remove\" onclick=\"$('#"+tagId+"').remove();\"></div>")
	.append("<iframe id=\""+iframeId+"\" style=\"border:none\"></iframe>");
	
	$("#"+iframeId).attr("src", pageUrl).css({
		"width" : "100%",
		"height" : "650px"
	});	
	
	$layer.css({
		"position":"absolute",
		"top" : winHig/2-320,
		"left": (winWid-layWid)/2
	}).show();	

}

function displayLoading(type){
	if(type){
		$.blockUI({ message: 'Waiting..' });
	}else{
		$.unblockUI();
	}
}

/*
 * json의 KEY값과 html 태그의 ID값이 일치하면 매핑해준다.
 */
function jsonAutoMapping(json, areaId){
	var $selecter = null;
	
	if(areaId != ""){
		$selecter = $("#"+areaId);
	}else{
		$selecter = $("body");
	}

	for(var prop in json){

		var $element = $selecter.find("[id='"+prop+"']"), _TagName = $element.prop("tagName");
		//alert(_TagName);

		if(_TagName == "INPUT"){
			var _Type = $element.attr("type");

			if(_Type == "text" || _Type == "hidden" || _Type == "password"){
				$element.val(json[prop]);
			}else if(_Type == "radio"){
				var _Name = $element.attr("name");
				$selecter.find("[name='"+_Name+"'][value='"+json[prop]+"']").prop("checked", true);
			}else if(_Type == "checkbox"){
				$selecter.find("[id='"+prop+"'][value='"+json[prop]+"']").prop("checked", true);
			}
		
		}else if(_TagName == "SELECT"){
			$element.val(json[prop]);
		}else if(_TagName == "TEXTAREA"){
			$element.val(json[prop]);
		}else{
			$element.text(json[prop]);
		}
	}	
}

/*
 * 특정 범위의 input 폼들의 초기화 처리
 */
function initForm(areaId){
	var $selecter = null;
	
	if(areaId != ""){
		$selecter = $("#"+areaId);
	}else{
		$selecter = $("body");
	}
	
	$selecter.find("input, select, textarea").each(function(){
		var $formObject = $(this), formTag = $formObject.prop("tagName");		
		
		if(formTag == "INPUT"){
			var formType = $formObject.attr("type");
			if(formType == "text" || formType == "password" || formType == "hidden" || formType == "file"){
				$formObject.val("");
			}else if(formType == "checkbox"){
				$formObject.prop("checked", false);
			}else if(formType == "radio"){
				$formObject.prop("checked", false);
			}			
		}else if(formTag == "SELECT"){
			$formObject.val("");
		}else if(formTag == "TEXTAREA"){
			$formObject.val("");
		}
	});
	
}


/*
 * 특정 범위의 input 폼들의 ID와 VALUE값으로 json값의 형태로 리턴해준다. 
 */
function setAreaParamData(param, areaId){
	var $area;
	if(areaId){
		$area = $('#'+areaId);
	}else{
		$area = $('body');
	}

	$area.find(":text,:password").each(function(){
		var obj = this;
		param.put(obj.getAttribute("id"), obj.value);
	});

	$area.find("[type='hidden']").each(function(){
		var obj = this;
		param.put(obj.getAttribute("id"), obj.value);
	});
	
	$area.find(":checkbox").each(function(){		
		var obj = this;
		if(obj.checked == true){
			param.put(obj.getAttribute("id"), obj.value);
		}
	});
	$area.find(":radio").each(function(){
		var obj = this;
		if(obj.checked == true){
			param.put(obj.getAttribute("name"), obj.value);
		}
	});
	$area.find("select").each(function(){
		var obj = this;
		param.put(obj.getAttribute("id"), obj.value);
	});
	$area.find("textarea").each(function(){
		var obj = this;
		param.put(obj.getAttribute("id"), obj.value);	// \n 특수기호 처리해야함

	});
	//alert(JSON.stringify(param));
	return param;
}

/*
 * 체크박스 전체선택
*/
function checkAll(obj, chkName){
	var checkVal = obj.checked;
	$("input[name='"+chkName+"']").prop("checked", checkVal);
}

var MSG_VAILD_MAP = new Map();
MSG_VAILD_MAP.put("requird", "{0} 필수조건 입니다.");
MSG_VAILD_MAP.put("minlength", "{0} {1}자리 이상 입력해야 합니다. ");
MSG_VAILD_MAP.put("number", "{0} 숫자만 입력가능합니다.");
MSG_VAILD_MAP.put("lang&number", "{0} 영문,숫자만 입력가능합니다.");
MSG_VAILD_MAP.put("eng", "{0} 영문만 입력가능합니다.");
MSG_VAILD_MAP.put("email", "e-mail 양식이 아닙니다.");
MSG_VAILD_MAP.put("tell", "전화번호 양식이 아닙니다.");
MSG_VAILD_MAP.put("cellphone",  "휴대전화번호 양식이 아닙니다.");
MSG_VAILD_MAP.put("equals",  "{0}, {1}의 값이 일치하지 않습니다.");
MSG_VAILD_MAP.put("dateFormat",  "{0}는 {1} 양식으로 입력해주세요.");	// to be
MSG_VAILD_MAP.put("min",  "{0} {1}이상이여야 합니다.");
MSG_VAILD_MAP.put("max",  "{0} {1}이하여야 합니다.");
MSG_VAILD_MAP.put("url", "url 양식이 아닙니다.");	

var Validation = function(formId){
	this.formId  = formId;
};

Validation.prototype = {
		_setMessage : function(message, params){			
			$.each(params, function( idx, value){
				message = message.replace("{" + idx + "}", value);
			});			
			alert(message);
		},
		check : function(){		
			var result = true,
				regExpNumber = /^[0-9]*$/,
				regExpEng    = /^[a-zA-Z]+$/,
				regExpTel    = /^(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]))-(\d{3,4})-(\d{4})$/,
				regExpCell   = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/,
				regExpEmail  = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/,
				regExpLang   = /^[a-zA-Z0-9]+$/,
				regExpUrl    = /^((http(s?))\:\/\/)([0-9a-zA-Z\-]+\.)+[a-zA-Z]{2,6}(\:[0-9]+)?(\/\S*)?$/,
				regExpDate01   = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/,
				regExpDate02   = /^(19|20)\d{2}\.(0[1-9]|1[012])\.(0[1-9]|[12][0-9]|3[0-1])$/,
				regExpDate03   = /^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/;
			
			$("#"+this.formId).find("[data-required]").each(function(){
				var $formObj	= $(this),
					formValue	= $formObj.val(),
					formType	= $formObj.attr("type"),
					formlabel	= $formObj.data("label"),								
					requirdList	= [],
					labelParams = [],
					checkCount	= 0,
					requiredOption = $formObj.data("required");
								
				requirdList = requiredOption.split(" ");
				
				for(var i = 0, reqCount = requirdList.length; i < reqCount; i++){
					if(requirdList[i] == "requird"){
						
						if(formType=="checkbox" || formType == "radio"){
							var inputName = $formObj.attr("name");
							if($("input[name='"+inputName+"']:checked").size() == 0){
								labelParams.push(formlabel);
								Validation.prototype._setMessage(MSG_VAILD_MAP.get(requirdList[i]), labelParams);
								checkCount++;
								break;										
							}
						}else{
							if("" == formValue.trim()){
								labelParams.push(formlabel);
								Validation.prototype._setMessage(MSG_VAILD_MAP.get(requirdList[i]), labelParams);
								checkCount++;
								break;								
							}
						}
						
					}else if(requirdList[i] == "number"){
						if(!regExpNumber.test(formValue) && formValue!=""){
							labelParams.push(formlabel);
							Validation.prototype._setMessage(MSG_VAILD_MAP.get(requirdList[i]), labelParams);
							checkCount++;						
							break;							
						}					
					}else if(requirdList[i] == "eng"){
						if(!regExpEng.test(formValue) && formValue!=""){
							labelParams.push(formlabel);
							Validation.prototype._setMessage(MSG_VAILD_MAP.get(requirdList[i]), labelParams);
							checkCount++;						
							break;							
						}
					}else if(requirdList[i] == "lang&number"){
						if(!regExpLang.test(formValue) && formValue!=""){
							labelParams.push(formlabel);
							Validation.prototype._setMessage(MSG_VAILD_MAP.get(requirdList[i]), labelParams);
							checkCount++;						
							break;
						}
					}else if(requirdList[i] == "tel"){
						if(!regExpTel.test(formValue) && formValue!=""){
							labelParams.push(formlabel);
							Validation.prototype._setMessage(MSG_VAILD_MAP.get(requirdList[i]), labelParams);
							checkCount++;						
							break;
						}
					}else if(requirdList[i] == "cellphone"){
						if(!regExpCell.test(formValue) && formValue!=""){
							labelParams.push(formlabel);
							Validation.prototype._setMessage(MSG_VAILD_MAP.get(requirdList[i]), labelParams);
							checkCount++;						
							break;
						}
					}else if(requirdList[i] == "email"){
						if(!regExpEmail.test(formValue) && formValue!=""){
							Validation.prototype._setMessage(MSG_VAILD_MAP.get(requirdList[i]), labelParams);
							checkCount++;						
							break;
						}
					}else if(requirdList[i] == "url"){
						
						if(!regExpUrl.test(formValue) && formValue!=""){
							Validation.prototype._setMessage(MSG_VAILD_MAP.get(requirdList[i]), labelParams);
							checkCount++;						
							break;
						}
						
					}else if(requirdList[i].indexOf("minlength") > -1){						
						var optionSize = requirdList[i].split(":")[1];						
						if(formValue.length < optionSize && formValue!=""){
							labelParams.push(formlabel);
							labelParams.push(optionSize);							
							Validation.prototype._setMessage(MSG_VAILD_MAP.get("minlength"), labelParams);
							checkCount++;						
							break;
						}
					}else if(requirdList[i].indexOf("equals") > -1){						
						var compareId = requirdList[i].split(":")[1],
							compareData = $("#"+compareId).val(),
							compareLabel = $("#"+compareId).data("label");
						if(formValue != compareData && formValue!=""){
							labelParams.push(formlabel);
							labelParams.push(compareLabel);
							
							Validation.prototype._setMessage(MSG_VAILD_MAP.get("equals"), labelParams);
							checkCount++;						
							break;							
						}
					}else if(requirdList[i].indexOf("dateFormat") > -1){
						var dateFormat = requirdList[i].split(":")[1],
							regExpDate = regExpDate01;
						
						if(dateFormat == "yyyy-mm-dd"){
							regExpDate = regExpDate01;
						}else if(dateFormat == "yyyy.mm.dd"){
							regExpDate = regExpDate02;
						}else if(dateFormat == "yyyymmdd"){
							regExpDate = regExpDate03;
						}
						
						if(!regExpDate.test(formValue) && formValue!=""){
							labelParams.push(formlabel);
							labelParams.push(dateFormat);	
							
							Validation.prototype._setMessage(MSG_VAILD_MAP.get("dateFormat"), labelParams);
							checkCount++;						
							break;								
						}
					}else if(requirdList[i].indexOf("min") > -1){
						var minNumber = requirdList[i].split(":")[1];
						if(parseInt(minNumber) > parseInt(formValue) && formValue!=""){
							labelParams.push(formlabel);
							labelParams.push(minNumber);
							Validation.prototype._setMessage(MSG_VAILD_MAP.get("min"), labelParams);
							checkCount++;						
							break;							
						}
					}else if(requirdList[i].indexOf("max") > -1){
						var maxNumber = requirdList[i].split(":")[1];
						if(parseInt(maxNumber) < parseInt(formValue) && formValue!=""){
							labelParams.push(formlabel);
							labelParams.push(maxNumber);
							Validation.prototype._setMessage(MSG_VAILD_MAP.get("max"), labelParams);
							checkCount++;						
							break;								
						}						
					}
						
				}
				
				if(checkCount>0){					
					$formObj.focus();
					result = false;
					return false;
				}
			});
			
			return result;
		}
};

/*
 * 화면캡쳐 기능
 */
function capture(){
	displayLoading(true);
    html2canvas(document.body, {       
        onrendered: function(canvas) {
        	 var param = new Map();        	
        	 param.put("imgSrc", canvas.toDataURL("image/png"));
        	 sendJsonAjax("/imageCreate.ajax", param, captureLayer);
        }
    });		 
}

function captureLayer(json){
	displayLoading(false);
	$("body").append("<div id='divCapture' class='layer' style='width:600px;'></div>");
	getIframeHtml("/help/CAPTURE.do#"+json.data, "divCapture");
}

/*
 *  도움말 기능
 */
function openSupport(){
	window.open("/help/SUPPORT.do#"+document.location.pathname, "support", "width=500, height=600");	
}

/*
 * 에디터 기능(네이버 스마트에디터) 
*/
var Editor = function(option){
	this.editorId = option.id; //에디터 ID
	this.oEditors = [];
	this.bUseToolbar = option.toolbar; //툴바사용유무
	this.bUseModeChanger = option.mode; //HTML TEXT 모드 사용유무
	this.bUseVerticalResizer = option.vertical; //입력창 크기 조절 유무
	
	
	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: this.oEditors,
		elPlaceHolder: this.editorId,
		sSkinURI: "/editor/SmartEditor2Skin.do",	
		htParams : {
			bUseToolbar : this.bUseToolbar,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : this.bUseVerticalResizer,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : this.bUseModeChanger,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});	
};

Editor.prototype = {
	initEditor : function(){
		
	},
	pasteHtml : function(sHTML){		
		this.oEditors.getById[this.editorId].exec("PASTE_HTML", [sHTML]);
	},
	showHtml : function(){
		return this.oEditors.getById[this.editorId].getIR();
	},
	setFont : function(sDefaultFont, nFontSize){
		this.oEditors.getById[this.editorId].setDefaultFont(sDefaultFont, nFontSize);
	},
	getContents : function(){
		this.oEditors.getById[this.editorId].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		return document.getElementById(this.editorId).value;
	},
	clear : function(){
		return this.oEditors.getById[this.editorId].setIR("");
	}
};

/*
 * PDF 뷰어기능 (PDF.js) 
*/
var PdfView = function(id){
	this.pdfId = id; //선언한 PDF뷰어 div의 ID값
	this.height = $(window).height() - 150;
	
	var viewHtml = "<iframe id='"+IFRM_PDFVIWER_ID+"' src='/pdf/pdfViewer.do' width='100%' height='"+this.height+"'></iframe>";
	$("#"+this.pdfId).html(viewHtml);
	
	$(window).resize(function(){
		var winHeight = $(window).height() - 150;
		$("#"+IFRM_PDFVIWER_ID).height(winHeight);
	});
};

PdfView.prototype = {
	getPdf : function(fileUrl){
		var frm = document.getElementById(IFRM_PDFVIWER_ID),
			fDoc = frm.contentWindow || frm.contentDocument;		
		fDoc.PDFViewerApplication.open(fileUrl);		
	},
	getMakePdf : function(reportUrl, jsonData){
		displayLoading(true);
		$.ajax({
			type: "post",
			async: false,
			url: reportUrl,
			dataType: "html",
		    success: function(html) { 	
		    	var col_left = COL_LEFT_TAG, col_right = COL_RIGHT_TAG;		    	
		    	
				for (var prop in jsonData["map"]) {
					
					//데이터가 array 형태일 때 LIST 형태로 가공처리
					var arrRow = [];
					if($.isArray(jsonData["map"][prop])){
						var startTag = col_left + prop+ "_START"+ col_right,
							endTag = col_left + prop+ "_END"+ col_right,
							startIdx = html.indexOf(startTag) + startTag.length,
							endIdx = html.indexOf(endTag),
							rowTag = html.substring(startIdx, endIdx);
						for(var i=0, jsonLen = jsonData["map"][prop].length; i < jsonLen; i++){
							var rowData = jsonData["map"][prop][i], tmp = rowTag;
							for(var Column in rowData){								
								tmp = tmp.split(col_left + Column.toUpperCase() + col_right).join(rowData[Column]);																
							}
							arrRow.push(tmp);
						}
						var replaceTag = html.substring(html.indexOf(startTag), html.indexOf(endTag) + endTag.length);
						html = html.replace(replaceTag, arrRow.join(""));
					}else{
						html = html.split(COL_LEFT_TAG + prop.toUpperCase() + COL_RIGHT_TAG).join(jsonData["map"][prop]);
					}					 
				}			    			    	
				
				/*
				var startIdx = html.indexOf(col_left);
				var endIdx = html.indexOf(col_right) + 1;
				if(startIdx > -1){
					
					while(startIdx != -1){
						var replaceTxt = html.substring(startIdx, endIdx);
						html = html.replace(replaceTxt,"");
						
						startIdx = html.indexOf(col_left);				
					}
				}
				*/
				PdfView.prototype.getHtmlPdf(html);
		    }
		});		
	},
	getHtmlPdf : function(strHtml){
		var param = {};
		param["reportHtmlData"] = strHtml;
		$.ajax({
			type: "post",
			url: "/common/pdfView.ajax",
			data: param,
			dataType: "json",
		    success: function(json) {
		    	displayLoading(false);
		    	PdfView.prototype.getPdf(json.data);
		    },
		    error: function(a, b, c){
		    	displayLoading(false);
		    }
		});		
	}
	
};

/*
 * 쿠키 생성 처리 
*/
function setCookie(cName, cValue, cDay){
	var expire = new Date();
	expire.setDate(expire.getDate() + cDay);
	var cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
	if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
	document.cookie = cookies;
}

/*
 * 쿠키 정보 가져오기 
*/
function getCookie(cName) {
	cName = cName + '=';
	var cookieData = document.cookie,
		start = cookieData.indexOf(cName),
		cValue = '';
	if(start != -1){
	    start += cName.length;
	    var end = cookieData.indexOf(';', start);
	    if(end == -1)end = cookieData.length;
	    cValue = cookieData.substring(start, end);
	}
	return unescape(cValue);
}

/*
 * 파이 챠트용 데이터 변환
 */
function chartDataPie(json){
	var result = [[]];
	
	for ( var i = 0, jsonLen = json.length; i < jsonLen; i++) {
		var data = [];
		for (var prop in json[i]) {
			data.push(json[i][prop]);
		}
		result[0].push(data);
	}	
	
	return result;
}

/*
 * 파이 챠트용 데이터 변환
 */
function chartDataConvert(json){	
	var result = [];
	
	for ( var i = 0 , jsonLen = json.length; i < jsonLen; i++) {
		var data = [];
		for (var prop in json[i]) {
			data.push(json[i][prop]);
		}
		result.push(data);
	}	
	
	return result;	
}

/*
 * 공통코드 값 가져오기
 */
function getCodeValue(cd_sec, cd_key){
	var codeList = jQuery.parseJSON(localStorage.COMMON_CODE);

	for(var i=0, codeLen = codeList.length; i < codeLen; i++){
		if(codeList[i]["CD_SEC"] == cd_sec && 
		   codeList[i]["CD_KEY"] == cd_key){
			return codeList[i]["CD_VALUE"];
		}
	}	
}

/*
 * 날짜 기간 설정(from to)
 */
function setDateBetween(startDay, endDay, term, format){
	var date = new Date(),
		eYear = date.getFullYear(),
		eMonth = date.getMonth() + 1,
		eDay = date.getDate();
	
	date.setDate(date.getDate() - term);
	var sYear = date.getFullYear(),
		sMonth = date.getMonth() + 1,
		sDay = date.getDate();

	if(eMonth.toString().length < 2){ eMonth = '0' + eMonth; }
	if(eDay.toString().length < 2){ eDay = '0' + eDay; }
	
	if(sMonth.toString().length < 2){ sMonth = '0' + sMonth; }
	if(sDay.toString().length < 2){ sDay = '0' + sDay; }	
	
	if(format == undefined){ format = "-"; }
	
	$("#"+startDay).val([sYear, sMonth, sDay].join(format));
	$("#"+endDay).val([eYear, eMonth, eDay].join(format));
}
