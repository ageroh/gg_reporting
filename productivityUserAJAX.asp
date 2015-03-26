<%@Language="VBScript"%>
<%option explicit%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="el" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
	<meta http-equiv='Content-Type' content='text/html; charset=windows-1253' />
	<meta http-equiv='Content-Language' content='el' />
	<title>AJAX call</title>
</head>
<body class="inner">
<script>
$(document).ready(function() {
   
    //$("#selectUserID").val($("#selectedUserHdn").text());
		
});
</script>
<%
	Dim cnnSQL
	Dim cmdStoredProc
	Dim rsList, strConn, Userid
	
	'This code creates a connection object.
	Set cnnSQL = Server.CreateObject("ADODB.Connection")
	cnnSQL.CursorLocation = 3

	' Connection string.
	' PRODUCTION: 	strConn = "Provider=sqloledb;Data Source=10.0.64.32;Initial Catalog=GG_Reporting;User Id=ContentAbility_User_165;Password=3E6EA993-5EBA-4648-BF18-83C38D3E26DC"
	'strConn = "Provider=sqloledb;Data Source=localhost;Initial Catalog=GG_Reporting;User Id=sa;Password=pr1m$diA#"
	strConn = "Provider=sqloledb;Data Source=10.0.64.32;Initial Catalog=GG_Reporting;User Id=ContentAbility_User_165;Password=3E6EA993-5EBA-4648-BF18-83C38D3E26DC"
	
	cnnSQL.Open strConn

	'This code creates a command object.
	Set cmdStoredProc = Server.CreateObject("ADODB.Command")
	Set cmdStoredProc.ActiveConnection = cnnSQL

	Userid = "-1"
	'Retrieve Userid
	Userid =  request.querystring("Userid") 
	Session("xUserid") = Userid
	
	'Retrieve all records.
	cmdStoredProc.CommandText = "USP_Report_Productivity_Per_User"
	cmdStoredProc.CommandType = 4
	cmdStoredProc.CommandTimeout = 10000
	cmdStoredProc.Parameters.Append cmdStoredProc.CreateParameter("@User_id", 202, 1, 50, Userid) 
	
	'This code creates a recordset object.
	Set rsList = Server.CreateObject("ADODB.Recordset")
	rsList.CursorType = 3

	Set rsList.Source = cmdStoredProc.Execute
	rsList.Open
	
%>

<table id="GGresults" class="display" cellspacing="0" width="100%" > 
  <thead>
	<tr>
		<%
		for each x in rsList.Fields
				response.write("<th>" & ucase(x.name) & "</th>")
		next
		%>
	</tr>
  </thead>
   <tfoot>
	<tr>
		<%
		for each x in rsList.Fields
				response.write("<th>" & ucase(x.name) & "</th>")
		next
		%>
	</tr>
  </tfoot>
<tbody>
  
<%do until rsList.EOF%>
	<tr>
	<%
	Dim cnt 
	cnt = 0
	for each x in rsList.Fields
		If cnt = 0 Then
			%>
			<td> 
			<% 
			Response.Write("<a href='#' class='popAdm'>" & x.value & " </a>") %> </td>
			<%
		Else
			%>
			<td> <% Response.Write(x.value) 
			%> </td>
			<%
		End If	
		
		cnt = cnt + 1
	next
	%>

		<%rsList.MoveNext%>
	</tr>

<%
loop
rsList.close
set rsList=nothing
set strConn=nothing
SET cmdStoredProc = Nothing
%>
</table>
</tbody>

</body>
</html>
