1<!--#include virtual="/com/utils/layout.asp"-->

<script>
	$(function(){

		//Code Set
		setComboBoxList('A','MDL_CD',{step:'mo' , fullstr:''})

		//Code change
		$("#MDL_CD").change(function(){
			
			//Code value init
			$("#WC_CD option").remove();
			$("#WC_CD").append("<option value=''>-전체-</option>");
			$("#RPT_CD option").remove();
			$("#RPT_CD").append("<option value=''>-전체-</option>");
			
			//Code Set
			fullstr = $("#MDL_CD").val();
			setComboBoxList('A','WB_CD',{step:'wb' , fullstr:fullstr});
			
		});
		$("#WB_CD").change(function(){
			$("#RPT_CD option").remove();
			$("#RPT_CD").append("<option value=''>-전체-</option>");
			

			fullstr = $("#MDL_CD").val()+','+$("#WB_CD").val()
			setComboBoxList('A','WC_CD',{step:'wc' , fullstr:fullstr});
			
		});
		$("#WC_CD").change(function(){
			fullstr = $("#MDL_CD").val()+','+$("#WB_CD").val()+','+$("#WC_CD").val();
			setComboBoxList('A','RPT_CD',{step:'rp' , fullstr:fullstr});
		});




		//calendar Set
		gfnInitDatePickerTwo();
		
		//Chart Init Set
		initChart(chart1);

		//List Init 
		getGrid();

		//Time Set
		getTime();

	});
	function enterkey() {
        if (window.event.keyCode == 13) {
			fnSearch();
        };
	};
	//Search Data
	function fnSearch(){

		var frm = document.searchForm;
		if (!gfnValidate(frm)){
			return;
		};
		console.log( frm.MAXVAL.value ) 
		console.log( frm.MINVAL.value ) 
		if( parseInt(frm.MAXVAL.value) < parseInt(frm.MINVAL.value) ){
			alert("상한치보다 하한치가 작습니다.");
			return false;
		};
		
		
		getGrid();
		chart1();
		getTime();
	};
	//Time Set
	function getTime(){
		curDate = new Date();
		curTime = "조회 시간 : " + curDate.getFullYear()+"년"+(curDate.getMonth()+1)+"월"+curDate.getDate()+"일"+curDate.getHours()+":"+ curDate.getMinutes()+":"+curDate.getSeconds();
		$(".curTime").html(curTime);
	};
	//Chart
	function chart1(){
		var url = "/sql/p_spcMn_chart1.asp";
		var frm = document.searchForm;
		var params = {
			MDL_CD: gfnCheckNull(frm.MDL_CD.value),
			WB_CD:gfnCheckNull(frm.WB_CD.value),
			WC_CD:gfnCheckNull(frm.WC_CD.value),
			RPT_CD:gfnCheckNull(frm.RPT_CD.value),
			STARTDAY:gfnCheckNull(frm.STARTDAY.value).replaceAll("-",''),
			ENDDAY:gfnCheckNull(frm.ENDDAY.value).replaceAll("-",''),
			CEL_NM:gfnCheckNull(frm.CEL_NM.value)
		};

		var sucessFunc = function(data) {
			$("#chart1").empty();

			if(data.length == 0 ) return false;

			var chartType = "LineChart";

			var datas = [ ['치수명', '치수값', '상한치' , '하한치'], ];
			
			maxval =  gfnCheckNull($("#MAXVAL").val() , '0') ;
			minval =  gfnCheckNull($("#MINVAL").val() , '0') ;
			
			for (var i = 0; i < data.length; i++) {
				datas.push( [ data[i].CEL_NM , parseInt(data[i].CEL_VAL) , parseInt(maxval) , parseInt(minval)] );
			};
			
			var options = {
				title: '치수명',
				curveType: 'function',
				legend: { position: 'bottom' },
				width : $("#gridTable").width(),
				height : $("#gridTable").height(),
				series: {
					// Adds titles to each axis.
					0: {color:'#000000'},
					1: {color:'#0000FF'},
					2: {color:'#FF0000'}
				}
			};
			setArrayChart(chartType , datas , options , "chart1" );
		};
		ajaxCall(url, params, sucessFunc);

     }
	//Search Data
	function getGrid(){
		var url = "/sql/p_spcMn.asp";
		
		var frm = document.searchForm;
		var params = {
			MDL_CD: gfnCheckNull(frm.MDL_CD.value),
			WB_CD:gfnCheckNull(frm.WB_CD.value),
			WC_CD:gfnCheckNull(frm.WC_CD.value),
			RPT_CD:gfnCheckNull(frm.RPT_CD.value),
			STARTDAY:gfnCheckNull(frm.STARTDAY.value).replaceAll("-",''),
			ENDDAY:gfnCheckNull(frm.ENDDAY.value).replaceAll("-",''),
			CEL_NM:gfnCheckNull(frm.CEL_NM.value)
		};
		
		var sucessFunc = function(data) {
			$("#listBody").empty();

			if(data.length == 0) return false;
			
			for (var i = 0; i <data.length; i++) {

				str ="<tr>"
				str+='<td colspan="2">'+data[i].RPT_YMD+'</td>';
				str+='<td colspan="2">'+data[i].CEL_NM+'</td>';
				str+='<td colspan="2">'+data[i].CEL_VAL+'</td>';
				str+='</tr>';

				$("#listBody").append( $(str).fadeIn(2000) );
			};
		};
		ajaxCall(url, params, sucessFunc);
	};
	
	
