<!--#include virtual="/com/utils/layout.asp"-->

<script type="text/javascript">
	$(function(){
		//함수 초기화 
		initChart(AreaChart,BarChart,BarChart2,ComboChart,PieChart,LineChart,InterChart,InterChart);
		
		
	});
	
  

function AreaChart() {
	var chartType = "AreaChart";
	var datas = [
	  ['Year', 'Max', 'Value' ,'Min' ],
	  ['2013',  1000,      800 , 600],
	  ['2014',  1170,      700 , 300],
	  ['2015',  660,       550 , 300],
	  ['2016',  1030,      540 , 200]
	];

	var options = {
	  title: 'Company Performance',
	  hAxis: {title: 'Year',  titleTextStyle: {color: '#333'}},
	  vAxis: {minValue: 0}
	  
	};

	setArrayChart(chartType , datas , options , "AreaChart" );
 }
 function BarChart() {
	var chartType = "BarChart";
	var datas = [
          ['Year', 'Sales', 'Expenses', 'Profit'],
          ['2014', 1000, 400, 200],
          ['2015', 1170, 460, 250],
          ['2016', 660, 1120, 300],
          ['2017', 1030, 540, 350]
        ];

	var options = {
	  chart: {
		title: 'Company Performance',
		subtitle: 'Sales, Expenses, and Profit: 2014-2017',
	  },
	  bars: 'horizontal'  // 세로: vertical , 가로: horizontal
	};
	setArrayChart(chartType , datas , options , "BarChart" );
        

        
 }
 function BarChart2() {
	var chartType = "BarChart";
	var datas = [
	  ['Opening Move', 'Percentage'],
	  ["King's pawn (e4)", 44],
	  ["Queen's pawn (d4)", 31],
	  ["Knight to King 3 (Nf3)", 12],
	  ["Queen's bishop pawn (c4)", 10],
	  ['Other', 3]
	];

	var options = {
	  title: 'Chess opening moves',
	  width: 300,
	  legend: { position: 'none' },
	  chart: { title: 'Chess opening moves',
			   subtitle: 'popularity by percentage' },
	  bars: 'vertical', // 세로: vertical , 가로: horizontal
	  axes: {
		x: {
		  0: { side: 'center', label: 'Percentage'} // Top x-axis.
		}
	  },
	  bar: { groupWidth: "90%" }
	};
	setArrayChart(chartType , datas , options , "BarChart2" );
};
  
function ComboChart() {
	var chartType = "ComboChart";
	
	var datas = [
	  ['Month', 'Bolivia', 'Ecuador', 'Madagascar', 'Guinea', 'Rwanda', 'Average'],
	  ['2004/05',  165,      938,         522,             998,           450,      614.6],
	  ['2005/06',  135,      1120,        599,             1268,          288,      682],
	  ['2006/07',  157,      1167,        587,             807,           397,      623],
	  ['2007/08',  139,      1110,        615,             968,           215,      609.4],
	  ['2008/09',  136,      691,         629,             1026,          366,      569.6]
	];

	var options = {
	  title : 'Monthly Coffee Production by Country',
	  vAxis: {title: 'Cups'},
	  hAxis: {title: 'Month'},
	  seriesType: 'bars',
	  series: {	3: {type: 'line'}, 5: {type: 'line'}  }        
	};

	setArrayChart(chartType , datas , options , "ComboChart" );
}
function PieChart() {
	var chartType = "PieChart";

	var datas = [
	  ['Task', 'Hours per Day'],
	  ['Work',     11],
	  ['Eat',      2],
	  ['Commute',  2],
	  ['Watch TV', 2],
	  ['Sleep',    7]
	];

	var options = {
	  title: 'My Daily Activities',
	  is3D: true,
	  
	}

	setArrayChart(chartType , datas , options , "PieChart" );
}
function LineChart() {
	var chartType = "LineChart";
	var datas = [
	  ['Year', 'Sales', 'Expenses'],
	  ['2004',  1000,      400],
	  ['2005',  1170,      460],
	  ['2006',  660,       1120],
	  ['2007',  1030,      540]
	];

	var options = {
	  title: 'Company Performance',
	  curveType: 'function',
	  legend: { position: 'bottom' },
	};
	setArrayChart(chartType , datas , options , "LineChart" );
}
function InterChart(){
		var chartType = "InterChart";
		
		var data = [
			[1, 100, 30, 190],
            [2, 120, 40, 160],
            [3, 130, 70, 170],
            [4, 90, 65, 120],
            [5, 70, 40, 100],
            [6, 30, 10, 60],
            [7, 80, 50, 110],
            [8, 100, 80, 120]
		];
		
		var options = {
			title:'Area, default',
			curveType:'function',
			series: [{'color': '#F1CA3A'}],
			intervals: { 'style':'area' },
			legend: 'none',
		};
  
		setDataChart(chartType , data , options , "InterChart" );
      }
</script>
  
<body>
	
		<div id="AreaChart" style="width: 50%; height: 250px;" class="fr"></div>
		<div id="BarChart" style="width: 50%; height: 250px;" class="fr"></div>
		<div id="BarChart2" style="width: 50%; height: 250px;" class="fr"></div>

		<div id="ComboChart" style="width: 50%; height: 250px;" class="fr"></div>
		<div id="PieChart" style="width: 50%; height: 250px;" class="fr"></div>
		<div id="LineChart" style="width: 50%; height: 250px;" class="fr"></div>
		<div id="InterChart" style="width: 50%; height: 250px;" class="fr"></div>
	
</body>
