	
<%
	strSql = "EXEC P_MANUSTOCK @startrow="+request.Form("startRow")+", @endrow="+request.Form("endRow")+"  "
	col_Array = Array("RSN","LWR_CD_NM","PART_NO","PART_NM","UNIT","QTY")
%>
<!--#include virtual="/com/utils/sqlCon.asp"-->
