<%@Language="VBScript"%>
<%option explicit%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="el" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
	<meta http-equiv='Content-Type' content='text/html; charset=windows-1253' />
	<meta http-equiv='Content-Language' content='el' />
	<title>GREEK GUIDE - Total Word Count for all Items per User</title>
	<!-- DataTables CSS -->
	<link rel="stylesheet" type="text/css" href="http://cdn.datatables.net/1.10.4/css/jquery.dataTables.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">	
	<script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.3/js/jquery.dataTables.min.js"></script>
</head>
<body class="inner">
<script>


$.fn.dataTable.Api.register( 'column().data().sum()', function () {
    return this.reduce( function (a, b) {
        var x = parseFloat( a ) || 0;
        var y = parseFloat( b ) || 0;
        return x + y;
    } );
} );

 	

$(document).ready(function() {
    var table = $('#GGresults').DataTable( {
		"order": [[ 1, "asc" ]]
		,"lengthMenu": [ [-1, 10, 25, 50], ["All", 10, 25, 50 ] ]
		
		, "columnDefs": [
					{
						"targets": [ 6 ],
						"visible": false,
						"searchable": false
					}
					,{
						"targets": [ 3 ],
						"sClass" : "leftAlign"
					} 
				    
					,{
						"targets": [ 2 ],
						"sClass" : "hideAll"
					} 
				    
				    
		    			, {
					    "render": function ( data, type, row ) {
					    return data +' </br>By: '+ row[5]+' </br><i>' + row[6] + '</i>' ;		// Entity Column
					  },
					  "targets": 0
					}
					, {
					    "render": function ( data, type, row ) {
					         return data +' min </br>'+ row[4]+' saves </br><i>' + row[6] + '</i></br><i>' + row[7] + '</i>' ;		// Entity Column
					      },
					      "targets": 3
					}
					, { "visible": false,  "targets": [  4, 5, 6, 7] }
						
				]
		, "fnDrawCallback": function( oSettings ) {
			// Open Entity Page from ADM.GREEKGUIDE ! 
			$("#GGresults").find(".popAdm").on('click', function(){
				DoOpenEntity(parseInt($(this).text().trim()));
			});
		    }
		,initComplete: function () {
            var api = this.api();
 
            api.columns().indexes().flatten().each( function ( i ) {
                var column = api.column( i );
				if( i >= 8 || i==0)// != 5 && i != 6)
				{
					var select = $('<select><option value=""></option></select>')
						.appendTo( $(column.footer()).empty() )
						.on( 'change', function () {
							var val = $(this).val();
	 
							column
								.search( val ? '^'+val+'$' : '', true, false )
								.draw();
							
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(6)").text( table.column(9, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(7)").text( table.column(10, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(8)").text( table.column(11, {page:'current'}).data().sum() ); 
							

							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(9)").text( table.column(12, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(10)").text( table.column(13, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(11)").text( table.column(14, {page:'current'}).data().sum() );

							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(12)").text( table.column(15, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(13)").text( table.column(16, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(14)").text( table.column(17, {page:'current'}).data().sum() );

							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(15)").text( table.column(18, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(16)").text( table.column(19, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(17)").text( table.column(20, {page:'current'}).data().sum() );

							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(18)").text( table.column(21, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(19)").text( table.column(22, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(20)").text( table.column(23, {page:'current'}).data().sum() );

							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(21)").text( table.column(24, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(22)").text( table.column(25, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(23)").text( table.column(26, {page:'current'}).data().sum() );
							
							//$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(2)").text(   table.fnGetData().length );
							//$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(1)").addTemporaryClass("total", 1500);
						} );
	 
					column.data().unique().sort().each( function ( d, j ) {
						select.append( '<option value="'+d+'">'+d+'</option>' )
					} );
				}

                } );
             }
	} );
	
	$("#selectUserID").val($("#selectedUserHdn").text());
	$("#selectDestinationID").val($("#selectedDestinationHdn").text());
	

	// hide column at all
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(1)").text("");
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(2)").text("");
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(3)").text("");
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(4)").text("");
	
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(6)").text( table.column(9, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(7)").text( table.column(10, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(8)").text( table.column(11, {page:'current'}).data().sum() );

	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(9)").text( table.column(12, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(10)").text( table.column(13, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(11)").text( table.column(14, {page:'current'}).data().sum() );

	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(12)").text( table.column(15, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(13)").text( table.column(16, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(14)").text( table.column(17, {page:'current'}).data().sum() );

	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(15)").text( table.column(18, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(16)").text( table.column(19, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(17)").text( table.column(20, {page:'current'}).data().sum() );

	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(18)").text( table.column(21, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(19)").text( table.column(22, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(20)").text( table.column(23, {page:'current'}).data().sum() );

	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(21)").text( table.column(24, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(22)").text( table.column(25, {page:'current'}).data().sum() ); 
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(23)").text( table.column(26, {page:'current'}).data().sum() );
	
	
} );



function DoOpenEntity(iEntityID) 
{
	if (iEntityID > 0) {
		//frmMain.openEnt.value = iEntityID;
		wndOpenPopUp('http://adm.greekguide.com/ent/ent_open.asp?entEntityID=' + iEntityID, 'entity_' + iEntityID, 'L');
	}
	else {
		//frmMain.openEnt.value = '';
		alert('Please type a valid number.');
		//frmMain.openEnt.focus();
	}
}	

function wndOpenPopUp(sURL, sName, sWidth) 
{
	var iWidth = 1010;
	var iHeight = window.screen.availHeight - 70;
	if (sWidth != 'L') {
		if (sWidth == 'XL') {
			iWidth = 1040;
			iHeight = 760;
		} else if (sWidth == 'R') {
			iWidth = 1000;
			iHeight = 560;
		} else if (sWidth == 'M') {
			iWidth = 700;
			iHeight = 550;
		} else if (sWidth == 'F') {
			iWidth = 700;
			iHeight = 300;
		} else if (sWidth == 'P') {
			iWidth = 700;
			iHeight = 680;
		} else if (sWidth == 'XS') {
			iWidth = 450;
			iHeight = 280;
		} else if (sWidth == 'C') {
			iWidth = 800;
			iHeight = 500;
		} else {
			iWidth = 500;
			iHeight = 380;
		}
	}
	var iLeft = (((window.screen.availWidth - iWidth) / 2));
	var iTop = 1;
	if (iTop < 5) {
		iTop = 1;
	}
	if (iLeft < 30) {
		iLeft = 1;
	}
	window.open(sURL, "", 'top=' + iTop + ', left=' + iLeft + ', width=' + iWidth + ', height=' + iHeight + ', location=no, address=no, scrollbars=yes, resizable=yes, status=no');
}

(function($){

    $.fn.extend({ 

        addTemporaryClass: function(className, duration) {
            var elements = this;
            setTimeout(function() {
                elements.removeClass(className);
            }, duration);

            return this.each(function() {
                $(this).addClass(className);
            });
        }
    });

})(jQuery);
	
	
		
</script>
<header>
	<a href="index.asp"><img src="img/logo.png" width="200" height="66"></a>
    <h1>6. Total Word Count Published per User</h1>
</header>
<form  name="frm-submit" id="frm-submit" method="POST">
<table>
<tr>
<td>User: </td>

<%
	Dim conn2, conn3
	Dim ConnString 
	Dim rs
	Dim strCon
	Dim strSQL, strSQL2, x
	Dim drs, drs2
		
	' Connection string.
	' PRODUCTION: 	strCon = "Provider=sqloledb;Data Source=10.0.64.32;Initial Catalog=GG_Reporting;User Id=ContentAbility_User_165;Password=3E6EA993-5EBA-4648-BF18-83C38D3E26DC"
	'strCon = "Provider=sqloledb;Data Source=localhost;Initial Catalog=GG_Reporting;User Id=sa;Password=pr1m$diA#"
	strCon = "Provider=sqloledb;Data Source=10.0.64.32;Initial Catalog=GG_Reporting;User Id=ContentAbility_User_165;Password=3E6EA993-5EBA-4648-BF18-83C38D3E26DC"	   
		   
	' Create the required ADO objects.
	Set conn2 = Server.CreateObject("ADODB.Connection")
	Set drs = Server.CreateObject("ADODB.recordset")
	Set conn3 = Server.CreateObject("ADODB.Connection")
	Set drs2 = Server.CreateObject("ADODB.recordset")

	
	' Retrieve some records.
	strSQL = "	select wusUserID, wusLogin		" &_
			"	from uvw_Get_User_Editors		" &_
			"	order by wusLogin asc			"
			
	conn2.open strCon
	set drs = conn2.execute(strSQL)
	
	' Destinations
	strSQL2 = "	select catCategoryID, Destination		" &_
			"	from  dbo.uvw_Get_All_Apps		" &_
			"	order by Destination asc			"
			
	conn3.open strCon
	set drs2 = conn3.execute(strSQL2)
	%> 


<td>
	<select name="Userid" id="selectUserID">
		<option value="-1" selected> - Please Select - </option>
		<%

		do while not drs.eof %>

			<option value="<%= drs.Fields(0) %>" ><%= drs.Fields(1) %></option>
			<% drs.MoveNext
		Loop
		drs.close
		set drs=nothing
		conn2.close
		set conn2=nothing
		%>
	</select>
</td>
</tr>
<tr>
  <td>Destination: </td>
  <td>
	<select name="DestinationID" id="selectDestinationID">
		<option value="-1" selected> - Please Select - </option>
		<%
	
		do while not drs2.eof %>

			<option value="<%= drs2.Fields(0) %>" ><%= drs2.Fields(1) %></option>
			<% drs2.MoveNext
		Loop
		drs2.close
		set drs2=nothing
		conn3.close
		set conn3=nothing
		SET strCon = Nothing
		%>
	</select>
  </td>
</tr>
<tr><td></td><td><input type="submit" id="sbm-button" value="Show"/></td></tr>
<tr><td></td><td><font color="red"><b>Results with one day latency</b></font></td></tr>
</table>  


</form> 


<%
	Dim cnnSQL
	Dim cmdStoredProc
	Dim rsList, strConn, Userid, DestinationID
	
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
	Userid =  Request.Form("Userid")
	Session("xUserid") = Userid
	
	DestinationID = "-1"
	DestinationID = Request.Form("DestinationID")
	Session("xDestinationID") = DestinationID
	
	'Retrieve all records.
	cmdStoredProc.CommandText = "USP_Report_Productivity_Per_User_TotalWC"
	cmdStoredProc.CommandType = 4
	cmdStoredProc.CommandTimeout = 1000
	cmdStoredProc.Parameters.Append cmdStoredProc.CreateParameter("@User_id", 202, 1, 50, Userid) 
	cmdStoredProc.Parameters.Append cmdStoredProc.CreateParameter("@Destination_id", 202, 1, 50, DestinationID) 
	
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

<div id="selectedUserHdn" style="display:none;"><%= CInt(Session("xUserid")) %></div>
<div id="selectedDestinationHdn" style="display:none;"><%= CInt(Session("xDestinationID")) %></div>
	
	

</body>
</html>
