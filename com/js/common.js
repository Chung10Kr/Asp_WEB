/*************************Combo Box Start*************************/
String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}
/*
Json 형식 만들때
, ' " [ ] { } : 치환 복구
*/
function setData(data){
	result = data.replaceAll('H^i^tec1^',',')
			.replaceAll('H^i^tec2^',"'")
			.replaceAll('H^i^tec3^','"')
			.replaceAll('H^i^tec4^','[')
			.replaceAll('H^i^tec5^',']')
			.replaceAll('H^i^tec6^',':')
			.replaceAll('H^i^tec7^','{')
			.replaceAll('H^i^tec8^','}')

	return result;
}
/*, ' " [ ] { } : 치환 복구*/
function parseChar(temp_result){
	
	var newResult = [];
	for( var i=0 ; i < temp_result.length ; i++){
		temp_ = temp_result[Object.keys(temp_result)[i]]
		newObj = new Object();
		for( var z=0; z< Object.keys(temp_).length ; z++){
			newObj[Object.keys(temp_)[z]] = setData(temp_[Object.keys(temp_)[z]])	
		};
		newResult.push(newObj);
	};
	return newResult;
}

/*
Ajax
*/
function ajaxCall(url,params,sucessFun,errorFun, async){
  if(async == undefined) async = true;
  $.ajax({
	  	cache : false,
        type: "POST",
        url: url,
        data: params,
        async: async,
        dataType: 'json',
        contentType: "application/x-www-form-urlencoded; charset=UTF-8", // AJAX contentType
        success: function(data){
			
			var result;
			
        	try{
        		result = JSON.parse(data);
        	}catch(e){
        		result = data;
			}
			
			if(typeof(sucessFun) == 'function') sucessFun(parseChar(result.result));
        }, 
        error : function(xhr, status, error){
			alert("시스템 오류가 발생하였습니다."+error);
			
            if(typeof(errorFun) == 'function') errorFun();
            return;
        },
        
    });
};
/*************************Ajax Call End*************************/

/*************************Chart Start*************************/
/*
차트 초기 설정
*/
function initChart(){
	google.charts.load('current', {'packages':['corechart']});
	google.charts.load('current', {'packages':['bar']});
	
	
    for (let i = 0; i < arguments.length; i++) {
        google.charts.setOnLoadCallback( arguments[i] );
    }
	
	//가변인자 함수
	
};


/*
p_chartType : 차트 종류 (AreaChart,BarChart,ComboChart,PieChart,LineChart)
P_datas ,   : 차트 데이터
p_options , : 차트 옵션
p_chartArea : 차트 DIV Id
*/
function setArrayChart(p_chartType , P_datas , p_options , p_chartArea ){
	
	var data = google.visualization.arrayToDataTable(P_datas);
	
	var options = p_options;
	
	var chart ;
	if( p_chartType == 'AreaChart'){
		chart = new google.visualization.AreaChart(document.getElementById(p_chartArea));
	}else if( p_chartType == 'BarChart'){
		chart = new google.charts.Bar(document.getElementById(p_chartArea));
	}else if( p_chartType =='ComboChart'){
		chart = new google.visualization.ComboChart(document.getElementById(p_chartArea));
	}else if( p_chartType =='PieChart'){
		chart = new google.visualization.PieChart(document.getElementById(p_chartArea));
	}else if( p_chartType =='LineChart'){
		chart = new google.visualization.LineChart(document.getElementById(p_chartArea));
	}
	chart.draw(data, options);
};
/*
p_chartType : 차트 종류 (InterChart)
P_datas ,   : 차트 데이터
p_options , : 차트 옵션
p_chartArea : 차트 DIV Id
*/
function setDataChart(p_chartType , P_datas , p_options , p_chartArea ){
	
		var data = new google.visualization.DataTable();
        data.addColumn('number', 'x');
        data.addColumn('number', 'values');
        data.addColumn({id:'i0', type:'number', role:'interval'});
        data.addColumn({id:'i1', type:'number', role:'interval'});
		data.addRows(P_datas);

		var chart;
		if( p_chartType = 'InterChart'){
			chart = new google.visualization.LineChart(document.getElementById(p_chartArea));
		}
        chart.draw(data, p_options);
};
/*************************Chart End*************************/

/*************************Calendar Start*************************/
/**
 * 함수 설명 : 기간 날짜 설정 간단하게 세팅하는 함수 input id는 고정으로 사용 startDay,endDay 
 * @param obj  :  해당 객체
 * @param dateformat  :  날짜형식
 */
function gfnInitDatePickerTwo(){
	gfnSetDatePickerTwo($("#startDay"));
	gfnSetDatePickerTwo($("#endDay"));
}
/**
 * 함수 설명 : 달력(DatePicker)적용 - 시작날짜와 종료날짜 같이 사용할 경우 이함수사용
 * @param obj  :  해당 객체
 * @param dateformat  :  날짜형식
 */
