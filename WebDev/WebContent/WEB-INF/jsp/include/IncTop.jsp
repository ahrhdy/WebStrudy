<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
var commonMenuList = new ListBind("ul_menu_list", false);
$(document).ready(function() {
	initUserMenuList();
	var url = location.pathname;
	$("#divMenu").find("a").each(function(){
		if(url == $(this).attr("href")){
			$(this).parent().addClass("active");
			return false;
		}
	});
	
});

/**
 * 사용자별 메뉴 조회 
 */
function initUserMenuList(){
	if(!localStorage.USER_MENU){
		var param = new Map();	
		sendJsonAjax("/common/aut/list/selUserAutList.ajax", param, initUserMenuListCallBack);
	}else{
		commonMenuList.bindGrid(jQuery.parseJSON(localStorage.USER_MENU));
	}
}

/**
 * 사용자메뉴 localStorage 저장
 */
function initUserMenuListCallBack(json){
	localStorage.setItem("USER_MENU", JSON.stringify(json.data));
	commonMenuList.bindGrid(json.data);
}
</script>
	
<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/office/MAIN.do">WebDev</a>
    </div>
    <!-- Top Menu Items -->
    <ul class="nav navbar-right top-nav">    
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-th-list"></i> <b class="caret"></b></a>
            <ul class="dropdown-menu alert-dropdown">                
                <li><a href="/sample/AJAX_SYNC.do"><i class="fa fa-fw fa-file"></i> AJAX - 동기</a></li>
                <li><a href="/sample/AJAX_ASYNC.do"><i class="fa fa-fw fa-file"></i> AJAX - 비동기</a></li>
                <li><a href="/sample/GRID_LIST.do"><i class="fa fa-fw fa-file"></i> GRID 조회</a></li>
                <li><a href="/sample/GRID_SCRLK.do"><i class="fa fa-fw fa-file"></i> GRID 틀고정</a></li>
                <li><a href="/sample/GRID_SORT.do"><i class="fa fa-fw fa-file"></i> GRID 정렬</a></li>
                <li><a href="/sample/GRID_PAGING.do"><i class="fa fa-fw fa-file"></i> GRID 페이징</a></li>						
                <li><a href="/sample/GRID_RANK.do"><i class="fa fa-fw fa-file"></i> GRID 순서 변경</a></li>
                <li><a href="/sample/GRID_MOVE.do"><i class="fa fa-fw fa-file"></i> GRID ROW 이동</a></li>
                <li><a href="/sample/GRID_ADD.do"><i class="fa fa-fw fa-file"></i> GRID ROW 추가</a></li>
                <li><a href="/sample/GRID_EDIT.do"><i class="fa fa-fw fa-file"></i> GRID EDIT</a></li>
                <li><a href="/sample/GRID_LAYER.do"><i class="fa fa-fw fa-file"></i> GRID 레이어</a></li>
                <li><a href="/sample/GRID_ROW.do"><i class="fa fa-fw fa-file"></i> GRID ROW 정보</a></li>
                <li><a href="/sample/GRID_CALLBACK.do"><i class="fa fa-fw fa-file"></i> GRID 후 처리</a></li>						
                <li><a href="/sample/EXCEL_READING.do"><i class="fa fa-fw fa-file"></i> EXCEL 읽기</a></li>
                <li><a href="/sample/VALIED.do"><i class="fa fa-fw fa-file"></i> 유효성 검사</a></li>
                <li><a href="/sample/SELECTBOX.do"><i class="fa fa-fw fa-file"></i> SELECTBOX 설정</a></li>
                <li><a href="/sample/EDITOR.do"><i class="fa fa-fw fa-file"></i> Editor 기능</a></li>
                <li><a href="/sample/PDF_VIEW.do"><i class="fa fa-fw fa-file"></i> PDF 뷰어</a></li>
                <li><a href="/sample/IMG_PREVIEW.do"><i class="fa fa-fw fa-file"></i> 이미지 미리보기</a></li>
                <li><a href="/sample/DATE.do"><i class="fa fa-fw fa-file"></i> 날짜 선택</a></li>
                <li><a href="/sample/MAP_DAUM.do"><i class="fa fa-fw fa-file"></i> 다음지도</a></li>
            </ul>
        </li>  
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-envelope"></i> <b class="caret"></b></a>
            <ul class="dropdown-menu message-dropdown">
                <li class="message-preview">
                    <a href="#">
                        <div class="media">
                            <span class="pull-left">
                                <img class="media-object" src="http://placehold.it/50x50" alt="">
                            </span>
                            <div class="media-body">
                                <h5 class="media-heading"><strong>John Smith</strong>
                                </h5>
                                <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                <p>Lorem ipsum dolor sit amet, consectetur...</p>
                            </div>
                        </div>
                    </a>
                </li>
                <li class="message-preview">
                    <a href="#">
                        <div class="media">
                            <span class="pull-left">
                                <img class="media-object" src="http://placehold.it/50x50" alt="">
                            </span>
                            <div class="media-body">
                                <h5 class="media-heading"><strong>John Smith</strong>
                                </h5>
                                <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                <p>Lorem ipsum dolor sit amet, consectetur...</p>
                            </div>
                        </div>
                    </a>
                </li>
                <li class="message-preview">
                    <a href="#">
                        <div class="media">
                            <span class="pull-left">
                                <img class="media-object" src="http://placehold.it/50x50" alt="">
                            </span>
                            <div class="media-body">
                                <h5 class="media-heading"><strong>John Smith</strong>
                                </h5>
                                <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                <p>Lorem ipsum dolor sit amet, consectetur...</p>
                            </div>
                        </div>
                    </a>
                </li>
                <li class="message-footer">
                    <a href="#">Read All New Messages</a>
                </li>
            </ul>
        </li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
            <ul class="dropdown-menu alert-dropdown">
                <li>
                    <a href="#">Alert Name <span class="label label-default">Alert Badge</span></a>
                </li>
                <li>
                    <a href="#">Alert Name <span class="label label-primary">Alert Badge</span></a>
                </li>
                <li>
                    <a href="#">Alert Name <span class="label label-success">Alert Badge</span></a>
                </li>
                <li>
                    <a href="#">Alert Name <span class="label label-info">Alert Badge</span></a>
                </li>
                <li>
                    <a href="#">Alert Name <span class="label label-warning">Alert Badge</span></a>
                </li>
                <li>
                    <a href="#">Alert Name <span class="label label-danger">Alert Badge</span></a>
                </li>
                <li class="divider"></li>
                <li>
                    <a href="#">View All</a>
                </li>
            </ul>
        </li>
        <li>
        	<a href="javascript:capture();"><i class="fa fa-camera"></i></a>
        </li>
        <li>
        	<a href="javascript:openSupport();"><i class="fa fa-question"></i></a>
        </li>              
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li>
                    <a href="#"><i class="fa fa-fw fa-user"></i> Profile</a>
                </li>
                <li>
                    <a href="#"><i class="fa fa-fw fa-envelope"></i> Inbox</a>
                </li>
                <li>
                    <a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>
                </li>
                <li class="divider"></li>
                <li>
                    <a href="/logout.do"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                </li>
            </ul>
        </li>
    </ul>
    <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
    <div id="divMenu" class="collapse navbar-collapse navbar-ex1-collapse">
        <ul id="ul_menu_list" class="nav navbar-nav side-nav">
            <li>
                <a href="{PGM_URL}"><i class="fa fa-fw fa-file"></i> {PGM_NAME}</a>
            </li>            
        </ul>
    </div>
    <!-- /.navbar-collapse -->
</nav>