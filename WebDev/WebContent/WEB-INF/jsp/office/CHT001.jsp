<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>통계차트</title>
<%@ include file="/include/IncHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="/css/jquery/jquery.jqplot.min.css">
<script type="text/javascript" src="/js/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="/js/jqplot/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript" src="/js/jqplot/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="/js/jqplot/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="/js/jqplot/jqplot.dateAxisRenderer.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	$('#chart01').jqplot([], {		
		dataRenderer: getEmpChartRendererPie,
        gridPadding: {top:0, bottom:38, left:0, right:0},
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
            trendline:{ show:false }, 
            rendererOptions: { padding: 8, showDataLabels: true }
        },
        legend:{
            show:true
        }       
    });  
    
    var line1 = getBrdChartRendererBar();
    
    $('#chart02').jqplot([line1], {    	
        title:'게시판 글작성 통계',
        seriesDefaults:{
            renderer:$.jqplot.BarRenderer,
            rendererOptions: {
                varyBarColor: true
            }
        },
        axes:{
            xaxis:{
                renderer: $.jqplot.CategoryAxisRenderer
            }
        }
    });   
    
    var line2 = getBrdChartRendererLine();
    
    $("#chart03").jqplot('chart03', [line2], {
      title:'게시글 일자별 글작성 통계',
      axes:{
          xaxis:{
              renderer:$.jqplot.DateAxisRenderer,
              tickOptions:{formatString:'%y-%m-%d'}
          }
      },
      series:[{lineWidth:4, markerOptions:{style:'square'}}]
    });    
});

function getEmpChartRendererPie(){
	var param = new Map();
	var result = sendSyncAjax("/common/cht/list/selEmpChart.ajax", param);
	return chartDataPie(result.data);
}

function getBrdChartRendererBar(){	
	var param = new Map();
	var result = sendSyncAjax("/common/cht/list/selBrdChart01.ajax", param);
	return chartDataConvert(result.data);
}

function getBrdChartRendererLine(){	
	var param = new Map();
	var result = sendSyncAjax("/common/cht/list/selBrdChart02.ajax", param);
	return chartDataConvert(result.data);
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
					<h3>통계 차트</h3>
					<div id="chart01"></div><br/>
					<div id="chart02"></div><br/><br/>
					<div id="chart03"></div>
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