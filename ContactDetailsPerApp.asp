<%@Language="VBScript" CodePage = 1253%>
<%option explicit%>
<!DOCTYPE html>
<html>
<head>
	<title>GREEK GUIDE - Contact Details Location</title>
	<link rel="stylesheet" type="text/css" href="http://cdn.datatables.net/1.10.4/css/jquery.dataTables.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">		
	<script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.3/js/jquery.dataTables.min.js"></script>
	<meta http-equiv='Content-Type' content='text/html; charset=windows-1253' />
	<meta http-equiv='Content-Language' content='el' />
</head>
<body class="inner">

<script>



function webSplit(web){
    sRes = "";
    splited = web.split(",");
    splited.forEach(function(entry){ 
        // fix entry with appropriate href call
        link = entry.trim();
        if( !(link.indexOf("http://") == 0 ||  link.indexOf("https://") == 0) )
	  link = "http://" + link;
   
        found = '<a href="' + link + '" target="_blank">' + link +  "</a>";
 	sRes = sRes + found + "<br />";
   });
   return sRes;
}


function callClient(sUrl, telephoneClient)
{
     // Always call client
    //if (confirm("Really dial " + telephoneClient + " NOW ?") == true) {
	img = new Image();

	// handle fake failure
	img.onerror = function(){
		// do somthing wheen pick up the phone.
	//  alert("Thank you for calling : " + telephoneClient);
	};

	img.src = sUrl;
    //} 
}


function telephonize(tel, telephoneUser){
	sRes = "";
	splited = tel.split(",");
	splited.forEach(function(entry){ 
		// trim each string, replace +30 +30
		entry = entry.trim().replace("+30", "").replace("+0030", "");
		//entry = entry.trim().replace(/\s/g, "");
		
		// regex : telephone
		re = /(\d{3,}[\s]*\d{1,}[\s]*\d{1,})/; 
		aFound = entry.match(re); // suppose is found, then replace it with (href and necessary info)
		if(aFound != null)
		{
			found = aFound[0];
			// fix entry with appropriate href call
			telephoneClient = found.trim().replace(/\s/g, "");
			entry = entry.replace(found, 
					'<a  href="javascript:void(0);"   onclick="callClient(\'http://10.168.10.190/call/call.php?src=' + telephoneUser +'&dst=' + telephoneClient + '\'  , ' + telephoneClient 
						+ ' )"  class="callPhone">'
						+ telephoneClient 
					+'</a>'
				);
		}
		
		sRes = sRes + entry + "<br />";
	});

	return sRes;
}

$(document).ready(function() {
    var table = $('#GGresults').DataTable( {
		  "order": [[ 1, "asc" ]]
		, "lengthMenu": [ [-1, 10, 25, 50], ["All", 10, 25, 50 ] ]
		, "columnDefs": 
		 [
		    {
			"render": function ( data, type, row ) {
			    return 'EN: '+ row[3]+' </br>GR: <i>' + row[4] + '</i>' ;		// Entity Column
			},
			"targets": 3
		    }			
		  ,
		    {
			"render": function ( data, type, row ) {
			    if( row[5] != '' && row[6] != '')
				return 'EN: '+ row[5]+' </br>GR: <i>' + row[6] + '</i>' ;		// Entity Column
			    return '';
			},
			"targets": 5
		    }		  
		  ,
		    {
			"render": function ( data, type, row ) {
			   if( row[7] != '' && row[8] != '')
			    return 'tel: '+ telephonize(row[7], $("#selectedUsersPhone").text()) +' </br>email: <i>' + row[8] + '</i>' ;		// Entity Column
			   return '';
			},
			"targets": 7
		    }		  		    

		  ,
		    {
			"render": function ( data, type, row ) {
			   if( row[9] != '')
			    return  webSplit(row[9]);
			   return '';
			},
			"targets": 9
		    }		  		    
		    
		    , { 
			"visible": false
		      ,  "targets": [ 1, 4, 6, 8 ]
	            }
		 ]
	} );
	
	/* Open Entity Page from ADM.GREEKGUIDE ! */
	$("#GGresults").find(".popAdm").on('click', function(){
		DoOpenEntity(parseInt($(this).text().trim()));
	});
	
	// initialize vars 
	$("#usersPhoneInternalID").val(localStorage.getItem("internalPhone"));
	$("#selectAppID").val($("#selectedAppHdn").text());
	
	// hide footer 2 columns
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(2)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(4)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(5)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(6)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(7)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(8)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(9)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(10)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(11)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(12)").text("")
	$("#GGresults").find("tfoot tr:nth-child(1) th:nth-child(13)").text("")
	
	$("#sbm-button").click( function( event ) {
	  if( ! localStorage.getItem("internalPhone") )
	  {
	    localStorage.setItem('internalPhone', $("#usersPhoneInternalID").val());
	  }
	  else if ( localStorage.getItem("internalPhone") != $("#usersPhoneInternalID").val() )
	  {
	    localStorage.setItem('internalPhone', $("#usersPhoneInternalID").val());
	  }
	});
		
});


	
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
    <h1>5. Contact Details Location</h1>
