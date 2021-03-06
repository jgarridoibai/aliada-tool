<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="/struts-tags" prefix="html"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

	<head>
	    <title>Aliada</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	    <meta http-equiv="Content-Script-Type" content="text/javascript; charset=UTF-8"/>
	    <link rel="stylesheet" href="css/aliadaStyles.css" type="text/css"/>
	    <link rel="shortcut icon" href="images/aliada.ico"/>
	    <html:head/>	
	</head>
	<body class="bluebackground" >
	 	<div id="logonPanel">
			<div id="fieldsetContent">
				<div id="logonWelcome"><img src="images/aliada-logo.png"/></div>
					<div class="fields">
						<tiles:insertAttribute name="body" />
					</div>
					<div class="copyrightLogin">
						<tiles:insertAttribute name="footer" />
					</div>	
				</div>
			</div>
	</body>
</html>
