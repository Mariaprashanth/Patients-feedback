<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FeedbackOP.aspx.cs" Inherits="Pages_Patient_FeedbackOP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>SN-OP Feedback</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <%--<link href="Pages/Patient/Rating/style.css" rel="stylesheet" />--%>

    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel='shortcut icon' type='image/x-icon' href='Rating/favicon.ico' />
    <%--<link href="Rating/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="/SNTO/App_Files/Master_CSS/bootstrap.min.css" rel="stylesheet" />
    <link href="Rating/BoxRatingCSS.css?VER=1.0" rel="stylesheet" />
    <script src="Rating/jquery.min.js?VER=1.0"></script>
    <script src="Rating/jquery-1.11.1.min.js?VER=1.0"></script>
    <script src="Rating/bootstrap.min.js?VER=1.0"></script>
    <script>
        //paste this code under head tag or in a seperate js file.
        // Wait for window load
        $(window).load(function () {
            // Animate loader off screen
            $(".se-pre-con").fadeOut("slow");
            $("#MasterCoverScreen").hide();
        });
    </script>
    <style>
        .card {
            /* Add shadows to create the "card" effect */
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            transition: 0.3s;
        }

        fieldset {
            border: 1px solid #CCA383;
            padding: 3px;
            font-size: 25px;
        }

            fieldset legend {
                padding: 6px;
                font-weight: bold;
            }

        .se-pre-con {
            position: fixed;
            left: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            z-index: 9999;
            background: url(/SNTO/App_Files/Master_CSS/Loader/Preloader_1.gif) center no-repeat #fff;
        }

        .MasterLockOn {
            display: block;
            visibility: visible;
            position: absolute;
            z-index: 999;
            top: 0px;
            left: 0px;
            width: 105%;
            height: 105%;
            background-color: white;
            vertical-align: bottom;
            padding-top: 20%;
            filter: alpha(opacity=75);
            opacity: 0.75;
            font-size: large;
            color: blue;
            font-style: italic;
            font-weight: 400;
            background-image: url(/SNTO/App_Files/Master_CSS/Loader/Preloader_1.gif);
            background-size: auto;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            overflow-x: hidden;
            overflow-Y: hidden;
        }

        @media screen and (min-width: 995px) {
            .ForPCLeft {
                text-align: left;
            }

            .ForPCRight {
                text-align: left;
                padding-left: 35%;
            }

            .ForPCRightNALabel {
                margin-top: 2%;
                text-align: right;
            }
        }

        .Common {
            font-weight: bold;
        }

        @media screen and (max-width: 994px) {
            .ForMobileLeft {
                text-align: left;
            }

            .ForMobileRight {
                text-align: right;
            }

            .ForMobileCenter {
                text-align: center;
            }
        }

        .useralertcss {
            margin-left: 5%;
            margin-right: 5%;
        }

        .QuestionHeading {
            font-size: 22px;
            font-weight: 800;
        }
    </style>

    <style>
      
.button-checkbox input[type="radio"] {
  display: none;
}


.button-checkbox label {
  display: inline-block;
  padding: 3px 4px; 
  margin: 5px;
  border: 2px solid #31708f; 
  background-color: #fff; 
  
  cursor: pointer;
  border-radius: 5px;
  transition: background-color 0.3s ease, color 0.3s ease;
}


.button-checkbox input[type="radio"]:checked + label {
  background-color: #337ab7; 
  color: #fff; 
}

.button-checkbox {
    /*width: 100%;*/ 
    font-size: 11px; 
   
} 

    </style>

