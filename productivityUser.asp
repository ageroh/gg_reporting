<%@Language="VBScript"%>
<%option explicit%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="el" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
	<meta http-equiv='Content-Type' content='text/html; charset=windows-1253' />
	<meta http-equiv='Content-Language' content='el' />
	<title>GREEK GUIDE - Items Published per User</title>
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
		, "pagingType": "full_numbers"
		, "lengthMenu": [ [10, 25, 50, -1], [10, 25, 50, "All"] ]
        
		, "columnDefs": [
			 {
                "render": function ( data, type, row ) {
                    return data +' </br>By: '+ row[5]+' </br><i>' + row[6] + '</i>' ;		// Entity Column
                },
                "targets": 0
            }			

			, {
                "render": function ( data, type, row ) {
					if ( row[10] != row[12]
						|| 	row[12] != row[14] 
						|| 	row[10] != row[14]
						)
						return data + '</br>(<strong><font color="red">'+ row[10] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[10] + '</strong>)';
               },
               "targets": 9
            }

			, {
                "render": function ( data, type, row ) {
					if ( row[10] != row[12]
						|| 	row[12] != row[14] 
						|| 	row[10] != row[14]
						)
						return data + '</br>(<strong><font color="red">'+ row[12] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[12] + '</strong>)';
               },
               "targets": 11
            }

			, {
                "render": function ( data, type, row ) {
					if ( row[10] != row[12]
						|| 	row[12] != row[14] 
						|| 	row[10] != row[14]
						)
						return data + '</br>(<strong><font color="red">'+ row[14] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[14] + '</strong>)';
               },
               "targets": 13
            }

            , {
                "render": function ( data, type, row ) {
                    return data +' min </br>'+ row[4]+' saves </br><i>' + row[6] + '</i></br><i>' + row[7] + '</i>' ;		// Entity Column
                },
                "targets": 3
            }

           // , {
           //     "render": function ( data, type, row ) {
           //         return  data + '</br><i>'+ row[8] + '</i>';
           //     },
           //     "targets": 1
           // }			
			
			/* TITLE */
			, {
                "render": function ( data, type, row ) {
					if ( row[16] != row[18]
						|| 	row[18] != row[20] 
						|| 	row[16] != row[20]
						)
						return data + '</br>(<strong><font color="red">'+ row[16] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[16] + '</strong>)';
               },
               "targets": 15
            }
			, {
                "render": function ( data, type, row ) {
					if ( row[16] != row[18]
						|| 	row[18] != row[20] 
						|| 	row[16] != row[20]
						)
						return data + '</br>(<strong><font color="red">'+ row[18] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[18] + '</strong>)';
               },
               "targets": 17
            }
			, {
                "render": function ( data, type, row ) {
					if ( row[16] != row[18]
						|| 	row[18] != row[20] 
						|| 	row[16] != row[20]
						)
						return data + '</br>(<strong><font color="red">'+ row[20] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[20] + '</strong>)';
               },
               "targets": 19
            }
			
			/* SHORT DESCRIPTION */
			, {
                "render": function ( data, type, row ) {
					if ( row[22] != row[24]
						|| 	row[22] != row[26] 
						|| 	row[24] != row[26]
						)
						return data + '</br>(<strong><font color="red">'+ row[22] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[22] + '</strong>)';
               },
               "targets": 21
            }
			, {
                "render": function ( data, type, row ) {
					if ( row[22] != row[24]
						|| 	row[22] != row[26] 
						|| 	row[24] != row[26]
						)
						return data + '</br>(<strong><font color="red">'+ row[24] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[24] + '</strong>)';
               },
               "targets": 23
            }
			, {
                "render": function ( data, type, row ) {
					if ( row[22] != row[24]
						|| 	row[22] != row[26] 
						|| 	row[24] != row[26]
						)
						return data + '</br>(<strong><font color="red">'+ row[26] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[26] + '</strong>)';
               },
               "targets": 25
            }
			
			/* USEULL */
			, {
                "render": function ( data, type, row ) {
					if ( row[28] != row[30]
						|| 	row[28] != row[32] 
						|| 	row[30] != row[32]
						)
						return data + '</br>(<strong><font color="red">'+ row[28] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[28] + '</strong>)';
               },
               "targets": 27
            }
			, {
                "render": function ( data, type, row ) {
					if ( row[28] != row[30]
						|| 	row[28] != row[32] 
						|| 	row[30] != row[32]
						)
						return data + '</br>(<strong><font color="red">'+ row[30] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[30] + '</strong>)';
               },
               "targets": 29
            }
			, {
                "render": function ( data, type, row ) {
					if ( row[28] != row[30]
						|| 	row[28] != row[32] 
						|| 	row[30] != row[32]
						)
						return data + '</br>(<strong><font color="red">'+ row[32] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[32] + '</strong>)';
               },
               "targets": 31
            }

			/* EDITORIAL  */ 
			, {
                "render": function ( data, type, row ) {
					if ( row[34] != row[36]
						|| 	row[34] != row[38] 
						|| 	row[36] != row[38]
						)
						return data + '</br>(<strong><font color="red">'+ row[34] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[34] + '</strong>)';
               },
               "targets": 33
            }
			, {
                "render": function ( data, type, row ) {
					if ( row[34] != row[36]
						|| 	row[34] != row[38] 
						|| 	row[36] != row[38]
						)
						return data + '</br>(<strong><font color="red">'+ row[36] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[36] + '</strong>)';
               },
               "targets": 35
            }
			, {
                "render": function ( data, type, row ) {
					if ( row[34] != row[36]
						|| 	row[34] != row[38] 
						|| 	row[36] != row[38]
						)
						return data + '</br>(<strong><font color="red">'+ row[38] + '</font></strong>)';
					else
						return data + '</br>(<strong>'+ row[38] + '</strong>)';
               },
               "targets": 37
            }
			
			

			
			// hide columns !
			, { "visible": false,  "targets": [ 4, 5, 6, 7, 10, 12, 14 , 38, 36, 34, 32, 30, 28, 26, 24, 22, 20, 18, 16] }
        ]

		, initComplete: function () {
            var api = this.api();
 
            api.columns().indexes().flatten().each( function ( i ) {
                var column = api.column( i );
				if( i == 2 || i == 8)// 2 || i == 3 || i == 9)
				{
					var select = $('<select><option value=""></option></select>')
						.appendTo( $(column.footer()).empty() )
						.on( 'change', function () {
							var val = $(this).val();
	 
							column
								.search( val ? '^'+val+'$' : '', true, false )
								.draw();

							//$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(1)").text( table.column( 0, {page:'current'} ).data().sum() );
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
	
	/* Open Entity Page from ADM.GREEKGUIDE ! */
	$("#GGresults").find(".popAdm").on('click', function(){
		DoOpenEntity(parseInt($(this).text().trim()));
	});
	
	// hide footer columns not needed
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(1)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(2)").text("")
	//$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(3)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(4)").text("")
	//$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(5)").text("")		// Show category
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(6)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(7)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(8)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(9)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(10)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(11)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(12)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(13)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(14)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(15)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(16)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(17)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(18)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(19)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(20)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(21)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(22)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(23)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(24)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(25)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(26)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(27)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(28)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(29)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(30)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(31)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(32)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(33)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(34)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(35)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(36)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(37)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(38)").text("")
	
	//$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(6)").hide()
	//$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(7)").hide()
	//$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(1)").text( table.column( 0, {page:'current'} ).data().sum() );
		
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
	<a href="index.asp"><img src="img/logo.jpg" width="200" height="66"></a>
    <h1>2. Items Published per User</h1>
</header>
<form  name="frm-submit" id="frm-submit" method="POST">
User: 

<%
	Dim conn2
	Dim ConnString 
	Dim rs
	Dim strCon
	Dim strSQL, x
	Dim drs
		
	' Connection string.
	' PRODUCTION: 	strCon = "Provider=sqloledb;Data Source=10.0.64.32;Initial Catalog=GG_Reporting;User Id=ContentAbility_User_165;Password=3E6EA993-5EBA-4648-BF18-83C38D3E26DC"
	'strCon = "Provider=sqloledb;Data Source=localhost;Initial Catalog=GG_Reporting;User Id=sa;Password=pr1m$diA#"
	strCon = "Provider=sqloledb;Data Source=10.0.64.32;Initial Catalog=GG_Reporting;User Id=ContentAbility_User_165;Password=3E6EA993-5EBA-4648-BF18-83C38D3E26DC"	   
		   
	' Create the required ADO objects.
	Set conn2 = Server.CreateObject("ADODB.Connection")
	Set drs = Server.CreateObject("ADODB.recordset")

	' Retrieve some records.
	strSQL = "	select wusUserID, wusLogin		" &_
			"	from uvw_Get_User_Editors		" &_
			"	order by wusLogin asc			"
			
	conn2.open strCon
	set drs = conn2.execute(strSQL)
	%> 



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
		SET strCon = Nothing
		%>
	</select>

<input type="submit" id="sbm-button" value="Show"/>
</form> 


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
	Userid =  Request.Form("Userid")
	Session("xUserid") = Userid
	
	'Retrieve all records.
	cmdStoredProc.CommandText = "USP_Report_Productivity_Per_User"
	cmdStoredProc.CommandType = 4
	cmdStoredProc.CommandTimeout = 1000
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

<div id="selectedUserHdn" style="display:none;"><%= CInt(Session("xUserid")) %></div>
	
	

</body>
</html>
