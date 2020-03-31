
<%
	

	Set dbCon = Server.CreateObject("ADODB.Connection") 
	strConnect="Provider=SQLOLEDB;User ID=XXXX;Password=@XXXX;Initial Catalog=hiairmes;Data Source=XX.XXXXX.XX.XX"
	dbCon.Open strConnect
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.CursorType = 3
	rs.CursorLocation = 3
	rs.LockType = 3
	Set rs.ActiveConnection = dbcon
	rs.Open strSql
	
	totCnt = rs.RecordCount
	col_Index = UBound(col_Array)
	%>{"result":[<%
	i=1
	while not(rs.EOF)
		%>{<%
			For z = 0 To UBound(col_Array)
				
				Str= rs(col_Array(z))
				rStr = ""
				
				if (isNull(Str) or len(trim(Str))=0 ) then
					rStr = Str	
				else
					rStr = replace( Cstr(Str) , "," , "H^i^tec1^" )					
					rStr = replace( rStr , 		"'" , "H^i^tec2^" )					
					rStr = replace( rStr ,	   """" , "H^i^tec3^" )					
					rStr = replace( rStr , 		"]" , "H^i^tec4^" )
					rStr = replace( rStr , 		"[" , "H^i^tec5^" )
					rStr = replace( rStr , 		":" , "H^i^tec6^" )
					rStr = replace( rStr , 		"{" , "H^i^tec7^" )
					rStr = replace( rStr , 		"}" , "H^i^tec8^" )
					
				end if
				
						
				%>"<% response.write col_Array(z)%>":"<%=rStr%>"<%
				if z <> col_Index then
					%>,<%
				END IF
			Next
		%>}<%
		if i <> totCnt then 
			%>,<%
			i=i+1
		End If
		rs.MoveNext
	wend
	dbCon.close
	%>]}<%
%>