</header>


<form  name="frm-submit" id="frm-submit" method="POST">
<div id="resultDIV" ></div>
<table>
 <tr>
  <td>Destination</td>
  <td>

<%
	
	Dim conn2
	Dim ConnString 
	Dim strCon1
	Dim strSQL, x
	Dim drs
	
	' Connection string.
	strCon1 = "Provider=sqloledb;Data Source=10.0.64.32;Initial Catalog=GG_Reporting;User Id=ContentAbility_User_165;Password=3E6EA993-5EBA-4648-BF18-83C38D3E26DC"	   
		   
	' Create the required ADO objects.
	Set conn2 = Server.CreateObject("ADODB.Connection")
	Set drs = Server.CreateObject("ADODB.recordset")

	' Retrieve some records.
	strSQL = " select catCategoryID, [Destination] from  uvw_Get_All_Apps "
			
	conn2.open strCon1
	set drs = conn2.execute(strSQL)
	%> 


	<select name="AppID" id="selectAppID">
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
		SET strCon1 = Nothing
		%>
	</select>
   </td>
   </tr>
   <tr>
     <td>Internal Telephone</td>

     <td>
      <input type="text" id="usersPhoneInternalID" name="usersPhoneInternalID">
     </td>
   </tr>
   <tr>
      <td></td>
      <td><input type="submit" id="sbm-button" value="Show"/></td>
   </tr>
</table>   


</form> 





<%
	Dim cnnSQL
	Dim cmdStoredProc
	Dim rs, strConn, AppID, telInternal
	
	
	
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

	AppID = "-1"
	'Retrieve AppID
	AppID =  Request.Form("AppID")
	Session("xAppIDCotact") = AppID
	
	telInternal = Request.Form("usersPhoneInternalID")
	Session("xusersPhoneInternal") = telInternal
	If Not ( IsNumeric(telInternal) and Len(Trim(telInternal)) = 4 ) Then
	   ' later maybe add a check if tel exists in https://10.168.10.190/phonebook/ !
	   AppID = -1
	End If
	
	'Retrieve all records.
	cmdStoredProc.CommandText = "USP_GET_CONTACT_DETAILS_LOCATION_TYPE"
	cmdStoredProc.CommandType = 4
	cmdStoredProc.CommandTimeout = 1000
	cmdStoredProc.Parameters.Append cmdStoredProc.CreateParameter("@catCategoryID", 202, 1, 50, AppID) 
	
	'This code creates a recordset object.
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.CursorType = 3

	Set rs.Source = cmdStoredProc.Execute
	rs.Open
	
%>

<table id="GGresults" class="display" cellspacing="0" width="100%" > 
  <thead>
	<tr>
		<%
		for each x in rs.Fields
				Response.write("<th>" & ucase(x.name) & "</th>")
		next
		%>
	</tr>
  </thead>
   <tfoot>
	<tr>
		<%
		for each x in rs.Fields
				Response.write("<th>" & ucase(x.name) & "</th>")
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
		If cnt = 0 Then
			%>
			<td> <% Response.Write("<a href='#' class='popAdm'>" & x.value & " </a>") %> </td>
			<%
		ElseIf cnt = 8 Then
			%>
			<td>
			<% Response.Write("<a href='mailto:"& x.value  & "' >" & x.value & "</a>") %>
			</td>
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
set strConn=nothing
%>
</tbody>
</table>

<div id="selectedAppHdn" style="display:none;"><%= CInt(Session("xAppIDCotact")) %></div>
<div id="selectedUsersPhone" style="display:none;"><%= Session("xusersPhoneInternal") %></div>


</body>
</html>
