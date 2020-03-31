 
	
<%
	strSql = "EXEC P_MONICOMBO @step='"+request.Form("step")+"' , @fullstr  ='"+request.Form("fullstr")+"' "
	col_Array = Array("CODE","CODE_NM")
%>
<!--#include virtual="/com/utils/sqlCon.asp"-->