</head>
<body class="container">
	<div class="se-pre-con"></div>
	<div id="MasterCoverScreen" class="MasterLockOn"></div>
	<form id="form1" runat="server">
		<div class="row" style="margin: 0%;">
			<div class="col-md-12 col-sm-12">
				<div class="row">
					<div class="row" style="margin-top: 3%;">
						<div class="col-sm-2" style="text-align: center;">
							<img src="/SNTO/App_Files/Master_Images/logoSN.jpg" style="width: 100px; height: 100px;" />
						</div>
						<div class="col-sm-8" style="text-align: center;">
							<div class="row">
								<h2>Sankara Nethralaya</h2>
							</div>
							<div class="row">
								<h4>Patient Feedback</h4>
							</div>
						</div>
						<div class="col-sm-2" style="text-align: center; font-weight:800;">
							<asp:Label ID="Label1" runat="server" Text="MRD NO :"></asp:Label><asp:Label ID="PATMRDNUM" runat="server" Text=""></asp:Label><br />
                            <asp:Label ID="PATNAME" runat="server" Text=""></asp:Label>
                            <br />
                            <asp:Label ID="PATAGE" runat="server" Text=""></asp:Label>
                            <br />
                            <asp:Label ID="PATGENDER" runat="server" Text=""></asp:Label>
						</div>
					</div>
					<hr id="MAINHRTAG" class="HRPC" />
					<div class="row" runat="server" id="Errordiv" style="text-align: center; font-size: 25px; font-weight: bold;">
						<asp:Label ID="Errorlabel" runat="server" Text=""></asp:Label>
					</div>
					<div class="row useralertcss" id="UserMsgDiv" style="display: none;">
						<br />
						<div class="alert alert-warning" id="waringinalert" runat="server">
							<strong>Warning! </strong>
							<asp:Label ID="warninglabel" runat="server"></asp:Label>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">


							<div id="Page0HomeMenu">

                                <div class="row">
                                    <div class="col-md-3 col-sm-12 ForMobileCenter">
                                        <h2 class="fs-title">Feedback</h2>
                                    </div>
                                    <div class="col-md-9 col-sm-12 ForMobileCenter ForPCRightNALabel">
                                        <p style="font-size: 22px; color: red;">If service is not availed please select - Not Availed</p>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq1" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading">Appointment Fixing Process</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P3Q1" Text="Appointment Fixing Process"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESAPPT10" value="10" />
                                                <label for="RATINGVALUESAPPT10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESAPPT9" value="9" />
                                                <label for="RATINGVALUESAPPT9">9</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESAPPT8" value="8" />
                                                <label for="RATINGVALUESAPPT8">8</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESAPPT7" value="7" />
                                                <label for="RATINGVALUESAPPT7">7</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESAPPT6" value="6" />
                                                <label for="RATINGVALUESAPPT6">6</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESAPPT5" value="5" />
                                                <label for="RATINGVALUESAPPT5">5</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESAPPT4" value="4" />
                                                <label for="RATINGVALUESAPPT4">4</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESAPPT3" value="3" />
                                                <label for="RATINGVALUESAPPT3">3</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESAPPT2" value="2" />
                                                <label for="RATINGVALUESAPPT2">2</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESAPPT1" value="1" />
                                                <label for="RATINGVALUESAPPT1">1</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESAPPT0" value="0" />
                                                <label for="RATINGVALUESAPPT0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESAPPT10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESAPPT0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq2" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading">Staff At Reception/Registration Desk</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P3Q2" Text="Staff At Reception/Registration Desk"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE3Q2" id="RATINGVALUESRECP10" value="10" />
                                                <label for="RATINGVALUESRECP10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE3Q2" id="RATINGVALUESRECP9" value="9" />
                                                <label for="RATINGVALUESRECP9">9</label>
                                                <input type="radio" name="PAGE3Q2" id="RATINGVALUESRECP8" value="8" />
                                                <label for="RATINGVALUESRECP8">8</label>
                                                <input type="radio" name="PAGE3Q2" id="RATINGVALUESRECP7" value="7" />
                                                <label for="RATINGVALUESRECP7">7</label>
                                                <input type="radio" name="PAGE3Q2" id="RATINGVALUESRECP6" value="6" />
                                                <label for="RATINGVALUESRECP6">6</label>
                                                <input type="radio" name="PAGE3Q2" id="RATINGVALUESRECP5" value="5" />
                                                <label for="RATINGVALUESRECP5">5</label>
                                                <input type="radio" name="PAGE3Q2" id="RATINGVALUESRECP4" value="4" />
                                                <label for="RATINGVALUESRECP4">4</label>
                                                <input type="radio" name="PAGE3Q2" id="RATINGVALUESRECP3" value="3" />
                                                <label for="RATINGVALUESRECP3">3</label>
                                                <input type="radio" name="PAGE3Q2" id="RATINGVALUESRECP2" value="2" />
                                                <label for="RATINGVALUESRECP2">2</label>
                                                <input type="radio" name="PAGE3Q2" id="RATINGVALUESRECP1" value="1" />
                                                <label for="RATINGVALUESRECP1">1</label>
                                                <input type="radio" name="PAGE3Q2" id="RATINGVALUESRECP0" value="0" />
                                                <label for="RATINGVALUESRECP0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESRECP10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESRECP0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq3" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading">Optometrist Evaluation</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P3Q3" Text="Optometrist Evaluation"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE3Q3" id="RATINGVALUESOPT10" value="10" />
                                                <label for="RATINGVALUESOPT10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE3Q3" id="RATINGVALUESOPT9" value="9" />
                                                <label for="RATINGVALUESOPT9">9</label>
                                                <input type="radio" name="PAGE3Q3" id="RATINGVALUESOPT8" value="8" />
                                                <label for="RATINGVALUESOPT8">8</label>
                                                <input type="radio" name="PAGE3Q3" id="RATINGVALUESOPT7" value="7" />
                                                <label for="RATINGVALUESOPT7">7</label>
                                                <input type="radio" name="PAGE3Q3" id="RATINGVALUESOPT6" value="6" />
                                                <label for="RATINGVALUESOPT6">6</label>
                                                <input type="radio" name="PAGE3Q3" id="RATINGVALUESOPT5" value="5" />
                                                <label for="RATINGVALUESOPT5">5</label>
                                                <input type="radio" name="PAGE3Q3" id="RATINGVALUESOPT4" value="4" />
                                                <label for="RATINGVALUESOPT4">4</label>
                                                <input type="radio" name="PAGE3Q3" id="RATINGVALUESOPT3" value="3" />
                                                <label for="RATINGVALUESOPT3">3</label>
                                                <input type="radio" name="PAGE3Q3" id="RATINGVALUESOPT2" value="2" />
                                                <label for="RATINGVALUESOPT2">2</label>
                                                <input type="radio" name="PAGE3Q3" id="RATINGVALUESOPT1" value="1" />
                                                <label for="RATINGVALUESOPT1">1</label>
                                                <input type="radio" name="PAGE3Q3" id="RATINGVALUESOPT0" value="0" />
                                                <label for="RATINGVALUESOPT0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESOPT10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESOPT0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq4" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading">Consultation Of Eye Doctor</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P3Q4" Text="Consultation Of Eye Doctor"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE3Q4" id="RATINGVALUESCOED10" value="10" />
                                                <label for="RATINGVALUESCOED10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE3Q4" id="RATINGVALUESCOED9" value="9" />
                                                <label for="RATINGVALUESCOED9">9</label>
                                                <input type="radio" name="PAGE3Q4" id="RATINGVALUESCOED8" value="8" />
                                                <label for="RATINGVALUESCOED8">8</label>
                                                <input type="radio" name="PAGE3Q4" id="RATINGVALUESCOED7" value="7" />
                                                <label for="RATINGVALUESCOED7">7</label>
                                                <input type="radio" name="PAGE3Q4" id="RATINGVALUESCOED6" value="6" />
                                                <label for="RATINGVALUESCOED6">6</label>
                                                <input type="radio" name="PAGE3Q4" id="RATINGVALUESCOED5" value="5" />
                                                <label for="RATINGVALUESCOED5">5</label>
                                                <input type="radio" name="PAGE3Q4" id="RATINGVALUESCOED4" value="4" />
                                                <label for="RATINGVALUESCOED4">4</label>
                                                <input type="radio" name="PAGE3Q4" id="RATINGVALUESCOED3" value="3" />
                                                <label for="RATINGVALUESCOED3">3</label>
                                                <input type="radio" name="PAGE3Q4" id="RATINGVALUESCOED2" value="2" />
                                                <label for="RATINGVALUESCOED2">2</label>
                                                <input type="radio" name="PAGE3Q4" id="RATINGVALUESCOED1" value="1" />
                                                <label for="RATINGVALUESCOED1">1</label>
                                                <input type="radio" name="PAGE3Q4" id="RATINGVALUESCOED0" value="0" />
                                                <label for="RATINGVALUESCOED0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESCOED10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESCOED0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq5" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <%-- QUESTION NEED TO ADD AREA --%>
                                                <%--	<span class="QuestionHeading">Surgery Fixing Centre</span>--%>
                                                <asp:Label runat="server" CssClass="QuestionHeading" ID="P3Q5" Text="Surgery Fixing Centre"></asp:Label>
                                            </div>
                                            <div class="col-md-6" style="text-align: center;">
                                                <div class="ratingNA">
                                                    <input type="checkbox" name="PAGE3Q5NA" id="RATINGVALUESSFCNA" value="NA" onclick="OnNACLICKSFC(this);" />
                                                    <label for="RATINGVALUESSFCNA" class="NACHANGE">Not Availed</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating" id="SFCRATING1TO10Radio">
                                                <input type="radio" name="PAGE3Q5" id="RATINGVALUESSFC10" value="10" />
                                                <label for="RATINGVALUESSFC10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE3Q5" id="RATINGVALUESSFC9" value="9" />
                                                <label for="RATINGVALUESSFC9">9</label>
                                                <input type="radio" name="PAGE3Q5" id="RATINGVALUESSFC8" value="8" />
                                                <label for="RATINGVALUESSFC8">8</label>
                                                <input type="radio" name="PAGE3Q5" id="RATINGVALUESSFC7" value="7" />
                                                <label for="RATINGVALUESSFC7">7</label>
                                                <input type="radio" name="PAGE3Q5" id="RATINGVALUESSFC6" value="6" />
                                                <label for="RATINGVALUESSFC6">6</label>
                                                <input type="radio" name="PAGE3Q5" id="RATINGVALUESSFC5" value="5" />
                                                <label for="RATINGVALUESSFC5">5</label>
                                                <input type="radio" name="PAGE3Q5" id="RATINGVALUESSFC4" value="4" />
                                                <label for="RATINGVALUESSFC4">4</label>
                                                <input type="radio" name="PAGE3Q5" id="RATINGVALUESSFC3" value="3" />
                                                <label for="RATINGVALUESSFC3">3</label>
                                                <input type="radio" name="PAGE3Q5" id="RATINGVALUESSFC2" value="2" />
                                                <label for="RATINGVALUESSFC2">2</label>
                                                <input type="radio" name="PAGE3Q5" id="RATINGVALUESSFC1" value="1" />
                                                <label for="RATINGVALUESSFC1">1</label>
                                                <input type="radio" name="PAGE3Q5" id="RATINGVALUESSFC0" value="0" />
                                                <label for="RATINGVALUESSFC0">0</label>
                                            </div>
                                            <div class="ratinglabel" id="SFCRATING1TO10Label">
                                                <label for="RATINGVALUESSFC10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESSFC0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq6" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <%-- QUESTION NEED TO ADD AREA --%>
                                                <%--<span class="QuestionHeading">Diagnostic Services</span>--%>
                                                <asp:Label runat="server" CssClass="QuestionHeading" ID="P3Q6" Text="Diagnostic Services"></asp:Label>
                                            </div>
                                            <div class="col-md-6" style="text-align: center;">
                                                <div class="ratingNA">
                                                    <input type="checkbox" name="PAGE3Q6NA" id="RATINGVALUESDISNA" value="NA" onclick="OnNACLICKDIS(this);" />
                                                    <label for="RATINGVALUESDISNA" class="NACHANGE">Not Availed</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating" id="DISRATING1TO10Radio">
                                                <input type="radio" name="PAGE3Q6" id="RATINGVALUESDIS10" value="10" />
                                                <label for="RATINGVALUESDIS10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE3Q6" id="RATINGVALUESDIS9" value="9" />
                                                <label for="RATINGVALUESDIS9">9</label>
                                                <input type="radio" name="PAGE3Q6" id="RATINGVALUESDIS8" value="8" />
                                                <label for="RATINGVALUESDIS8">8</label>
                                                <input type="radio" name="PAGE3Q6" id="RATINGVALUESDIS7" value="7" />
                                                <label for="RATINGVALUESDIS7">7</label>
                                                <input type="radio" name="PAGE3Q6" id="RATINGVALUESDIS6" value="6" />
                                                <label for="RATINGVALUESDIS6">6</label>
                                                <input type="radio" name="PAGE3Q6" id="RATINGVALUESDIS5" value="5" />
                                                <label for="RATINGVALUESDIS5">5</label>
                                                <input type="radio" name="PAGE3Q6" id="RATINGVALUESDIS4" value="4" />
                                                <label for="RATINGVALUESDIS4">4</label>
                                                <input type="radio" name="PAGE3Q6" id="RATINGVALUESDIS3" value="3" />
                                                <label for="RATINGVALUESDIS3">3</label>
                                                <input type="radio" name="PAGE3Q6" id="RATINGVALUESDIS2" value="2" />
                                                <label for="RATINGVALUESDIS2">2</label>
                                                <input type="radio" name="PAGE3Q6" id="RATINGVALUESDIS1" value="1" />
                                                <label for="RATINGVALUESDIS1">1</label>
                                                <input type="radio" name="PAGE3Q6" id="RATINGVALUESDIS0" value="0" />
                                                <label for="RATINGVALUESDIS0">0</label>
                                            </div>
                                            <div class="ratinglabel" id="DISRATING1TO10Label">
                                                <label for="RATINGVALUESDIS10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESDIS0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq7" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <%-- QUESTION NEED TO ADD AREA --%>
                                                <%--<span class="QuestionHeading">Optical Shop</span>--%>
                                                <asp:Label runat="server" CssClass="QuestionHeading" ID="P3Q7" Text="Optical Shop"></asp:Label>
                                            </div>
                                            <div class="col-md-6" style="text-align: center;">
                                                <div class="ratingNA">
                                                    <input type="checkbox" name="PAGE3Q7NA" id="RATINGVALUESOPSNA" value="NA" onclick="OnNACLICKOPS(this);" />
                                                    <label for="RATINGVALUESOPSNA" class="NACHANGE">Not Availed</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating" id="OPSRATING1TO10Radio">
                                                <input type="radio" name="PAGE3Q7" id="RATINGVALUESOPS10" value="10" />
                                                <label for="RATINGVALUESOPS10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE3Q7" id="RATINGVALUESOPS9" value="9" />
                                                <label for="RATINGVALUESOPS9">9</label>
                                                <input type="radio" name="PAGE3Q7" id="RATINGVALUESOPS8" value="8" />
                                                <label for="RATINGVALUESOPS8">8</label>
                                                <input type="radio" name="PAGE3Q7" id="RATINGVALUESOPS7" value="7" />
                                                <label for="RATINGVALUESOPS7">7</label>
                                                <input type="radio" name="PAGE3Q7" id="RATINGVALUESOPS6" value="6" />
                                                <label for="RATINGVALUESOPS6">6</label>
                                                <input type="radio" name="PAGE3Q7" id="RATINGVALUESOPS5" value="5" />
                                                <label for="RATINGVALUESOPS5">5</label>
                                                <input type="radio" name="PAGE3Q7" id="RATINGVALUESOPS4" value="4" />
                                                <label for="RATINGVALUESOPS4">4</label>
                                                <input type="radio" name="PAGE3Q7" id="RATINGVALUESOPS3" value="3" />
                                                <label for="RATINGVALUESOPS3">3</label>
                                                <input type="radio" name="PAGE3Q7" id="RATINGVALUESOPS2" value="2" />
                                                <label for="RATINGVALUESOPS2">2</label>
                                                <input type="radio" name="PAGE3Q7" id="RATINGVALUESOPS1" value="1" />
                                                <label for="RATINGVALUESOPS1">1</label>
                                                <input type="radio" name="PAGE3Q7" id="RATINGVALUESOPS0" value="0" />
                                                <label for="RATINGVALUESOPS0">0</label>
                                            </div>
                                            <div class="ratinglabel" id="OPSRATING1TO10Label">
                                                <label for="RATINGVALUESOPS0" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESOPS10">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
								
								<div class="row" style="text-align: center; justify-content: center; margin-top: 2%; margin-bottom: 2%">
									<input type="button" class="btn btn-success" value="Proceed" onclick="ToPage1();" />
								</div>
							</div>




							<div id="Page1" style="display: none;">
								<div class="row">
                                    <div class="col-md-3 col-sm-12 ForMobileCenter">
                                        <h2 class="fs-title">Feedback</h2>
                                    </div>
                                    <div class="col-md-9 col-sm-12 ForMobileCenter ForPCRightNALabel">
                                        <p style="font-size: 22px; color: red;">If service is not availed please select - Not Availed</p>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq8" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <%-- QUESTION NEED TO ADD AREA --%>
                                                <%--<span class="QuestionHeading">Pharmacy</span>--%>
                                                <asp:Label runat="server" CssClass="QuestionHeading" ID="P4Q1" Text="Pharmacy"></asp:Label>
                                            </div>
                                            <div class="col-md-6" style="text-align: center;">
                                                <div class="ratingNA">
                                                    <input type="checkbox" name="PAGE4Q1NA" id="RATINGVALUESPHANA" value="NA" onclick="OnNACLICKPHA(this);" />
                                                    <label for="RATINGVALUESPHANA" class="NACHANGE">Not Availed</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating" id="PHARATING1TO10Radio">
                                                <input type="radio" name="PAGE4Q1" id="RATINGVALUESPHA10" value="10" />
                                                <label for="RATINGVALUESPHA10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE4Q1" id="RATINGVALUESPHA9" value="9" />
                                                <label for="RATINGVALUESPHA9">9</label>
                                                <input type="radio" name="PAGE4Q1" id="RATINGVALUESPHA8" value="8" />
                                                <label for="RATINGVALUESPHA8">8</label>
                                                <input type="radio" name="PAGE4Q1" id="RATINGVALUESPHA7" value="7" />
                                                <label for="RATINGVALUESPHA7">7</label>
                                                <input type="radio" name="PAGE4Q1" id="RATINGVALUESPHA6" value="6" />
                                                <label for="RATINGVALUESPHA6">6</label>
                                                <input type="radio" name="PAGE4Q1" id="RATINGVALUESPHA5" value="5" />
                                                <label for="RATINGVALUESPHA5">5</label>
                                                <input type="radio" name="PAGE4Q1" id="RATINGVALUESPHA4" value="4" />
                                                <label for="RATINGVALUESPHA4">4</label>
                                                <input type="radio" name="PAGE4Q1" id="RATINGVALUESPHA3" value="3" />
                                                <label for="RATINGVALUESPHA3">3</label>
                                                <input type="radio" name="PAGE4Q1" id="RATINGVALUESPHA2" value="2" />
                                                <label for="RATINGVALUESPHA2">2</label>
                                                <input type="radio" name="PAGE4Q1" id="RATINGVALUESPHA1" value="1" />
                                                <label for="RATINGVALUESPHA1">1</label>
                                                <input type="radio" name="PAGE4Q1" id="RATINGVALUESPHA0" value="0" />
                                                <label for="RATINGVALUESPHA0">0</label>
                                            </div>
                                            <div class="ratinglabel" id="PHARATING1TO10Label">
                                                <label for="RATINGVALUESPHA10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESPHA0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq9" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <%-- QUESTION NEED TO ADD AREA --%>
                                                <%--<span class="QuestionHeading">Laboratory</span>--%>
                                                <asp:Label runat="server" CssClass="QuestionHeading" ID="P4Q2" Text="Laboratory"></asp:Label>
                                            </div>
                                            <div class="col-md-6" style="text-align: center;">
                                                <div class="ratingNA">
                                                    <input type="checkbox" name="PAGE4Q2NA" id="RATINGVALUESLABNA" value="NA" onclick="OnNACLICKLAB(this);" />
                                                    <label for="RATINGVALUESLABNA" class="NACHANGE">Not Availed</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating" id="LABRATING1TO10Radio">
                                                <input type="radio" name="PAGE4Q2" id="RATINGVALUESLAB10" value="10" />
                                                <label for="RATINGVALUESLAB10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE4Q2" id="RATINGVALUESLAB9" value="9" />
                                                <label for="RATINGVALUESLAB9">9</label>
                                                <input type="radio" name="PAGE4Q2" id="RATINGVALUESLAB8" value="8" />
                                                <label for="RATINGVALUESLAB8">8</label>
                                                <input type="radio" name="PAGE4Q2" id="RATINGVALUESLAB7" value="7" />
                                                <label for="RATINGVALUESLAB7">7</label>
                                                <input type="radio" name="PAGE4Q2" id="RATINGVALUESLAB6" value="6" />
                                                <label for="RATINGVALUESLAB6">6</label>
                                                <input type="radio" name="PAGE4Q2" id="RATINGVALUESLAB5" value="5" />
                                                <label for="RATINGVALUESLAB5">5</label>
                                                <input type="radio" name="PAGE4Q2" id="RATINGVALUESLAB4" value="4" />
                                                <label for="RATINGVALUESLAB4">4</label>
                                                <input type="radio" name="PAGE4Q2" id="RATINGVALUESLAB3" value="3" />
                                                <label for="RATINGVALUESLAB3">3</label>
                                                <input type="radio" name="PAGE4Q2" id="RATINGVALUESLAB2" value="2" />
                                                <label for="RATINGVALUESLAB2">2</label>
                                                <input type="radio" name="PAGE4Q2" id="RATINGVALUESLAB1" value="1" />
                                                <label for="RATINGVALUESLAB1">1</label>
                                                <input type="radio" name="PAGE4Q2" id="RATINGVALUESLAB0" value="0" />
                                                <label for="RATINGVALUESLAB0">0</label>
                                            </div>
                                            <div class="ratinglabel" id="LABRATING1TO10Label">
                                                <label for="RATINGVALUESLAB10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESLAB0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq10" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <%-- QUESTION NEED TO ADD AREA --%>
                                                <%--<span class="QuestionHeading">Canteen</span>--%>
                                                <asp:Label runat="server" CssClass="QuestionHeading" ID="P4Q3" Text="Canteen/Cafeteria"></asp:Label>
                                            </div>
                                            <div class="col-md-6" style="text-align: center;">
                                                <div class="ratingNA">
                                                    <input type="checkbox" name="PAGE4Q3NA" id="RATINGVALUESCANNA" value="NA" onclick="OnNACLICKCAN(this);" />
                                                    <label for="RATINGVALUESCANNA" class="NACHANGE">Not Availed</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating" id="CANRATING1TO10Radio">
                                                <input type="radio" name="PAGE4Q3" id="RATINGVALUESCAN10" value="10" />
                                                <label for="RATINGVALUESCAN10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE4Q3" id="RATINGVALUESCAN9" value="9" />
                                                <label for="RATINGVALUESCAN9">9</label>
                                                <input type="radio" name="PAGE4Q3" id="RATINGVALUESCAN8" value="8" />
                                                <label for="RATINGVALUESCAN8">8</label>
                                                <input type="radio" name="PAGE4Q3" id="RATINGVALUESCAN7" value="7" />
                                                <label for="RATINGVALUESCAN7">7</label>
                                                <input type="radio" name="PAGE4Q3" id="RATINGVALUESCAN6" value="6" />
                                                <label for="RATINGVALUESCAN6">6</label>
                                                <input type="radio" name="PAGE4Q3" id="RATINGVALUESCAN5" value="5" />
                                                <label for="RATINGVALUESCAN5">5</label>
                                                <input type="radio" name="PAGE4Q3" id="RATINGVALUESCAN4" value="4" />
                                                <label for="RATINGVALUESCAN4">4</label>
                                                <input type="radio" name="PAGE4Q3" id="RATINGVALUESCAN3" value="3" />
                                                <label for="RATINGVALUESCAN3">3</label>
                                                <input type="radio" name="PAGE4Q3" id="RATINGVALUESCAN2" value="2" />
                                                <label for="RATINGVALUESCAN2">2</label>
                                                <input type="radio" name="PAGE4Q3" id="RATINGVALUESCAN1" value="1" />
                                                <label for="RATINGVALUESCAN1">1</label>
                                                <input type="radio" name="PAGE4Q3" id="RATINGVALUESCAN0" value="0" />
                                                <label for="RATINGVALUESCAN0">0</label>

                                            </div>
                                            <div class="ratinglabel" id="CANRATING1TO10Label">
                                                <label for="RATINGVALUESCAN10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESCAN0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq11" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading">Display/Direction Boards</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P4Q4" Text="Display/Direction Boards"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE4Q4" id="RATINGVALUESDDB10" value="10" />
                                                <label for="RATINGVALUESDDB10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE4Q4" id="RATINGVALUESDDB9" value="9" />
                                                <label for="RATINGVALUESDDB9">9</label>
                                                <input type="radio" name="PAGE4Q4" id="RATINGVALUESDDB8" value="8" />
                                                <label for="RATINGVALUESDDB8">8</label>
                                                <input type="radio" name="PAGE4Q4" id="RATINGVALUESDDB7" value="7" />
                                                <label for="RATINGVALUESDDB7">7</label>
                                                <input type="radio" name="PAGE4Q4" id="RATINGVALUESDDB6" value="6" />
                                                <label for="RATINGVALUESDDB6">6</label>
                                                <input type="radio" name="PAGE4Q4" id="RATINGVALUESDDB5" value="5" />
                                                <label for="RATINGVALUESDDB5">5</label>
                                                <input type="radio" name="PAGE4Q4" id="RATINGVALUESDDB4" value="4" />
                                                <label for="RATINGVALUESDDB4">4</label>
                                                <input type="radio" name="PAGE4Q4" id="RATINGVALUESDDB3" value="3" />
                                                <label for="RATINGVALUESDDB3">3</label>
                                                <input type="radio" name="PAGE4Q4" id="RATINGVALUESDDB2" value="2" />
                                                <label for="RATINGVALUESDDB2">2</label>
                                                <input type="radio" name="PAGE4Q4" id="RATINGVALUESDDB1" value="1" />
                                                <label for="RATINGVALUESDDB1">1</label>
                                                <input type="radio" name="PAGE4Q4" id="RATINGVALUESDDB0" value="0" />
                                                <label for="RATINGVALUESDDB0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESDDB10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESDDB0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq12" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading">Overall Cleanliness</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P4Q5" Text="Overall Cleanliness"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE4Q5" id="RATINGVALUESOVC10" value="10" />
                                                <label for="RATINGVALUESOVC10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE4Q5" id="RATINGVALUESOVC9" value="9" />
                                                <label for="RATINGVALUESOVC9">9</label>
                                                <input type="radio" name="PAGE4Q5" id="RATINGVALUESOVC8" value="8" />
                                                <label for="RATINGVALUESOVC8">8</label>
                                                <input type="radio" name="PAGE4Q5" id="RATINGVALUESOVC7" value="7" />
                                                <label for="RATINGVALUESOVC7">7</label>
                                                <input type="radio" name="PAGE4Q5" id="RATINGVALUESOVC6" value="6" />
                                                <label for="RATINGVALUESOVC6">6</label>
                                                <input type="radio" name="PAGE4Q5" id="RATINGVALUESOVC5" value="5" />
                                                <label for="RATINGVALUESOVC5">5</label>
                                                <input type="radio" name="PAGE4Q5" id="RATINGVALUESOVC4" value="4" />
                                                <label for="RATINGVALUESOVC4">4</label>
                                                <input type="radio" name="PAGE4Q5" id="RATINGVALUESOVC3" value="3" />
                                                <label for="RATINGVALUESOVC3">3</label>
                                                <input type="radio" name="PAGE4Q5" id="RATINGVALUESOVC2" value="2" />
                                                <label for="RATINGVALUESOVC2">2</label>
                                                <input type="radio" name="PAGE4Q5" id="RATINGVALUESOVC1" value="1" />
                                                <label for="RATINGVALUESOVC1">1</label>
                                                <input type="radio" name="PAGE4Q5" id="RATINGVALUESOVC0" value="0" />
                                                <label for="RATINGVALUESOVC0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESOVC10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESOVC0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq13" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading">Overall Rating Of Sankara Nethralaya</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P4Q6" Text="Overall Rating Of Sankara Nethralaya"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE4Q6" id="RATINGVALUESOVLL10" value="10" />
                                                <label for="RATINGVALUESOVLL10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE4Q6" id="RATINGVALUESOVLL9" value="9" />
                                                <label for="RATINGVALUESOVLL9">9</label>
                                                <input type="radio" name="PAGE4Q6" id="RATINGVALUESOVLL8" value="8" />
                                                <label for="RATINGVALUESOVLL8">8</label>
                                                <input type="radio" name="PAGE4Q6" id="RATINGVALUESOVLL7" value="7" />
                                                <label for="RATINGVALUESOVLL7">7</label>
                                                <input type="radio" name="PAGE4Q6" id="RATINGVALUESOVLL6" value="6" />
                                                <label for="RATINGVALUESOVLL6">6</label>
                                                <input type="radio" name="PAGE4Q6" id="RATINGVALUESOVLL5" value="5" />
                                                <label for="RATINGVALUESOVLL5">5</label>
                                                <input type="radio" name="PAGE4Q6" id="RATINGVALUESOVLL4" value="4" />
                                                <label for="RATINGVALUESOVLL4">4</label>
                                                <input type="radio" name="PAGE4Q6" id="RATINGVALUESOVLL3" value="3" />
                                                <label for="RATINGVALUESOVLL3">3</label>
                                                <input type="radio" name="PAGE4Q6" id="RATINGVALUESOVLL2" value="2" />
                                                <label for="RATINGVALUESOVLL2">2</label>
                                                <input type="radio" name="PAGE4Q6" id="RATINGVALUESOVLL1" value="1" />
                                                <label for="RATINGVALUESOVLL1">1</label>
                                                <input type="radio" name="PAGE4Q6" id="RATINGVALUESOVLL0" value="0" />
                                                <label for="RATINGVALUESOVLL0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESOVLL10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESOVLL0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading">Total Time Spent In Our Hospital For The Consultation And Treatment Process </span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P4Q7" Text="Total Time Spent In Our Hospital For The Consultation And Treatment Process"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                           <%-- <select class="form-control" id="hourselect" runat="server" name="hourchoose">
                                                <option value="" selected="selected">Select</option>
                                                <option value="1 Hour">1 Hour</option>
                                                <option value="2 Hour">2 Hour</option>
                                                <option value="3 Hour">3 Hour</option>
                                                <option value="4 Hour">4 Hour</option>
                                                <option value=">4 Hour">>4 Hour</option>
                                            </select>--%>
                                                  <asp:RadioButtonList ID="hourselect" runat="server" RepeatDirection="Horizontal" class="button-checkbox CssClass">
                                                        <asp:ListItem Value="1 Hour" >1 Hour</asp:ListItem>
                                                        <asp:ListItem Value="2 Hour" >2 Hour</asp:ListItem>
                                                       <asp:ListItem Value="3 Hour" >3 Hour</asp:ListItem>
                                                       <asp:ListItem Value="4 Hour" >4 Hour</asp:ListItem>
                                                       <asp:ListItem Value=">4 Hour" >>4 Hour</asp:ListItem>
                                                   </asp:RadioButtonList>
                                        </div>
                                    </div>
                                </div>
								<div class="row" style="text-align: center; justify-content: center; margin-top: 2%; margin-bottom: 2%">
									<input type="button" class="btn btn-info" value="Previous" onclick="HomeMenu();" />
									<input type="button" value="Next" class="btn btn-success" onclick="Page1ChecktoPage2();" />
								</div>
							</div>



							<div id="Page2" style="display: none;">

                                 <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading" id="FBQ1">Reason For Choosing Our Hospital? </span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P2Q1" Text="Reason For Choosing Our Hospital?"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                       <%-- <div class="row" style="margin: 0%;">
                                            <select class="form-control" id="RFORHVDDL" runat="server" name="reasonchoose">
                                                <option value="" selected="selected">Select</option>
                                                <option value="Referred By Doctor">Referred By Doctor</option>
                                                <option value="Word Of Mouth">Word Of Mouth</option>
                                                <option value="Old Patient">Old Patient</option>
                                                <option value="Social Media">Social Media</option>
                                                <option value="Closer To My House">Closer To My House</option>
                                            </select>
                                        </div>--%>
                                           <asp:RadioButtonList ID="RFORHVDDL" runat="server" RepeatDirection="Horizontal" class="button-checkbox CssClass">
                                                <asp:ListItem Value="Referred By Doctor" >Referred By Doctor</asp:ListItem>
                                                <asp:ListItem Value="Word Of Mouth" >Word Of Mouth</asp:ListItem>
                                                <asp:ListItem Value="Old Patient" >Old Patient</asp:ListItem>
                                                <asp:ListItem Value="Social Media" >Social Media</asp:ListItem>
                                                <asp:ListItem Value="Closer To My House" >Closer To My House</asp:ListItem>
                                            </asp:RadioButtonList>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--	<span class="QuestionHeading">Appointment Fixed Through </span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P2Q2" Text="Appointment Fixed Through"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                           <%-- <select class="form-control" id="AFTDDL" runat="server" name="reasonchoose">
                                                <option value="" selected="selected">Select</option>
                                                <option value="Walk-In">Walk-In</option>
                                                <option value="Telephone">Telephone</option>
                                                <option value="Website">Website</option>
                                                <option value="Email">Email</option>
                                            </select>--%>

                                                   <asp:RadioButtonList ID="AFTDDL" runat="server" RepeatDirection="Horizontal" class="button-checkbox CssClass">
                                                        <asp:ListItem Value="Walk-In" >Walk-In</asp:ListItem>
                                                        <asp:ListItem Value="Telephone" >Telephone</asp:ListItem>
                                                        <asp:ListItem Value="Website" >Website</asp:ListItem>
                                                        <asp:ListItem Value="Social Media" >Social Media</asp:ListItem>
                                                        <asp:ListItem Value="Email" >Email</asp:ListItem>
                                                    </asp:RadioButtonList>
                                        </div>
                                    </div>
                                </div>


                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading">Will You Recommend Our Hospital To Others? </span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P5Q1" Text="Will You Recommend Our Hospital To Others?"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                           <%-- <select class="form-control" runat="server" id="Recommed" name="recommedchoose">
                                                <option value="" selected="selected">-- SELECT--</option>
                                                <option value="Yes">Yes</option>
                                                <option value="No">No</option>
                                            </select>--%>

                                                 <asp:RadioButtonList ID="Recommed" runat="server" RepeatDirection="Horizontal" class="button-checkbox CssClass">
                                                    <asp:ListItem Value="Yes" >Yes</asp:ListItem>
                                                    <asp:ListItem Value="No" >No</asp:ListItem>
                                                </asp:RadioButtonList>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading">Appreciation If Any </span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P5Q2" Text="Appreciation If Any"></asp:Label>
                                        <span style="font-size: 12px;">(Maximum characters: 2000)<br />
                                            You have
                                            <input readonly type="text" id="countdownapp" name="countdownapp" size="4" value="2000">
                                            characters left.</span>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            ​<textarea id="txtappreciation" class="form-control" runat="server" onkeyup="limitTextApp(this,2000);this.value=this.value.replace(/[^a-zA-Z,.,,,:, ]/g,'');"
                                                onkeydown="limitTextApp(this,2000);" rows="2" cols="70"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span class="QuestionHeading">Leave Your Valuable Suggestion For Our Improvement To Serve You Better: </span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P5Q3" Text="Leave Your Valuable Suggestion For Our Improvement To Serve You Better:"></asp:Label>
                                        <span style="font-size: 12px;">(Maximum characters: 2000)<br />
                                            You have
                                            <input readonly type="text" id="countdown" name="countdown" size="4" value="2000">
                                            characters left.</span>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <textarea id="txtsuggestion" class="form-control" onkeyup="limitText(this,2000);this.value=this.value.replace(/[^a-zA-Z,.,,,:, ]/g,'');"
                                                onkeydown="limitText(this,2000);" runat="server" rows="2" cols="70"></textarea>
                                        </div>
                                    </div>
                                </div>
								
								<div class="row" style="text-align: center; justify-content: center; margin-top: 2%; margin-bottom: 2%;">
									<input type="button" class="btn btn-info" value="Previous" onclick="Page2ChecktoPage1();" />
									<input type="button" value="Save" class="btn btn-success" onclick="Page2ChecktoPage3();" />
                                    <asp:Button ID="Save" runat="server" class="btn btn-success pull-left" type="submit" Text="Save" OnClick="Save_Click" Style="display: none;" />
								</div>
							</div>


							<div id="Page3" style="display: none;">

								
								<div class="row" style="text-align: center; justify-content: center; margin-top: 2%; margin-bottom: 2%;">
									<input type="button" class="btn btn-info" value="Previous" onclick="Page3ChecktoPage2();" />
									<input type="button" value="Next" class="btn btn-success" onclick="Page3ChecktoPage4();" />
								</div>
							</div>


							<div id="Page4" style="display: none;">
								
								<div class="row" style="text-align: center; justify-content: center; margin-top: 2%; margin-bottom: 2%;">
									<input type="button" class="btn btn-info" value="Previous" onclick="Page4ChecktoPage3();" />
									<input type="button" value="Save" class="btn btn-success" onclick="Page4ChecktoSaveMode();" />
									
								</div>
							</div>




							<div id="Page5" style="display: none;">
								<div class="row" style="margin: 0%;">
									<h2 class="fs-title text-center">Success !</h2>
									<br />
									<br />
									<div class="row justify-content-center">
										<div style="text-align: center;">
											<%--<img src="/SNTO/Pages/Patient/Rating/images.png" />--%>
											<img id="imggif" src="/SNTO/App_Files/Master_Images/success-alert.gif" style="width: 332px; height: 267px;" />
										</div>
									</div>
									<br />
									<br />
									<div class="row justify-content-center">
										<div class="col-7 text-center">
											<h6>Your Feedback Has been Received </h6>
											<h5>Thank you</h5>
										</div>
									</div>
								</div>
							</div>
							<div id="Page6" style="display: none;">
								<div class="row" style="margin: 0%;">
									<h2 class="fs-title text-center">You have Completed your Feedback Already !</h2>
									<br />
									<br />
									<div class="row justify-content-center">
										<div style="text-align: center;">
											<img src="/SNTO/App_Files/Master_Images/loading2done.gif" style="width: 332px; height: 267px;" />
										</div>
									</div>
									<br />
									<br />
									<div class="row justify-content-center">
										<div class="col-7 text-center">
											<%--<h6>You have Already Submitted your Feedback</h6>--%>
											<br />
											<h4>Thank you</h4>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<asp:HiddenField ID="HNDOPP2Q1" runat="server" />
						<asp:HiddenField ID="HNDOPP2Q2" runat="server" />
						<asp:HiddenField ID="HNDOPP3Q1" runat="server" />
						<asp:HiddenField ID="HNDOPP3Q2" runat="server" />
						<asp:HiddenField ID="HNDOPP3Q3" runat="server" />
						<asp:HiddenField ID="HNDOPP3Q4" runat="server" />
						<asp:HiddenField ID="HNDOPP3Q5" runat="server" />
						<asp:HiddenField ID="HNDOPP3Q6" runat="server" />
						<asp:HiddenField ID="HNDOPP3Q7" runat="server" />
						<asp:HiddenField ID="HNDOPP4Q1" runat="server" />
						<asp:HiddenField ID="HNDOPP4Q2" runat="server" />
						<asp:HiddenField ID="HNDOPP4Q3" runat="server" />
						<asp:HiddenField ID="HNDOPP4Q4" runat="server" />
						<asp:HiddenField ID="HNDOPP4Q5" runat="server" />
						<asp:HiddenField ID="HNDOPP4Q6" runat="server" />
						<asp:HiddenField ID="HNDOPP4Q7" runat="server" />
						<asp:HiddenField ID="HNDOPP5Q1" runat="server" />
						<asp:HiddenField ID="HNDOPP5Q2" runat="server" />
						<asp:HiddenField ID="HNDOPP5Q3" runat="server" />
						<asp:HiddenField ID="HNDPATAPPTID" runat="server" />
					</div>
					<%-- Backup Code for box with NA and 0 to 10 rating and 0 to 10 rating --%>
					<%--<div class="row" style="margin: 0%;">
                    <div class="rating">
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES10" value="10" />
                        <label for="RATINGVALUES10" class="bordercheck"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES9" value="9" />
                        <label for="RATINGVALUES9"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES8" value="8" />
                        <label for="RATINGVALUES8"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES7" value="7" />
                        <label for="RATINGVALUES7"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES6" value="6" />
                        <label for="RATINGVALUES6"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES5" value="5" />
                        <label for="RATINGVALUES5"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES4" value="4" />
                        <label for="RATINGVALUES4"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES3" value="3" />
                        <label for="RATINGVALUES3"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES2" value="2" />
                        <label for="RATINGVALUES2"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES1" value="1" />
                        <label for="RATINGVALUES1"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES0" value="0" />
                        <label for="RATINGVALUES0"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUESNA" value="NA" />
                        <label for="RATINGVALUESNA" class="NACHANGE"></label>
                    </div>
                </div>
                <div class="row" style="margin: 0%;">
                    <div class="rating">
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES10" value="10" />
                        <label for="RATINGVALUES10" class="bordercheck"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES9" value="9" />
                        <label for="RATINGVALUES9"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES8" value="8" />
                        <label for="RATINGVALUES8"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES7" value="7" />
                        <label for="RATINGVALUES7"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES6" value="6" />
                        <label for="RATINGVALUES6"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES5" value="5" />
                        <label for="RATINGVALUES5"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES4" value="4" />
                        <label for="RATINGVALUES4"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES3" value="3" />
                        <label for="RATINGVALUES3"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES2" value="2" />
                        <label for="RATINGVALUES2"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES1" value="1" />
                        <label for="RATINGVALUES1"></label>
                        <input type="radio" name="RATINGVALUES" id="RATINGVALUES0" value="0" />
                        <label for="RATINGVALUES0"></label>
                    </div>
                </div>--%>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			function LoadPatPageDtls(InputDtls) {
				if (InputDtls === "Completed") {
					document.getElementById("Page0HomeMenu").style.display = "none";
					document.getElementById("Page1").style.display = "none";
					document.getElementById("Page2").style.display = "none";
					document.getElementById("Page3").style.display = "none";
					document.getElementById("Page4").style.display = "none";
					document.getElementById("Page5").style.display = "block";
					document.getElementById("Page6").style.display = "none";
					document.getElementById("UserMsgDiv").style.display = "none";
					document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
					$("#MasterCoverScreen").hide();
				}
				else if (InputDtls === "AllreadyCompleted") {
					document.getElementById("Page0HomeMenu").style.display = "none";
					document.getElementById("Page1").style.display = "none";
					document.getElementById("Page2").style.display = "none";
					document.getElementById("Page3").style.display = "none";
					document.getElementById("Page4").style.display = "none";
					document.getElementById("Page5").style.display = "none";
					document.getElementById("Page6").style.display = "block";
					document.getElementById("UserMsgDiv").style.display = "none";
					document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
					$("#MasterCoverScreen").hide();
				}
				else if (InputDtls === "NeedtoComplete") {
					document.getElementById("Page0HomeMenu").style.display = "block";
					document.getElementById("Page1").style.display = "none";
					document.getElementById("Page2").style.display = "none";
					document.getElementById("Page3").style.display = "none";
					document.getElementById("Page4").style.display = "none";
					document.getElementById("Page5").style.display = "none";
					document.getElementById("Page6").style.display = "none";
					document.getElementById("UserMsgDiv").style.display = "none";
					document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
					$("#MasterCoverScreen").hide();

					//setTimeout(ToPage1, 5000);
				}
				else if (InputDtls === "ErrorMsg") {
					document.getElementById("Page0HomeMenu").style.display = "none";
					document.getElementById("Page1").style.display = "none";
					document.getElementById("Page2").style.display = "none";
					document.getElementById("Page3").style.display = "none";
					document.getElementById("Page4").style.display = "none";
					document.getElementById("Page5").style.display = "none";
					document.getElementById("Page6").style.display = "none";
					document.getElementById("UserMsgDiv").style.display = "block";
					document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "please check the URL or link expired";
					$("#MasterCoverScreen").hide();
				}
				else {
					document.getElementById("Page0HomeMenu").style.display = "none";
					document.getElementById("Page1").style.display = "none";
					document.getElementById("Page2").style.display = "none";
					document.getElementById("Page3").style.display = "none";
					document.getElementById("Page4").style.display = "none";
					document.getElementById("Page5").style.display = "none";
					document.getElementById("Page6").style.display = "none";
					document.getElementById("UserMsgDiv").style.display = "block";
					document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "please check the URL or link expired";
					$("#MasterCoverScreen").hide();
				}
			}
			function ToPage1() {
				var DatadtlsofSelectedPAGE3Q1 = document.getElementsByName("PAGE3Q1");
                var DatadtlsofSelectedPAGE3Q2 = document.getElementsByName("PAGE3Q2");
                var DatadtlsofSelectedPAGE3Q3 = document.getElementsByName("PAGE3Q3");
                var DatadtlsofSelectedPAGE3Q4 = document.getElementsByName("PAGE3Q4");
                var DatadtlsofSelectedPAGE3Q5 = document.getElementsByName("PAGE3Q5");
                var DatadtlsofSelectedPAGE3Q6 = document.getElementsByName("PAGE3Q6");
                var DatadtlsofSelectedPAGE3Q7 = document.getElementsByName("PAGE3Q7");
                var DataofSelectedPAGE3Q1 = "";
                var DataofSelectedPAGE3Q2 = "";
                var DataofSelectedPAGE3Q3 = "";
                var DataofSelectedPAGE3Q4 = "";
                var DataofSelectedPAGE3Q5 = "";
                var DataofSelectedPAGE3Q6 = "";
                var DataofSelectedPAGE3Q7 = "";
                for (var i = 0; i < DatadtlsofSelectedPAGE3Q1.length; i++) {
                    if (DatadtlsofSelectedPAGE3Q1[i].checked) {
                        DataofSelectedPAGE3Q1 = DatadtlsofSelectedPAGE3Q1[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE3Q2.length; i++) {
                    if (DatadtlsofSelectedPAGE3Q2[i].checked) {
                        DataofSelectedPAGE3Q2 = DatadtlsofSelectedPAGE3Q2[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE3Q3.length; i++) {
                    if (DatadtlsofSelectedPAGE3Q3[i].checked) {
                        DataofSelectedPAGE3Q3 = DatadtlsofSelectedPAGE3Q3[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE3Q4.length; i++) {
                    if (DatadtlsofSelectedPAGE3Q4[i].checked) {
                        DataofSelectedPAGE3Q4 = DatadtlsofSelectedPAGE3Q4[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE3Q5.length; i++) {
                    if (DatadtlsofSelectedPAGE3Q5[i].checked) {
                        DataofSelectedPAGE3Q5 = DatadtlsofSelectedPAGE3Q5[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE3Q6.length; i++) {
                    if (DatadtlsofSelectedPAGE3Q6[i].checked) {
                        DataofSelectedPAGE3Q6 = DatadtlsofSelectedPAGE3Q6[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE3Q7.length; i++) {
                    if (DatadtlsofSelectedPAGE3Q7[i].checked) {
                        DataofSelectedPAGE3Q7 = DatadtlsofSelectedPAGE3Q7[i].value;
                    }
                }
                var GETDTLSNASFC = document.getElementById("RATINGVALUESSFCNA");
                var FINALSFCCHECKFLAG = "N";
                if (GETDTLSNASFC.checked) {
                    document.getElementById("<%=HNDOPP3Q5.ClientID%>").value = "Not Availed";
                    FINALSFCCHECKFLAG = "Y";
                }
                else if (DataofSelectedPAGE3Q5 != "" && DataofSelectedPAGE3Q5 != "undefined" && DataofSelectedPAGE3Q5 != null) {
                    document.getElementById("<%=HNDOPP3Q5.ClientID%>").value = DataofSelectedPAGE3Q5;
                    FINALSFCCHECKFLAG = "Y";
                }
                else {
                    document.getElementById("<%=HNDOPP3Q5.ClientID%>").value = "";
                    FINALSFCCHECKFLAG = "N";
                }
                var GETDTLSNADIS = document.getElementById("RATINGVALUESDISNA");
                var FINALDISCHECKFLAG = "N";
                if (GETDTLSNADIS.checked) {
                    document.getElementById("<%=HNDOPP3Q6.ClientID%>").value = "Not Availed";
                    FINALDISCHECKFLAG = "Y";
                }
                else if (DataofSelectedPAGE3Q6 != "" && DataofSelectedPAGE3Q6 != "undefined" && DataofSelectedPAGE3Q6 != null) {
                    document.getElementById("<%=HNDOPP3Q6.ClientID%>").value = DataofSelectedPAGE3Q6;
                    FINALDISCHECKFLAG = "Y";
                }
                else {
                    document.getElementById("<%=HNDOPP3Q6.ClientID%>").value = "";
                    FINALDISCHECKFLAG = "N";
                }
                var GETDTLSNAOPS = document.getElementById("RATINGVALUESOPSNA");
                var FINALOPSCHECKFLAG = "N";
                if (GETDTLSNAOPS.checked) {
                    document.getElementById("<%=HNDOPP3Q7.ClientID%>").value = "Not Availed";
                    FINALOPSCHECKFLAG = "Y";
                }
                else if (DataofSelectedPAGE3Q7 != "" && DataofSelectedPAGE3Q7 != "undefined" && DataofSelectedPAGE3Q7 != null) {
                    document.getElementById("<%=HNDOPP3Q7.ClientID%>").value = DataofSelectedPAGE3Q7;
                    FINALOPSCHECKFLAG = "Y";
                }
                else {
                    document.getElementById("<%=HNDOPP3Q7.ClientID%>").value = "";
                    FINALOPSCHECKFLAG = "N";
                }
                if (DataofSelectedPAGE3Q1 != "" && DataofSelectedPAGE3Q1 != "undefined" && DataofSelectedPAGE3Q1 != null) {
                    document.getElementById("<%=HNDOPP3Q1.ClientID%>").value = DataofSelectedPAGE3Q1;
                    if (DataofSelectedPAGE3Q2 != "" && DataofSelectedPAGE3Q2 != "undefined" && DataofSelectedPAGE3Q2 != null) {
                        document.getElementById("<%=HNDOPP3Q2.ClientID%>").value = DataofSelectedPAGE3Q2;
                        if (DataofSelectedPAGE3Q3 != "" && DataofSelectedPAGE3Q3 != "undefined" && DataofSelectedPAGE3Q3 != null) {
                            document.getElementById("<%=HNDOPP3Q3.ClientID%>").value = DataofSelectedPAGE3Q3;
                            if (DataofSelectedPAGE3Q4 != "" && DataofSelectedPAGE3Q4 != "undefined" && DataofSelectedPAGE3Q4 != null) {
                                document.getElementById("<%=HNDOPP3Q4.ClientID%>").value = DataofSelectedPAGE3Q4;
                                if (FINALSFCCHECKFLAG === "Y") {
                                    if (FINALDISCHECKFLAG === "Y") {
                                        if (FINALOPSCHECKFLAG === "Y") {
                                            document.getElementById("Page1").style.display = "block";
                                            document.getElementById("Page0HomeMenu").style.display = "none";
                                            document.getElementById("UserMsgDiv").style.display = "none";
                                            document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
                                        }
                                        else {
                                            //alert("7");
                                            document.getElementById("UserMsgDiv").style.display = "block";
                                            document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Optical Shop Rating or not availed";
                                        }
                                    }
                                    else {
                                        //alert("6");
                                        document.getElementById("UserMsgDiv").style.display = "block";
                                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Diagnostic Services Rating or not availed";
                                    }
                                }
                                else {
                                    //alert("5");
                                    document.getElementById("UserMsgDiv").style.display = "block";
                                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Surgery Fixing Centre Rating or not availed";
                                }
                            }
                            else {
                                //alert("4");
                                document.getElementById("UserMsgDiv").style.display = "block";
                                document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Consultation Of Eye Doctor Rating";
                            }
                        }
                        else {
                            //alert("3");
                            document.getElementById("UserMsgDiv").style.display = "block";
                            document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Optometrist Evaluation Rating";
                        }
                    }
                    else {
                        //alert("2");
                        document.getElementById("UserMsgDiv").style.display = "block";
                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Staff At Reception/Registration Desk Rating";
                    }
                }
                else {
                    //alert("1");
                    document.getElementById("UserMsgDiv").style.display = "block";
                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Appointment Fixing Process Rating";
                }
            }



			function HomeMenu() {
				 document.getElementById("Page0HomeMenu").style.display = "block";
                document.getElementById("Page1").style.display = "none";
                document.getElementById("UserMsgDiv").style.display = "none";
                document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
            }



			function Page1ChecktoPage2() {

				var DatadtlsofSelectedPAGE4Q1 = document.getElementsByName("PAGE4Q1");
                var DatadtlsofSelectedPAGE4Q2 = document.getElementsByName("PAGE4Q2");
                var DatadtlsofSelectedPAGE4Q3 = document.getElementsByName("PAGE4Q3");
                var DatadtlsofSelectedPAGE4Q4 = document.getElementsByName("PAGE4Q4");
                var DatadtlsofSelectedPAGE4Q5 = document.getElementsByName("PAGE4Q5");
                var DatadtlsofSelectedPAGE4Q6 = document.getElementsByName("PAGE4Q6");
                var DataofSelectedPAGE4Q1 = "";
                var DataofSelectedPAGE4Q2 = "";
                var DataofSelectedPAGE4Q3 = "";
                var DataofSelectedPAGE4Q4 = "";
                var DataofSelectedPAGE4Q5 = "";
                var DataofSelectedPAGE4Q6 = "";
                for (var i = 0; i < DatadtlsofSelectedPAGE4Q1.length; i++) {
                    if (DatadtlsofSelectedPAGE4Q1[i].checked) {
                        DataofSelectedPAGE4Q1 = DatadtlsofSelectedPAGE4Q1[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE4Q2.length; i++) {
                    if (DatadtlsofSelectedPAGE4Q2[i].checked) {
                        DataofSelectedPAGE4Q2 = DatadtlsofSelectedPAGE4Q2[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE4Q3.length; i++) {
                    if (DatadtlsofSelectedPAGE4Q3[i].checked) {
                        DataofSelectedPAGE4Q3 = DatadtlsofSelectedPAGE4Q3[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE4Q4.length; i++) {
                    if (DatadtlsofSelectedPAGE4Q4[i].checked) {
                        DataofSelectedPAGE4Q4 = DatadtlsofSelectedPAGE4Q4[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE4Q5.length; i++) {
                    if (DatadtlsofSelectedPAGE4Q5[i].checked) {
                        DataofSelectedPAGE4Q5 = DatadtlsofSelectedPAGE4Q5[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE4Q6.length; i++) {
                    if (DatadtlsofSelectedPAGE4Q6[i].checked) {
                        DataofSelectedPAGE4Q6 = DatadtlsofSelectedPAGE4Q6[i].value;
                    }
                }
                var GETDTLSNAPHA = document.getElementById("RATINGVALUESPHANA");
                var FINALPHSCHECKFLAG = "N";
                if (GETDTLSNAPHA.checked) {
                    document.getElementById("<%=HNDOPP4Q1.ClientID%>").value = "Not Availed";
                    FINALPHSCHECKFLAG = "Y";
                }
                else if (DataofSelectedPAGE4Q1 != "" && DataofSelectedPAGE4Q1 != "undefined" && DataofSelectedPAGE4Q1 != null) {
                    document.getElementById("<%=HNDOPP4Q1.ClientID%>").value = DataofSelectedPAGE4Q1;
                    FINALPHSCHECKFLAG = "Y";
                }
                else {
                    document.getElementById("<%=HNDOPP4Q1.ClientID%>").value = "";
                    FINALPHSCHECKFLAG = "N";
                }
                var GETDTLSNALAB = document.getElementById("RATINGVALUESLABNA");
                var FINALLABCHECKFLAG = "N";
                if (GETDTLSNALAB.checked) {
                    document.getElementById("<%=HNDOPP4Q2.ClientID%>").value = "Not Availed";
                    FINALLABCHECKFLAG = "Y";
                }
                else if (DataofSelectedPAGE4Q2 != "" && DataofSelectedPAGE4Q2 != "undefined" && DataofSelectedPAGE4Q2 != null) {
                    document.getElementById("<%=HNDOPP4Q2.ClientID%>").value = DataofSelectedPAGE4Q2;
                    FINALLABCHECKFLAG = "Y";
                }
                else {
                    document.getElementById("<%=HNDOPP4Q2.ClientID%>").value = "";
                    FINALLABCHECKFLAG = "N";
                }
                var GETDTLSNACAN = document.getElementById("RATINGVALUESCANNA");
                var FINALCANCHECKFLAG = "N";
                if (GETDTLSNACAN.checked) {
                    document.getElementById("<%=HNDOPP4Q3.ClientID%>").value = "Not Availed";
                    FINALCANCHECKFLAG = "Y";
                }
                else if (DataofSelectedPAGE4Q3 != "" && DataofSelectedPAGE4Q3 != "undefined" && DataofSelectedPAGE4Q3 != null) {
                    document.getElementById("<%=HNDOPP4Q3.ClientID%>").value = DataofSelectedPAGE4Q3;
                    FINALCANCHECKFLAG = "Y";
                }
                else {
                    document.getElementById("<%=HNDOPP4Q3.ClientID%>").value = "";
                    FINALCANCHECKFLAG = "N";
                }
                if (FINALPHSCHECKFLAG === "Y") {
                    if (FINALLABCHECKFLAG === "Y") {
                        if (FINALCANCHECKFLAG === "Y") {
                            if (DataofSelectedPAGE4Q4 != "" && DataofSelectedPAGE4Q4 != "undefined" && DataofSelectedPAGE4Q4 != null) {
                                document.getElementById("<%=HNDOPP4Q4.ClientID%>").value = DataofSelectedPAGE4Q4;
                                if (DataofSelectedPAGE4Q5 != "" && DataofSelectedPAGE4Q5 != "undefined" && DataofSelectedPAGE4Q5 != null) {
                                    document.getElementById("<%=HNDOPP4Q5.ClientID%>").value = DataofSelectedPAGE4Q5;
                                    if (DataofSelectedPAGE4Q6 != "" && DataofSelectedPAGE4Q6 != "undefined" && DataofSelectedPAGE4Q6 != null) {
                                        document.getElementById("<%=HNDOPP4Q6.ClientID%>").value = DataofSelectedPAGE4Q6;
                                        var SelectedValueHRS = $('input[name="<%= hourselect.ClientID %>"]:checked').val();
                                      if (typeof SelectedValueHRS !== "undefined" && SelectedValueHRS !== null && SelectedValueHRS !== "") {
                                            document.getElementById("<%=HNDOPP4Q7.ClientID%>").value = SelectedValueHRS;
                                            document.getElementById("Page1").style.display = "none";
                                            document.getElementById("Page2").style.display = "block";
                                            document.getElementById("UserMsgDiv").style.display = "none";
                                            document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
                                        }
                                        else {
                                            //alert("7");
                                            document.getElementById("UserMsgDiv").style.display = "block";
                                            document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Total Time Spent In Our Hospital For The Consultation And Treatment Process Rating";
                                        }
                                    }
                                    else {
                                        //alert("6");
                                        document.getElementById("UserMsgDiv").style.display = "block";
                                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select  Overall Rating Of Sankara Nethralaya  Rating";
                                    }
                                }
                                else {
                                    //alert("5");
                                    document.getElementById("UserMsgDiv").style.display = "block";
                                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Overall Cleanliness Rating";
                                }
                            }
                            else {
                                //alert("4");
                                document.getElementById("UserMsgDiv").style.display = "block";
                                document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Display/Direction Boards Rating";
                            }
                        }
                        else {
                            //alert("3");
                            document.getElementById("UserMsgDiv").style.display = "block";
                            document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Canteen Rating or not availed";
                        }
                    }
                    else {
                        //alert("2");
                        document.getElementById("UserMsgDiv").style.display = "block";
                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Laboratory Rating or not availed";
                    }
                }
                else {
                    //alert("1");
                    document.getElementById("UserMsgDiv").style.display = "block";
                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Pharmacy Rating or not availed";
                }
            }





			function Page2ChecktoPage1() {
				document.getElementById("Page1").style.display = "block";
                document.getElementById("Page2").style.display = "none";
                document.getElementById("UserMsgDiv").style.display = "none";
                document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
            }



			function Page2ChecktoPage3() {
				var SelectedValueRFORHV = $('input[name="<%= RFORHVDDL.ClientID %>"]:checked').val();

                var SelectedValueAFT = $('input[name="<%= AFTDDL.ClientID %>"]:checked').val();

                if (typeof SelectedValueRFORHV !== "undefined" && SelectedValueRFORHV !== null && SelectedValueRFORHV !== "") {
                    document.getElementById("<%=HNDOPP2Q1.ClientID%>").value = SelectedValueRFORHV;

                    if (typeof SelectedValueAFT !== "undefined" && SelectedValueAFT !== null && SelectedValueAFT !== "") {
                        document.getElementById("<%=HNDOPP2Q2.ClientID%>").value = SelectedValueAFT;

                        var SelectedValueREC =  $('input[name="<%= Recommed.ClientID %>"]:checked').val();
                        if (typeof SelectedValueREC !== "undefined" && SelectedValueREC !== null && SelectedValueREC !== "") {
                            document.getElementById("<%=HNDOPP5Q1.ClientID%>").value = SelectedValueREC;
                    document.getElementById("<%=HNDOPP5Q2.ClientID%>").value = document.getElementById("<%=txtappreciation.ClientID%>").value;
                    document.getElementById("<%=HNDOPP5Q3.ClientID%>").value = document.getElementById("<%=txtsuggestion.ClientID%>").value;
                    document.getElementById("Page4").style.display = "none";
                    var Q1Check = document.getElementById("<%=HNDOPP2Q1.ClientID%>").value;
                    var Q2Check = document.getElementById("<%=HNDOPP2Q2.ClientID%>").value;
                    var Q3Check = document.getElementById("<%=HNDOPP3Q1.ClientID%>").value;
                    var Q4Check = document.getElementById("<%=HNDOPP3Q2.ClientID%>").value;
                    var Q5Check = document.getElementById("<%=HNDOPP3Q3.ClientID%>").value;
                    var Q6Check = document.getElementById("<%=HNDOPP3Q4.ClientID%>").value;
                    var Q7Check = document.getElementById("<%=HNDOPP3Q5.ClientID%>").value;
                    var Q8Check = document.getElementById("<%=HNDOPP3Q6.ClientID%>").value;
                    var Q9Check = document.getElementById("<%=HNDOPP3Q7.ClientID%>").value;
                    var Q10Check = document.getElementById("<%=HNDOPP4Q1.ClientID%>").value;
                    var Q11Check = document.getElementById("<%=HNDOPP4Q2.ClientID%>").value;
                    var Q12Check = document.getElementById("<%=HNDOPP4Q3.ClientID%>").value;
                    var Q13Check = document.getElementById("<%=HNDOPP4Q4.ClientID%>").value;
                    var Q14Check = document.getElementById("<%=HNDOPP4Q5.ClientID%>").value;
                    var Q15Check = document.getElementById("<%=HNDOPP4Q6.ClientID%>").value;
                    var Q16Check = document.getElementById("<%=HNDOPP4Q7.ClientID%>").value;
                    var Q17Check = document.getElementById("<%=HNDOPP5Q1.ClientID%>").value;
                    var Q18Check = document.getElementById("<%=HNDOPP5Q2.ClientID%>").value;
                    var Q19Check = document.getElementById("<%=HNDOPP5Q3.ClientID%>").value;
                    var APPTIDCheck = document.getElementById("<%=HNDPATAPPTID.ClientID%>").value;
                    if (Q1Check !== "" && Q1Check !== null && Q2Check !== "" && Q2Check !== null && Q3Check !== "" && Q3Check !== null
                        && Q4Check !== "" && Q4Check !== null && Q5Check !== "" && Q5Check !== null && Q6Check !== "" && Q6Check !== null
                        && Q7Check !== "" && Q7Check !== null && Q8Check !== "" && Q8Check !== null && Q9Check !== "" && Q9Check !== null
                        && Q10Check !== "" && Q10Check !== null && Q11Check !== "" && Q11Check !== null && Q12Check !== "" && Q12Check !== null
                        && Q13Check !== "" && Q13Check !== null && Q14Check !== "" && Q14Check !== null && Q15Check !== "" && Q15Check !== null
                        && Q16Check !== "" && Q16Check !== null && Q17Check !== "" && Q17Check !== null && APPTIDCheck !== "" && APPTIDCheck !== null) {
                        LoadPatPageDtls("ErrorMsg");
                        document.getElementById("UserMsgDiv").style.display = "none";
                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
                        $("#MasterCoverScreen").show();
                        document.getElementById("<%=Save.ClientID%>").click();
                    }
                    else {
                        LoadPatPageDtls("ErrorMsg");
                        document.getElementById("UserMsgDiv").style.display = "block";
                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "No information returned Please try later";
                    }
                }
                else {
                    document.getElementById("UserMsgDiv").style.display = "block";
                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Will You Recommend Our Hospital To Others ";
                        }
                    }
                    else {
                        document.getElementById("UserMsgDiv").style.display = "block";
                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Appointment Fixed Through";
                    }
                }
                else {
                    document.getElementById("UserMsgDiv").style.display = "block";
                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Reason For Choosing Our Hospital? ";
                }
            }





			function Page3ChecktoPage2() {
				document.getElementById("Page3").style.display = "none";
				document.getElementById("Page2").style.display = "block";
				document.getElementById("UserMsgDiv").style.display = "none";
				document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
			}

			function Page3ChecktoPage4() {
				var DatadtlsofSelectedPAGE4Q1 = document.getElementsByName("PAGE4Q1");
				var DatadtlsofSelectedPAGE4Q2 = document.getElementsByName("PAGE4Q2");
				var DatadtlsofSelectedPAGE4Q3 = document.getElementsByName("PAGE4Q3");
				var DatadtlsofSelectedPAGE4Q4 = document.getElementsByName("PAGE4Q4");
				var DatadtlsofSelectedPAGE4Q5 = document.getElementsByName("PAGE4Q5");
				var DatadtlsofSelectedPAGE4Q6 = document.getElementsByName("PAGE4Q6");
				var DataofSelectedPAGE4Q1 = "";
				var DataofSelectedPAGE4Q2 = "";
				var DataofSelectedPAGE4Q3 = "";
				var DataofSelectedPAGE4Q4 = "";
				var DataofSelectedPAGE4Q5 = "";
				var DataofSelectedPAGE4Q6 = "";
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q1.length; i++) {
					if (DatadtlsofSelectedPAGE4Q1[i].checked) {
						DataofSelectedPAGE4Q1 = DatadtlsofSelectedPAGE4Q1[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q2.length; i++) {
					if (DatadtlsofSelectedPAGE4Q2[i].checked) {
						DataofSelectedPAGE4Q2 = DatadtlsofSelectedPAGE4Q2[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q3.length; i++) {
					if (DatadtlsofSelectedPAGE4Q3[i].checked) {
						DataofSelectedPAGE4Q3 = DatadtlsofSelectedPAGE4Q3[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q4.length; i++) {
					if (DatadtlsofSelectedPAGE4Q4[i].checked) {
						DataofSelectedPAGE4Q4 = DatadtlsofSelectedPAGE4Q4[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q5.length; i++) {
					if (DatadtlsofSelectedPAGE4Q5[i].checked) {
						DataofSelectedPAGE4Q5 = DatadtlsofSelectedPAGE4Q5[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q6.length; i++) {
					if (DatadtlsofSelectedPAGE4Q6[i].checked) {
						DataofSelectedPAGE4Q6 = DatadtlsofSelectedPAGE4Q6[i].value;
					}
				}
				var GETDTLSNAPHA = document.getElementById("RATINGVALUESPHANA");
				var FINALPHSCHECKFLAG = "N";
				if (GETDTLSNAPHA.checked) {
					document.getElementById("<%=HNDOPP4Q1.ClientID%>").value = "Not Availed";
					FINALPHSCHECKFLAG = "Y";
				}
				else if (DataofSelectedPAGE4Q1 != "" && DataofSelectedPAGE4Q1 != "undefined" && DataofSelectedPAGE4Q1 != null) {
					document.getElementById("<%=HNDOPP4Q1.ClientID%>").value = DataofSelectedPAGE4Q1;
					FINALPHSCHECKFLAG = "Y";
				}
				else {
					document.getElementById("<%=HNDOPP4Q1.ClientID%>").value = "";
					FINALPHSCHECKFLAG = "N";
				}
				var GETDTLSNALAB = document.getElementById("RATINGVALUESLABNA");
				var FINALLABCHECKFLAG = "N";
				if (GETDTLSNALAB.checked) {
					document.getElementById("<%=HNDOPP4Q2.ClientID%>").value = "Not Availed";
					FINALLABCHECKFLAG = "Y";
				}
				else if (DataofSelectedPAGE4Q2 != "" && DataofSelectedPAGE4Q2 != "undefined" && DataofSelectedPAGE4Q2 != null) {
					document.getElementById("<%=HNDOPP4Q2.ClientID%>").value = DataofSelectedPAGE4Q2;
					FINALLABCHECKFLAG = "Y";
				}
				else {
					document.getElementById("<%=HNDOPP4Q2.ClientID%>").value = "";
					FINALLABCHECKFLAG = "N";
				}
				var GETDTLSNACAN = document.getElementById("RATINGVALUESCANNA");
				var FINALCANCHECKFLAG = "N";
				if (GETDTLSNACAN.checked) {
					document.getElementById("<%=HNDOPP4Q3.ClientID%>").value = "Not Availed";
					FINALCANCHECKFLAG = "Y";
				}
				else if (DataofSelectedPAGE4Q3 != "" && DataofSelectedPAGE4Q3 != "undefined" && DataofSelectedPAGE4Q3 != null) {
					document.getElementById("<%=HNDOPP4Q3.ClientID%>").value = DataofSelectedPAGE4Q2;
					FINALCANCHECKFLAG = "Y";
				}
				else {
					document.getElementById("<%=HNDOPP4Q3.ClientID%>").value = "";
					FINALCANCHECKFLAG = "N";
				}
				if (FINALPHSCHECKFLAG === "Y") {
					if (FINALLABCHECKFLAG === "Y") {
						if (FINALCANCHECKFLAG === "Y") {
							if (DataofSelectedPAGE4Q4 != "" && DataofSelectedPAGE4Q4 != "undefined" && DataofSelectedPAGE4Q4 != null) {
								document.getElementById("<%=HNDOPP4Q4.ClientID%>").value = DataofSelectedPAGE4Q4;
								if (DataofSelectedPAGE4Q5 != "" && DataofSelectedPAGE4Q5 != "undefined" && DataofSelectedPAGE4Q5 != null) {
									document.getElementById("<%=HNDOPP4Q5.ClientID%>").value = DataofSelectedPAGE4Q5;
									if (DataofSelectedPAGE4Q6 != "" && DataofSelectedPAGE4Q6 != "undefined" && DataofSelectedPAGE4Q6 != null) {
										document.getElementById("<%=HNDOPP4Q6.ClientID%>").value = DataofSelectedPAGE4Q6;
										var SelectedValueHRS = ($('#hourselect option:selected').val());
										if (SelectedValueHRS !== "" && SelectedValueHRS !== null && SelectedValueHRS !== "undefined") {
											document.getElementById("<%=HNDOPP4Q7.ClientID%>").value = SelectedValueHRS;
											document.getElementById("Page3").style.display = "none";
											document.getElementById("Page4").style.display = "block";
											document.getElementById("UserMsgDiv").style.display = "none";
											document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
										}
										else {
											//alert("7");
											document.getElementById("UserMsgDiv").style.display = "block";
											document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Total Time Spent In Our Hospital For The Consultation And Treatment Process Rating";
										}
									}
									else {
										//alert("6");
										document.getElementById("UserMsgDiv").style.display = "block";
										document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select  Overall Rating Of Sankara Nethralaya  Rating";
									}
								}
								else {
									//alert("5");
									document.getElementById("UserMsgDiv").style.display = "block";
									document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Overall Cleanliness Rating";
								}
							}
							else {
								//alert("4");
								document.getElementById("UserMsgDiv").style.display = "block";
								document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Display/Direction Boards Rating";
							}
						}
						else {
							//alert("3");
							document.getElementById("UserMsgDiv").style.display = "block";
							document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Canteen Rating or not availed";
						}
					}
					else {
						//alert("2");
						document.getElementById("UserMsgDiv").style.display = "block";
						document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Laboratory Rating or not availed";
					}
				}
				else {
					//alert("1");
					document.getElementById("UserMsgDiv").style.display = "block";
					document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Pharmacy Rating or not availed";
				}
			}
			function Page4ChecktoPage3() {
				document.getElementById("Page4").style.display = "none";
				document.getElementById("Page3").style.display = "block";
				document.getElementById("UserMsgDiv").style.display = "none";
				document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";

			}
			function Page4ChecktoSaveMode() {
				var SelectedValueREC = ($('#Recommed option:selected').val());
				if (SelectedValueREC !== "" && SelectedValueREC !== null && SelectedValueREC !== "undefined") {
					document.getElementById("<%=HNDOPP5Q1.ClientID%>").value = SelectedValueREC;
					document.getElementById("<%=HNDOPP5Q2.ClientID%>").value = document.getElementById("<%=txtappreciation.ClientID%>").value;
					document.getElementById("<%=HNDOPP5Q3.ClientID%>").value = document.getElementById("<%=txtsuggestion.ClientID%>").value;
					document.getElementById("Page4").style.display = "none";
					var Q1Check = document.getElementById("<%=HNDOPP2Q1.ClientID%>").value;
					var Q2Check = document.getElementById("<%=HNDOPP2Q2.ClientID%>").value;
					var Q3Check = document.getElementById("<%=HNDOPP3Q1.ClientID%>").value;
					var Q4Check = document.getElementById("<%=HNDOPP3Q2.ClientID%>").value;
					var Q5Check = document.getElementById("<%=HNDOPP3Q3.ClientID%>").value;
					var Q6Check = document.getElementById("<%=HNDOPP3Q4.ClientID%>").value;
					var Q7Check = document.getElementById("<%=HNDOPP3Q5.ClientID%>").value;
					var Q8Check = document.getElementById("<%=HNDOPP3Q6.ClientID%>").value;
					var Q9Check = document.getElementById("<%=HNDOPP3Q7.ClientID%>").value;
					var Q10Check = document.getElementById("<%=HNDOPP4Q1.ClientID%>").value;
					var Q11Check = document.getElementById("<%=HNDOPP4Q2.ClientID%>").value;
					var Q12Check = document.getElementById("<%=HNDOPP4Q3.ClientID%>").value;
					var Q13Check = document.getElementById("<%=HNDOPP4Q4.ClientID%>").value;
					var Q14Check = document.getElementById("<%=HNDOPP4Q5.ClientID%>").value;
					var Q15Check = document.getElementById("<%=HNDOPP4Q6.ClientID%>").value;
					var Q16Check = document.getElementById("<%=HNDOPP4Q7.ClientID%>").value;
					var Q17Check = document.getElementById("<%=HNDOPP5Q1.ClientID%>").value;
					var Q18Check = document.getElementById("<%=HNDOPP5Q2.ClientID%>").value;
					var Q19Check = document.getElementById("<%=HNDOPP5Q3.ClientID%>").value;
					var APPTIDCheck = document.getElementById("<%=HNDPATAPPTID.ClientID%>").value;
					if (Q1Check !== "" && Q1Check !== null && Q2Check !== "" && Q2Check !== null && Q3Check !== "" && Q3Check !== null
						&& Q4Check !== "" && Q4Check !== null && Q5Check !== "" && Q5Check !== null && Q6Check !== "" && Q6Check !== null
						&& Q7Check !== "" && Q7Check !== null && Q8Check !== "" && Q8Check !== null && Q9Check !== "" && Q9Check !== null
						&& Q10Check !== "" && Q10Check !== null && Q11Check !== "" && Q11Check !== null && Q12Check !== "" && Q12Check !== null
						&& Q13Check !== "" && Q13Check !== null && Q14Check !== "" && Q14Check !== null && Q15Check !== "" && Q15Check !== null
						&& Q16Check !== "" && Q16Check !== null && Q17Check !== "" && Q17Check !== null && APPTIDCheck !== "" && APPTIDCheck !== null) {
						LoadPatPageDtls("ErrorMsg");
						document.getElementById("UserMsgDiv").style.display = "none";
						document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
						$("#MasterCoverScreen").show();
						document.getElementById("<%=Save.ClientID%>").click();
					}
					else {
						LoadPatPageDtls("ErrorMsg");
						document.getElementById("UserMsgDiv").style.display = "block";
						document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "No information returned Please try later";
					}
				}
				else {
					document.getElementById("UserMsgDiv").style.display = "block";
					document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Will You Recommend Our Hospital To Others ";
				}

			}
			function OnNACLICKSFC(Dtls) {
				if ($(Dtls).is(":checked")) {
					document.getElementById("SFCRATING1TO10Radio").style.display = "none";
					document.getElementById("SFCRATING1TO10Label").style.display = "none";
				} else {
					document.getElementById("SFCRATING1TO10Radio").style.display = "flex";
					document.getElementById("SFCRATING1TO10Label").style.display = "flex";

				}
			}
			function OnNACLICKDIS(Dtls) {
				if ($(Dtls).is(":checked")) {
					document.getElementById("DISRATING1TO10Radio").style.display = "none";
					document.getElementById("DISRATING1TO10Label").style.display = "none";
				} else {
					document.getElementById("DISRATING1TO10Radio").style.display = "flex";
					document.getElementById("DISRATING1TO10Label").style.display = "flex";
				}
			}
			function OnNACLICKOPS(Dtls) {
				if ($(Dtls).is(":checked")) {
					document.getElementById("OPSRATING1TO10Radio").style.display = "none";
					document.getElementById("OPSRATING1TO10Label").style.display = "none";
				} else {
					document.getElementById("OPSRATING1TO10Radio").style.display = "flex";
					document.getElementById("OPSRATING1TO10Label").style.display = "flex";
				}
			}
			function OnNACLICKPHA(Dtls) {
				if ($(Dtls).is(":checked")) {
					document.getElementById("PHARATING1TO10Radio").style.display = "none";
					document.getElementById("PHARATING1TO10Label").style.display = "none";
				} else {
					document.getElementById("PHARATING1TO10Radio").style.display = "flex";
					document.getElementById("PHARATING1TO10Label").style.display = "flex";
				}
			}
			function OnNACLICKLAB(Dtls) {
				if ($(Dtls).is(":checked")) {
					document.getElementById("LABRATING1TO10Radio").style.display = "none";
					document.getElementById("LABRATING1TO10Label").style.display = "none";
				} else {
					document.getElementById("LABRATING1TO10Radio").style.display = "flex";
					document.getElementById("LABRATING1TO10Label").style.display = "flex";
				}
			}
			function OnNACLICKCAN(Dtls) {
				if ($(Dtls).is(":checked")) {
					document.getElementById("CANRATING1TO10Radio").style.display = "none";
					document.getElementById("CANRATING1TO10Label").style.display = "none";
				} else {
					document.getElementById("CANRATING1TO10Radio").style.display = "flex";
					document.getElementById("CANRATING1TO10Label").style.display = "flex";
				}
			}
			function TESTCHECK() {
				// var DatadtlsofSelectedRating0Values0 = document.getElementsByName("Rating0Values0");
				// var DatadtlsofSelectedRating0Values = document.getElementsByName("Rating0Values");
				// var DatadtlsofSelectedRating1Values = document.getElementsByName("Rating1Values");

				var DatadtlsofSelectedPAGE3Q1 = document.getElementsByName("PAGE3Q1");
				var DatadtlsofSelectedPAGE3Q2 = document.getElementsByName("PAGE3Q2");
				var DatadtlsofSelectedPAGE3Q3 = document.getElementsByName("PAGE3Q3");
				var DatadtlsofSelectedPAGE3Q4 = document.getElementsByName("PAGE3Q4");
				var DatadtlsofSelectedPAGE3Q5 = document.getElementsByName("PAGE3Q5");
				var DatadtlsofSelectedPAGE3Q6 = document.getElementsByName("PAGE3Q6");
				var DatadtlsofSelectedPAGE3Q7 = document.getElementsByName("PAGE3Q7");
				var DatadtlsofSelectedPAGE4Q1 = document.getElementsByName("PAGE4Q1");
				var DatadtlsofSelectedPAGE4Q2 = document.getElementsByName("PAGE4Q2");
				var DatadtlsofSelectedPAGE4Q3 = document.getElementsByName("PAGE4Q3");
				var DatadtlsofSelectedPAGE4Q4 = document.getElementsByName("PAGE4Q4");
				var DatadtlsofSelectedPAGE4Q5 = document.getElementsByName("PAGE4Q5");
				var DatadtlsofSelectedPAGE4Q6 = document.getElementsByName("PAGE4Q6");



				// var DataofSelectedRating0Values0 = "";
				// var DataofSelectedRating0Values = "";
				//var DataofSelectedRating1Values = "";

				var DataofSelectedPAGE3Q1 = "";
				var DataofSelectedPAGE3Q2 = "";
				var DataofSelectedPAGE3Q3 = "";
				var DataofSelectedPAGE3Q4 = "";
				var DataofSelectedPAGE3Q5 = "";
				var DataofSelectedPAGE3Q6 = "";
				var DataofSelectedPAGE3Q7 = "";
				var DataofSelectedPAGE4Q1 = "";
				var DataofSelectedPAGE4Q2 = "";
				var DataofSelectedPAGE4Q3 = "";
				var DataofSelectedPAGE4Q4 = "";
				var DataofSelectedPAGE4Q5 = "";
				var DataofSelectedPAGE4Q6 = "";




				for (var i = 0; i < DatadtlsofSelectedPAGE3Q1.length; i++) {
					if (DatadtlsofSelectedPAGE3Q1[i].checked) {
						DataofSelectedPAGE3Q1 = DatadtlsofSelectedPAGE3Q1[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE3Q2.length; i++) {
					if (DatadtlsofSelectedPAGE3Q2[i].checked) {
						DataofSelectedPAGE3Q2 = DatadtlsofSelectedPAGE3Q2[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE3Q3.length; i++) {
					if (DatadtlsofSelectedPAGE3Q3[i].checked) {
						DataofSelectedPAGE3Q3 = DatadtlsofSelectedPAGE3Q3[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE3Q4.length; i++) {
					if (DatadtlsofSelectedPAGE3Q4[i].checked) {
						DataofSelectedPAGE3Q4 = DatadtlsofSelectedPAGE3Q4[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE3Q5.length; i++) {
					if (DatadtlsofSelectedPAGE3Q5[i].checked) {
						DataofSelectedPAGE3Q5 = DatadtlsofSelectedPAGE3Q5[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE3Q6.length; i++) {
					if (DatadtlsofSelectedPAGE3Q6[i].checked) {
						DataofSelectedPAGE3Q6 = DatadtlsofSelectedPAGE3Q6[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE3Q7.length; i++) {
					if (DatadtlsofSelectedPAGE3Q7[i].checked) {
						DataofSelectedPAGE3Q7 = DatadtlsofSelectedPAGE3Q7[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q1.length; i++) {
					if (DatadtlsofSelectedPAGE4Q1[i].checked) {
						DataofSelectedPAGE4Q1 = DatadtlsofSelectedPAGE4Q1[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q2.length; i++) {
					if (DatadtlsofSelectedPAGE4Q2[i].checked) {
						DataofSelectedPAGE4Q2 = DatadtlsofSelectedPAGE4Q2[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q3.length; i++) {
					if (DatadtlsofSelectedPAGE4Q3[i].checked) {
						DataofSelectedPAGE4Q3 = DatadtlsofSelectedPAGE4Q3[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q4.length; i++) {
					if (DatadtlsofSelectedPAGE4Q4[i].checked) {
						DataofSelectedPAGE4Q4 = DatadtlsofSelectedPAGE4Q4[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q5.length; i++) {
					if (DatadtlsofSelectedPAGE4Q5[i].checked) {
						DataofSelectedPAGE4Q5 = DatadtlsofSelectedPAGE4Q5[i].value;
					}
				}
				for (var i = 0; i < DatadtlsofSelectedPAGE4Q6.length; i++) {
					if (DatadtlsofSelectedPAGE4Q6[i].checked) {
						DataofSelectedPAGE4Q6 = DatadtlsofSelectedPAGE4Q6[i].value;
					}
				}

				if (DataofSelectedPAGE3Q1 != "" && DataofSelectedPAGE3Q1 != "undefined" && DataofSelectedPAGE3Q1 != null) {
					alert(DataofSelectedPAGE3Q1);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE3Q2 != "" && DataofSelectedPAGE3Q2 != "undefined" && DataofSelectedPAGE3Q2 != null) {
					alert(DataofSelectedPAGE3Q2);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE3Q3 != "" && DataofSelectedPAGE3Q3 != "undefined" && DataofSelectedPAGE3Q3 != null) {
					alert(DataofSelectedPAGE3Q3);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE3Q4 != "" && DataofSelectedPAGE3Q4 != "undefined" && DataofSelectedPAGE3Q4 != null) {
					alert(DataofSelectedPAGE3Q4);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE3Q5 != "" && DataofSelectedPAGE3Q5 != "undefined" && DataofSelectedPAGE3Q5 != null) {
					alert(DataofSelectedPAGE3Q5);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE3Q6 != "" && DataofSelectedPAGE3Q6 != "undefined" && DataofSelectedPAGE3Q6 != null) {
					alert(DataofSelectedPAGE3Q6);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE3Q7 != "" && DataofSelectedPAGE3Q7 != "undefined" && DataofSelectedPAGE3Q7 != null) {
					alert(DataofSelectedPAGE3Q7);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE4Q1 != "" && DataofSelectedPAGE4Q1 != "undefined" && DataofSelectedPAGE4Q1 != null) {
					alert(DataofSelectedPAGE4Q1);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE4Q2 != "" && DataofSelectedPAGE4Q2 != "undefined" && DataofSelectedPAGE4Q2 != null) {
					alert(DataofSelectedPAGE4Q2);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE4Q3 != "" && DataofSelectedPAGE4Q3 != "undefined" && DataofSelectedPAGE4Q3 != null) {
					alert(DataofSelectedPAGE4Q3);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE4Q4 != "" && DataofSelectedPAGE4Q4 != "undefined" && DataofSelectedPAGE4Q4 != null) {
					alert(DataofSelectedPAGE4Q4);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE4Q5 != "" && DataofSelectedPAGE4Q5 != "undefined" && DataofSelectedPAGE4Q5 != null) {
					alert(DataofSelectedPAGE4Q5);
				}
				else {
					alert("please provide rating to proceed");
				}
				if (DataofSelectedPAGE4Q6 != "" && DataofSelectedPAGE4Q6 != "undefined" && DataofSelectedPAGE4Q6 != null) {
					alert(DataofSelectedPAGE4Q6);
				}
				else {
					alert("please provide rating to proceed");
				}
			}

		</script>
        <script>
            function limitText(limitField, limitNum) {
                var limitCount = document.getElementById("countdown");
                if (limitField.value.length > limitNum) {
                    limitField.value = limitField.value.substring(0, limitNum);
                } else {
                    limitCount.value = limitNum - limitField.value.length;
                }
            }
            function limitTextApp(limitFieldApp, limitNumApp) {
                var limitCountApp = document.getElementById("countdownapp");
                if (limitFieldApp.value.length > limitNumApp) {
                    limitFieldApp.value = limitFieldApp.value.substring(0, limitNumApp);
                } else {
                    limitCountApp.value = limitNumApp - limitFieldApp.value.length;
                }
            }
        </script>
	</form>
</body>
</html>