</script>


<body id="body">
	<div id="container" class="tc">
		<div id="header">
			<div class="tl sub_title"></div>
			<div class="title">SPC 관리</div>
			<div class="tr sub_title curTime"></div>
		</div>
		<div id="content">
			<div class="content_body">
				<div id="gridTable" class="item W45p H95p overAuto">
					<form id="searchForm" name="searchForm" method="POST">
						<table class="table01 W100p H100p table-striped" >
							<colgroup>
								<col style="width:16%">
								<col style="width:16%">
								<col style="width:16%">
								<col style="width:16%">
								<col style="width:16%">
								<col/>
							</colgroup>
							<thead>
								<tr>
									<th>모델</th>
									<td><select id="MDL_CD" name="MDL_CD" class="" title="모델"></select></td>
									<th>공정</th>
									<td><select id="WB_CD" name="WB_CD" class="" title="공정"><option value=''>-전체-</option></select></td>
									<th>작업장</th>
									<td><select id="WC_CD" name="WC_CD" class="" title="작업장"><option value=''>-전체-</option></select></td>
								</tr>
								<tr>
									<th>리포트</th>
									<td><select id="RPT_CD" name="RPT_CD" class="" title="리포트"><option value=''>-전체-</option></select></td>
									<th>날짜</th>
									<td colspan="3" >
										<input type="text" name="STARTDAY" id="startDay" readonly="readonly"  title="시작일" class="W40p" /> ~
										<input type="text" name="ENDDAY" id="endDay" readonly="readonly" title="종료일" class="W40p" />
									</td>
								</tr>
								<tr>
									<th>치수명</th>
									<td><input type="text" name="CEL_NM" class=""  maxlength="30" title="치수명" onkeyup="enterkey();return false;"/></td>
									<th>상한치</th>
									<td><input type="text" name="MAXVAL" id="MAXVAL" class="intCheck checkNull"  maxlength="30" title="상한치" onkeyup="enterkey();return false;" /></td>
									<th>하한치</th>
									<td><input type="text" name="MINVAL" id="MINVAL" class="intCheck checkNull" maxlength="30" title="하한치" onkeyup="enterkey();return false;"/></td>
								</tr>
								<tr>
									<td colspan="6">
										
										<a href="" class="btn_1 W80p" onclick="fnSearch();return false;">조회</a>
									</td>
								</tr>
								<tr><td colspan="6"></td></tr>
								<tr>
									<th class="fixHeader" colspan="2">날짜</th>
									<th class="fixHeader" colspan="2">치수명</th>
									<th class="fixHeader" colspan="2">치수값</th>
								</tr>

							</thead>
							<tbody id="listBody" class="fsh2 FW700 ">

							</tbody>
						</table>
					</form>
				</div>
				
				<div id="chart1" class="item W50p H95p"></div>

			</div>
		</div>
	</div>

</body>


