<%@Language="VBScript" CodePage = 1253%>
<%option explicit%>
<!DOCTYPE html>
<html>
<head>
	<title>GREEK GUIDE - Word Count - Custom </title>
	<link rel="stylesheet" type="text/css" href="http://cdn.datatables.net/1.10.4/css/jquery.dataTables.css">	
	<link rel="stylesheet" type="text/css" href="css/styles.css">	
	<script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.3/js/jquery.dataTables.min.js"></script>
	<meta http-equiv='Content-Type' content='text/html; charset=windows-1253' />
	<meta http-equiv='Content-Language' content='el' />
</head>
<body class="inner">
<script type="text/javascript">

	
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
						
				]
		, "fnDrawCallback": function( oSettings ) {
			/* Open Entity Page from ADM.GREEKGUIDE ! */
			$("#GGresults").find(".popAdm").on('click', function(){
				DoOpenEntity(parseInt($(this).text().trim()));
			});
		    }
		,initComplete: function () {
            var api = this.api();
 
            api.columns().indexes().flatten().each( function ( i ) {
                var column = api.column( i );
				if( i != 5 && i != 6)
				{
					var select = $('<select><option value=""></option></select>')
						.appendTo( $(column.footer()).empty() )
						.on( 'change', function () {
							var val = $(this).val();
	 
							column
								.search( val ? '^'+val+'$' : '', true, false )
								.draw();
							
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(1)").text("");
							//$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(5)").text(""); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(6)").text( table.column(6, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(7)").text( table.column(7, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(8)").text( table.column(8, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(9)").text( table.column(9, {page:'current'}).data().sum() ); 
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(10)").text( table.column(10, {page:'current'}).data().sum() ); 
							
							$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(10)").addTemporaryClass("total", 1500);
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
	
	//keep session
	$("#selectEntities").val($("#sesEntities").text());
	
	
	// hide footer 2 columns
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(1)").text("");
	
	//$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(5)").text("");
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(6)").text( table.column(6).data().sum() );
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(7)").text( table.column(7).data().sum() );
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(8)").text( table.column(8).data().sum() );
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(9)").text( table.column(9).data().sum() );
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(10)").text( table.column(10).data().sum() );
	
	
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
	

function validInput(theNumber){    
    return theNumber.match(/^[-\d]+(?:,[-\d]*)*$/);
}

/*
$("#frm-submit" ).submit(function( event ) {
  event.preventDefault();
  if (  validInput( $( "input:selectEntities" ).val()) ) 
  {
    alert("Its valid!");
    return;
  }
 
  alert( "Not valid!" );
  
});
*/
	
	
</script>

<header>
	<a href="index.asp"><img src="img/logo.png" width="200" height="66"></a>
    <h1>4. Word Count - Custom</h1>
</header>

<form  name="frmsubmit" id="frm-submit" method="POST">
Enter a List of Entities Comma(,) separated to Search: 
<input type="text" name="Entities" id="selectEntities" placeholder="1343, 3420, 4030" />
<input type="submit" id="sbm-button" value="Show"/>
</form> 

<%
	Dim cnnSQL
	Dim cmdStoredProc
	Dim rsList, strConn, Entities, arrResults, result, x
	
	'A handy function i keep lying around for RegEx matches'
	Function RegExResults(strTarget, strPattern)
		Dim regEx
		Set regEx =  Server.CreateObject("VBScript.RegExp")
		regEx.Pattern = strPattern
		regEx.Global = true
		Set RegExResults = regEx.Execute(strTarget)
		Set regEx = Nothing
	End Function
	
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
	
	Entities = "0"
	Entities =  Request.Form("Entities")
	Session("xEntities") = Entities
	
	'Pass the original string and pattern into the function and get a collection object back'
	'Set arrResults = RegExResults(Entities, "^[-\d+\s]+(?:,[-\d+\s]*)*$")
	'Response.Write("TESTING")
	'Response.Write(arrResults.FirstIndex)
	'Response.Write(arrResults.Value )
	
	
	Set arrResults = Nothing

	If Entities = "" Then
		Entities = "0"
	End if
	
	'Retrieve all records.
	cmdStoredProc.CommandText = "usp_Word_Count_Custom"
	cmdStoredProc.CommandType = 4
	cmdStoredProc.CommandTimeout = 600
	'cmdStoredProc.Parameters("@GroupEntities") = Request.Form("Entities") 
	cmdStoredProc.Parameters.Append cmdStoredProc.CreateParameter("@GroupEntities", 202, 1, 1000, Entities) 
	
	'This code creates a recordset object.
	Set rsList = Server.CreateObject("ADODB.Recordset")
	rsList.CursorType = 3

	Set rsList.Source = cmdStoredProc.Execute()
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

<div id="sesEntities" style="display:none;"><%= Session("xEntities") %></div>



</body>
</html>
