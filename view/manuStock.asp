<!--#include virtual="/com/utils/layout.asp"-->




<script>
	var PAGE = 1;
	$(function(){
		
		//List 초기 실행
		getGrid();
		//시간 설정
		getTime();
		
			
		//10초 마다 실행
		setInterval(function(){ getData();},10000);
			
	});
	//데이터 조회
	function getData(){
		
		getGrid();
		getTime();
	};
	//시간 설정
	function getTime(){
		curDate = new Date();
		curTime = curDate.getFullYear()+"년"+(curDate.getMonth()+1)+"월"+curDate.getDate()+"일"+curDate.getHours()+":"+ curDate.getMinutes()+":"+curDate.getSeconds();
		$(".curTime").html(curTime);
	};
	
	function getGrid(){
		var pageSize = 10;
		var startRow = PAGE * pageSize - pageSize +1;
		var endRow= startRow + pageSize - 1;
		
		var url = "/sql/p_manuStock.asp";
		
		var params = {
			startRow : startRow,
			endRow : endRow
		};

		var sucessFunc = function(data) {
			
			if(data.length != 0){
				$("#listBody").empty();
				
				for (var i = 0; i < data.length; i++) {
					str="<tr>";
						
					str+='<td>'+data[i].LWR_CD_NM+'</td>';
					str+='<td>'+data[i].PART_NO+'</td>';
					str+='<td>'+data[i].PART_NM+'</td>';
					str+='<td>'+data[i].UNIT+'</td>';
					str+='<td>'+data[i].QTY+'</td>';
					str+='</tr>';
					$("#listBody").append( $(str).fadeIn(2000) );
				};
				if(data.length != pageSize){
					PAGE=1;
				}else{
					PAGE++;
				};	
			}else{
				PAGE=1;
			}
			
		
		};
		ajaxCall(url, params, sucessFunc);
	};
</script>


<body id="body">
	<div id="container" class="tc">
		<div id="header">
			<div class="tl sub_title"></div>
			<div class="title">생산재고현황</div>
			<div class="tr sub_title curTime"></div>
		</div>
		<div id="content">
			<div class="content_body">
				<div id="gridTable" class="item W95p H95p ">
					<table class="table01 W100p H100p table-striped" >
						<colgroup>
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col/>
						</colgroup>
						<thead>
							<tr>
								<th>자재구분</th>
								<th>품번</th>
								<th>품명</th>
								<th>단위</th>
								<th>재고수량</th>
							</tr>
						</thead>
						<tbody id="listBody" class="fsh2 FW900">
							
						</tbody>
					</table>
					
				</div>
			</div>
		</div>
	</div>
	
</body>


