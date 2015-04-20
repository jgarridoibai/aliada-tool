<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="html"%>
<script>
function confirmBox(){
	var answer = window.confirm("<html:text name='conversion.cleanGraph'/>");
	if (answer == true){
		var graphToCleanId = $("#graphToClean").val();
		console.log("Cleaning graph");
		window.location.href = "${pageContext.request.contextPath}/cleanGraph.action?graphToCleanId="+graphToCleanId;
	}
	else{
		console.log("Not cleaned");
		window.location = "${pageContext.request.contextPath}/conversion.action";
	}
	return false;
}
$(function(){
	var showCheckButton = $("#showCheckButton").val();
	var showRdfizerButton = $("#showRdfizerButton").val();
	var rdfizerStatus = $("#rdfizerStatus").val();
	console.log(rdfizerStatus);
	if(rdfizerStatus =="running"){
		$("#cleanGraphPanel").hide();
		$("#templateSelect").hide();
		$("#templateProperty").show();
		$("#datasetSelect").hide();
		$("#datasetProperty").show();
		$("#graphSelect").hide();
		$("#graphProperty").show();
		$("#datSelect").hide();
		$("#both").hide();
		$("#data").show();
		$("#d").show();
		$("#subs").show();
		$("#s").show();
	} 
	var interval;
	var checkRDF = function(){
		console.log("checking RDF");
		var rdfizerJobId = $("#rdfizerJobId").val();
		var urlPath = "/aliada-rdfizer-2.0/jobs/"+rdfizerJobId;
		//var urlPath = "/rdfizer/jobs/"+rdfizerJobId;
	    $.ajax({
	      type: "GET",
	      url: urlPath,
	      dataType : 'xml',
	      success: function(xml) {
               var format = $(xml).find("format").text();
               $("#format").text(format);
               var recordNum = $(xml).find("total-records-count").text();
               $("#recordNum").text(recordNum);
               var processedNum = $(xml).find("processed-records-count").text();
               $("#processedNum").text(processedNum);
               var statementsNum = $(xml).find("output-statements-count").text();
               $("#statementsNum").text(statementsNum);
               var processingThroughput = $(xml).find("records-throughput").text();
               $("#processingThroughput").text(processingThroughput);
               var triplesThroughput = $(xml).find("triples-throughput").text();
               $("#triplesThroughput").text(triplesThroughput);
               console.log(completed);
	    	   console.log(xml);
	    	   var completed = $(xml).find("completed").text();
               if(completed=="true"){

            	   var statusCode = $(xml).find("status-code").text();
            	   console.log("Code: "+statusCode);
            	   if(statusCode == 0) {
    			       $("#fineImg").show();
            	   } else if(statusCode == -1) {
    			       $("#errorImg").show();
            		   $("#validationError").show();
            		   var validationErrorMess = $(xml).find("description").text();
            		   console.log("Message: "+validationErrorMess);
            		   $("ValError").text(validationErrorMess);
            	   }
                   
            	   $("#status").text("Completed");
		   		   $("#checkRDFButton").prop("disabled",true);
			       $("#nextButton").removeClass("button");
			       $("#nextButton").addClass("buttonGreen");
			       $("#nextButton").prop("disabled",false);
			       $("#rdfVal").show("fast");
			       $("#linksVal").show("fast");
			       $("#progressBar").hide();
		   		   console.log("interval stopped");
		   		   clearInterval(interval);
               }
               else{
            	   $("#status").text("Running");            	   
               }
	      },
	      error : function(jqXHR, status, error) {
	          console.log("Error");
	      },
	      complete : function(jqXHR, status) {
	          console.log("Completed");
	      }
   		});   
	};
	$("#datasetSelect").on("change", function(){
		var d = $("#datasetSelect").val();
		console.log(d);
		$("#graphSelect").show();
	});
	
	$("#checkRDFButton").on("click",function(){
		$("#rdfizePanel").hide();		
		$("#checkInfo").show("fast");
		$('#progressBar').show();
		$('#checkRDFButton').hide();
		console.log("Checking");
		interval = setInterval( checkRDF, 3000 );		
	});
	if(showRdfizerButton==1){
	   	$("#rdfizeButton").removeClass("button");
	   	$("#rdfizeButton").addClass("buttonGreen");
		$('#rdfizeButton').prop("disabled",false);		
	}
	else{
	   	$("#rdfizeButton").removeClass("buttonGreen");
	   	$("#rdfizeButton").addClass("button");
		$('#rdfizeButton').prop("disabled",true);			
	}
	if(showCheckButton==1){
	   	$("#checkRDFButton").removeClass("button");
	   	$("#checkRDFButton").addClass("buttonGreen");
		$('#checkRDFButton').prop("disabled",false);
		$('#backButton').prop("disabled",true);		
	}
	$('#datSelect').find('br').remove();
}); 
</script>

<html:hidden id="rdfizerStatus" name="rdfizerStatus" value="%{#session['rdfizerStatus']}" />
<html:hidden id="rdfizerJobId" name="rdfizerJobId" value="%{#session['rdfizerJobId']}" />
<html:hidden id="showRdfizerButton" name="showRdfizerButton" value="%{showRdfizerButton}" />
<html:hidden id="showCheckButton" name="showCheckButton" value="%{showCheckButton}" />
<ul class="breadcrumb">
	<span class="breadCrumb"><html:text name="home"/></span>
	<li><span class="breadcrumb"><html:text name="manage.title"/></span></li>
	<li><span class="breadcrumb activeGreen"><html:text name="conversion.title"/></span></li>
	<li><span class="breadcrumb"><html:text name="linking.title"/></span></li>