function gfnSetDatePickerTwo(obj, dateformat) {
	
	if(dateformat == "" || dateformat == undefined){
		dateformat = 'yy-mm-dd';
	};
    $( obj ).datepicker({
    	closeText: '닫기',
    	prevText: '이전달',
    	nextText: '다음달',
    	currentText: '오늘',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월' ],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: dateformat,   // 날짜형식 = 20130329
		autoSize: false,    // 자동리사이즈 (false 이면 상위 정의에 따름)
		changeMonth: true,   // 월변경 가능
		changeYear: true,   // 연변경 가능
		showMonthAterYear: true,  // 년 위에 월 표시
		showOn: 'both',    // 엘리먼트와 이미지 동시사용 (both, button)
		buttonImageOnly: true,   // 이미지 표시
		buttonText: '달력',   // 버튼 텍스트 표시
		buttonImage: '/com/img/calendar.png',  // 이미지 주소
		showMonthAfterYear: true,
		showButtonPanel: true,
		onSelect: function(){ //날짜 선택시 호출되는 함수
		  $(this).removeClass("errInpt");
		  if(typeof(gfnSelectDPEvent) == 'function') gfnSelectDPEvent(this);
        },
        minDate : (typeof(gfnSetDPMinDate) == 'function')?gfnSetDPMinDate($( obj )):'',
        maxDate : (typeof(gfnSetDPMaxDate) == 'function')?gfnSetDPMaxDate($( obj )):''
        
		//yearRange: 'c-99:c+99',  // 1990~2020년 까지
		//maxDate: '+6Y',    // 오늘 부터 6년 후까지만.  +0d 오늘 이전 날짜만 선택
		//minDate: '-30d'
	});
}

//달력 선택시 min,max 값 재설정
function gfnSelectDPEvent(obj) {
	var id = $(obj).attr("id");
	if (id == "startDay") {
		$('#endDay').datepicker("option", "minDate", $("#startDay").val());
	} else if (id == "endDay") {
		$('#startDay').datepicker("option", "maxDate", $("#endDay").val());
	}
}
//시작날짜의 min날짜 설정
function gfnSetDPMinDate(obj) {
	var retVal = "";
	var id = $(obj).attr("id");
	if (id == "endDay") {
		retVal = $("#startDay").val();
	}
	return retVal;
}
//시작날짜의 max날짜 설정
function gfnSetDPMaxDate(obj) {
	var retVal = "";
	var id = $(obj).attr("id");
	if (id == "startDay") {
		retVal = $("#endDay").val();
	}
	return retVal;
}

/*************************Calendar End*************************/



/*************************Calendar End*************************/
/**
 * 함수 설명 : 코드성 콤보박스 생성
 * @param type  :  S:선택, A:전체,null:없음, 그외에는 표시값을 표시
 * @param id  :  id
 * @param params  :  파라미터
 * @param async  :  동기/비동기 여부
 * @param selVal  :  초기값 세팅 -  필요할 경우 사용
 */
function setComboBoxList(type, id, params, async, selVal) {
	var obj  = $("#"+id);
	obj.html("");
	  var url = "/sql/p_moniCombo.asp";
	  var params = params;
	  var sucessFunc = function(list) {
		  
	    if(type == "S"){
	    	AddOptionSelectBox(obj, '', false, '-선택-');	
	    }else if(type == "A"){
	    	AddOptionSelectBox(obj, '', false, '-전체-');
	    }else if(type != "" && type != undefined && type != null ){
	    	AddOptionSelectBox(obj, '', false, type);
		};
		
		if(list.length ==0) return false;
		
	    for (var i = 0; i < list.length; i++) {
	      var ck = false;
	      if(list[i].CODE == selVal) ck = true;
	      var codeNm = list[i].CODE_NM; 
	      if(codeNm == undefined) codeNm = list[i].CODE;
	      AddOptionSelectBox(obj, list[i].CODE, ck, codeNm);
	    };
	  };
	  ajaxCall(url, params, sucessFunc, "", async);
}


/**
 * selectBox 생성
 * @param $element
 * @param strValue
 * @param bSelected
 * @param strText
 */
function AddOptionSelectBox($element, strValue, bSelected, strText){
  if( bSelected )
    $element.append('<option value="'+strValue+'" selected>'+strText+'</option>');
  else
    $element.append('<option value="'+strValue+'">'+strText+'</option>');
}	


/*************************Combo Box End*************************/



/*************************공통 Utile Start*************************/
/**
 * 함수 설명 : null값을 다른 문자열로 대체, 대체문자열이 없을 경우 공백으로 리턴
 * @param data :  검사 데이터값(필수)
 * @param chr  :  대체문자 
 */
function gfnCheckNull(data , chr){
    if(chr == null || chr == undefined) chr ='';
    
    if(data == null || data == undefined || data== 'null'|| data === ''){
        return chr;
    }else{
        return data;
    }   
};
/*************************공통 Utile Start*************************/