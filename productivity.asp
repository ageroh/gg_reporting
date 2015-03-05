<%@Language="VBScript" CodePage = 1253%>
<%option explicit%>
<!DOCTYPE html>
<html>
<head>
	<title>GREEK GUIDE - Items Published per App</title>
	<link rel="stylesheet" type="text/css" href="http://cdn.datatables.net/1.10.4/css/jquery.dataTables.css">	
	<link rel="stylesheet" type="text/css" href="css/styles.css">	
	<script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.3/js/jquery.dataTables.min.js"></script>
	<meta http-equiv='Content-Type' content='text/html; charset=windows-1253' />
	<meta http-equiv='Content-Language' content='el' />
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
		, "columnDefs": [ { "visible": false,  "targets": [ 6] } ]
		,initComplete: function () {
            var api = this.api();
 
            api.columns().indexes().flatten().each( function ( i ) {
                var column = api.column( i );
				if( i > 0 && i <= 4)
				{
					var select = $('<select><option value=""></option></select>')
						.appendTo( $(column.footer()).empty() )
						.on( 'change', function () {
							var val = $(this).val();
	 
							column
								.search( val ? '^'+val+'$' : '', true, false )
								.draw();

							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(1)").text( table.column( 0, {page:'current'} ).data().sum() );
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(1)").addTemporaryClass("total", 1500);
						} );
	 
					column.data().unique().sort().each( function ( d, j ) {
						select.append( '<option value="'+d+'">'+d+'</option>' )
					} );
				}

            } );
        }
    } );
	
	/* Open Entity Page from ADM.GREEKGUIDE ! */
	$("#GGresults").find(".popAdm").on('click', function(){
		DoOpenEntity(parseInt($(this).text().trim()));
	});
	
	// hide footer 2 columns
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(6)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(7)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(1)").text( table.column( 0, {page:'current'} ).data().sum() );
		
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
<%
	'declare the variables
	Dim conn
	Dim ConnString 
	Dim rs
	Dim strCon
	Dim strSQL, x
		
		
	' Connection string.
	' PRODUCTION: 	strCon = "Provider=sqloledb;Data Source=10.0.64.32;Initial Catalog=GG_Reporting;User Id=ContentAbility_User_165;Password=3E6EA993-5EBA-4648-BF18-83C38D3E26DC"
	'strCon = "Provider=sqloledb;Data Source=localhost;Initial Catalog=GG_Reporting;User Id=sa;Password=pr1m$diA#"
	strCon = "Provider=sqloledb;Data Source=10.0.64.32;Initial Catalog=GG_Reporting;User Id=ContentAbility_User_165;Password=3E6EA993-5EBA-4648-BF18-83C38D3E26DC"
	
	
	' Create the required ADO objects.
	Set conn = Server.CreateObject("ADODB.Connection")
	Set rs = Server.CreateObject("ADODB.recordset")
		   
	' Open the connection.
	conn.Open strCon
	
	' Retrieve some records.
	strSQL = " select   * from uvw_Productivity_Per_App"
	
	rs.Open strSQL, conn
%>
<header>
	<a href="index.asp"><img src="img/logo.png" width="200" height="66"></a>
    <h1>1. Items Published per App</h1>
</header>

<table id="GGresults" class="display" cellspacing="0" width="100%" > 
  <thead>
	<tr>
		<%
		for each x in rs.Fields
				response.write("<th>" & ucase(x.name) & "</th>")
		next
		%>
	</tr>
  </thead>
   <tfoot>
	<tr>
		<%
		for each x in rs.Fields
				response.write("<th>" & ucase(x.name) & "</th>")
		next
		%>
	</tr>
  </tfoot>
<tbody>
  
<%do until rs.EOF%>



	<tr>

	<%
	Dim cnt 
	cnt = 0
	for each x in rs.Fields
		If cnt = 5 Then
			%>
			<td> <% Response.Write("<a href='#' class='popAdm'>" & x.value & " </a>") %>
			<%
		ElseIf cnt = 6 Then
			 Response.Write("&nbsp;&nbsp;-&nbsp;&nbsp;<a href='#' class='popAdm'>" & x.value & " </a>") %> </td><td></td>
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

		<%rs.MoveNext%>
	</tr>

<%
loop
rs.close
set rs=nothing
conn.close
set conn=nothing
%>
</tbody>
</table>

<span id="sumOut"></span>


</body>
</html>