</ul>
<%-- doubleselect style to show at the same line  --%>
<style> 
	.nobr {
		display: inline-block;
		white-space: nowrap;
		}  
</style>
<html:a id="rdfVal" disabled="true" action="rdfVal" cssClass="displayNo menuButton button fleft" key="rdfVal" target="_blank"><html:text name="rdfVal"/></html:a>
<%--<html:a id="linksVal" disabled="true" action="linksVal" cssClass="displayNo menuButton button fright" key="linksVal" target="_blank"><html:text name="linksVal"/></html:a>--%>		
<div class="form centered">
	<html:form id="conversion">
		<div id="rdfizePanel" class="content">
			<label class="row label"><html:text name="conversion.filesTo"/></label>
			<table class="table">
				<tr class="backgroundGreen center">
					<th><label class="bold"><html:text name="conversion.input"/></label></th>
					<th><label class="bold"><html:text name="conversion.template"/></label></th>
					<th id="both"><label class="bold"><html:text name="conversion.select"/></label></th>
					<th id="d" class="displayNo"><label class="bold"><html:text name="conversion.dataset"/></label></th>
					<th id="s" class="displayNo"><label class="bold"><html:text name="conversion.graph"/></label></th>
				</tr>
				<tr>
					<td>
						<html:property value="importedFile.getFilename()" />
					</td>
					<td>
						<html:select id="templateSelect" name="selectedTemplate"
							cssClass="inputForm" list="templates" />
						<span id="templateProperty" class="displayNo"><html:property  value="importedFile.getTemplate()" /></span>					
					</td>
					<td>
						<div id="datSelect" class="nobr">
								<html:doubleselect cssClass="inputForm"
								name="dat" list="datasetMap.keySet()" doubleCssClass="inputForm"
								doubleName="sub" doubleList="datasetMap.get(top)" />
						</div>
						<span id="data" class="displayNo"><html:property  value="importedFile.getDataset()" /></span>
					</td>
					<td>
						<span id="subs" class="displayNo"><html:property  value="importedFile.getGraph()" /></span>
					</td>
				</tr>			
			</table>
			<div id="conversionButtons" class="buttons row">	
				<html:submit id="rdfizeButton" action="RDFize" disabled="true" cssClass="submitButton button"
					key="RDF-ize"/>
				<html:submit id="checkRDFButton" disabled="true" cssClass="submitButton button"
					key="check" onClick="return false;"/>
			</div>
			<div id="cleanGraphPanel">
				<label class="row label"><html:text name="conversion.cleanSelect"/></label>
			<div class="row">
				<html:select id="graphToClean" cssClass="inputForm" list="graphs" />
			</div>
			<div class="row">
				<%-- <html:submit action="cleanGraph" cssClass="submitButton button"
					key="conversion.clean" /> --%>
				<html:submit onclick="return confirmBox();" cssClass="submitButton button"
					key="conversion.clean" />
			</div>
			</div>
			<html:actionmessage />
		</div>
		<div id="checkInfo" class="displayNo content">
			<div class="row">
				<label class="label"><html:text name="rdf.fileTo"/></label>
				<html:property value="importedFile.getFilename()"/>
				<img id="fineImg" class="displayNo" src="images/fine.png"/>
				<img id="errorImg" class="displayNo" src="images/error.png">
			</div>				
			<div class="row">
				<label class="label"><html:text name="rdf.format"/></label>
				<div id="format" class="displayInline"></div>	
			</div>
			<div class="row">
				<label class="label"><html:text name="rdf.records"/></label>	
				<div id="recordNum" class="displayInline"></div>	
			</div>
			<div class="row">
				<label class="label"><html:text name="rdf.processed"/></label>
				<div id="processedNum" class="displayInline"></div>		
			</div>
			<div class="row">
				<label class="label"><html:text name="rdf.emitted"/></label>
				<div id="statementsNum" class="displayInline"></div>	
			</div>
			<div class="row">
				<label class="label"><html:text name="rdf.recordThroughput"/></label>
				<div id="processingThroughput" class="displayInline"></div>
				<html:text name="rdf.recordsSec"/>			
			</div>
			<div class="row">
				<label class="label"><html:text name="rdf.triplesThroughput"/></label>
				<div id="triplesThroughput" class="displayInline"></div>
				<html:text name="rdf.triplesSec"/>		
			</div>
			<div id="validationError" class="displayNo">
				<div class="row">
					<label class="label"><html:text name="rdf.validationMessage"/></label>	
					<div id="ValError" class="displayInline"></div>	
				</div>
			</div>
		</div>
		<div class="buttons row">
			<img id="progressBar" class="displayNo" src="images/progressBar.gif" alt="" />
		</div>
	</html:form>
</div>
<div id="submitButtons" class="buttons row">
	<html:form id="submitButtonsForm">
		<html:submit id="backButton" action="manage" cssClass="fleft submitButton button" key="back" />	
		<html:submit id="nextButton" disabled="true" action="linking" cssClass="fright submitButton button"
			key="next" />
	</html:form>
</div>





