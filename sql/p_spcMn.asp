 
	
<%
	strSql = "EXEC P_SPCMN @MDL_CD='"+request.Form("MDL_CD")+"', @WB_CD ='"+request.Form("WB_CD")+"', @WC_CD ='"+request.Form("WC_CD")+"', @RPT_CD ='"+request.Form("RPT_CD")+"', @STARTDAY ='"+request.Form("STARTDAY")+"', @ENDDAY ='"+request.Form("ENDDAY")+"', @CEL_NM ='"+request.Form("CEL_NM")+"' "
	col_Array = Array("RPT_YMD","CEL_NM","CEL_VAL")
%>
<!--#include virtual="/com/utils/sqlCon.asp"-->
