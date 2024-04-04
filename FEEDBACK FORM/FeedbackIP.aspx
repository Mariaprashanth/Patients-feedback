<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FeedbackIP.aspx.cs" Inherits="Pages_Patient_FeedbackOP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>SN-IP Feedback</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <%--<link href="Pages/Patient/Rating/style.css" rel="stylesheet" />--%>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel='shortcut icon' type='image/x-icon' href='Rating/favicon.ico' />
    <%--<link href="Rating/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="/SNTO/App_Files/Master_CSS/bootstrap.min.css?VER=1.0" rel="stylesheet" />
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
                            <asp:Label ID="Label1" runat="server" Text="MRD NO :" ></asp:Label><asp:Label ID="PATMRDNUM" runat="server" Text=""></asp:Label><br />
                            <asp:Label ID="PATNAME" runat="server" Text=""></asp:Label><br />
                            <asp:Label ID="PATAGE" runat="server" Text=""></asp:Label><br />
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
                               <%-- <div style="display: flex; flex-direction: row; justify-content: space-between;">
                                    <h2 class="fs-title">Feedback</h2>
                                    <p style="font-size: 22px; color: red;">If not used the service select - Not Availed</p>
                                </div>--%>
                                 <div class="row">
                                    <div class="col-md-3 col-sm-12 ForMobileCenter">
                                        <h2 class="fs-title">Feedback</h2>
                                    </div>
                                    <div class="col-md-9 col-sm-12 ForMobileCenter ForPCRightNALabel">
                                        <p style="font-size: 22px; color: red;">If service is not availed please select - Not Availed</p>
                                    </div>
                                </div>

                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="AQ1" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span style="font-size: 20px; font-weight: bold;">Admissions</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P1Q1" Text="Admissions"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE1Q1" id="RATINGVALUESADM10" value="10" />
                                                <label for="RATINGVALUESADM10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE1Q1" id="RATINGVALUESADM9" value="9" />
                                                <label for="RATINGVALUESADM9">9</label>
                                                <input type="radio" name="PAGE1Q1" id="RATINGVALUESADM8" value="8" />
                                                <label for="RATINGVALUESADM8">8</label>
                                                <input type="radio" name="PAGE1Q1" id="RATINGVALUESADM7" value="7" />
                                                <label for="RATINGVALUESADM7">7</label>
                                                <input type="radio" name="PAGE1Q1" id="RATINGVALUESADM6" value="6" />
                                                <label for="RATINGVALUESADM6">6</label>
                                                <input type="radio" name="PAGE1Q1" id="RATINGVALUESADM5" value="5" />
                                                <label for="RATINGVALUESADM5">5</label>
                                                <input type="radio" name="PAGE1Q1" id="RATINGVALUESADM4" value="4" />
                                                <label for="RATINGVALUESADM4">4</label>
                                                <input type="radio" name="PAGE1Q1" id="RATINGVALUESADM3" value="3" />
                                                <label for="RATINGVALUESADM3">3</label>
                                                <input type="radio" name="PAGE1Q1" id="RATINGVALUESADM2" value="2" />
                                                <label for="RATINGVALUESADM2">2</label>
                                                <input type="radio" name="PAGE1Q1" id="RATINGVALUESADM1" value="1" />
                                                <label for="RATINGVALUESADM1">1</label>
                                                <input type="radio" name="PAGE1Q1" id="RATINGVALUESADM0" value="0" />
                                                <label for="RATINGVALUESADM0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESADM10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESADM0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq1" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span style="font-size: 20px; font-weight: bold;">Nurses</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P1Q2" Text="Nurses"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE1Q2" id="RATINGVALUESNUR10" value="10" />
                                                <label for="RATINGVALUESNUR10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE1Q2" id="RATINGVALUESNUR9" value="9" />
                                                <label for="RATINGVALUESNUR9">9</label>
                                                <input type="radio" name="PAGE1Q2" id="RATINGVALUESNUR8" value="8" />
                                                <label for="RATINGVALUESNUR8">8</label>
                                                <input type="radio" name="PAGE1Q2" id="RATINGVALUESNUR7" value="7" />
                                                <label for="RATINGVALUESNUR7">7</label>
                                                <input type="radio" name="PAGE1Q2" id="RATINGVALUESNUR6" value="6" />
                                                <label for="RATINGVALUESNUR6">6</label>
                                                <input type="radio" name="PAGE1Q2" id="RATINGVALUESNUR5" value="5" />
                                                <label for="RATINGVALUESNUR5">5</label>
                                                <input type="radio" name="PAGE1Q2" id="RATINGVALUESNUR4" value="4" />
                                                <label for="RATINGVALUESNUR4">4</label>
                                                <input type="radio" name="PAGE1Q2" id="RATINGVALUESNUR3" value="3" />
                                                <label for="RATINGVALUESNUR3">3</label>
                                                <input type="radio" name="PAGE1Q2" id="RATINGVALUESNUR2" value="2" />
                                                <label for="RATINGVALUESNUR2">2</label>
                                                <input type="radio" name="PAGE1Q2" id="RATINGVALUESNUR1" value="1" />
                                                <label for="RATINGVALUESNUR1">1</label>
                                                <input type="radio" name="PAGE1Q2" id="RATINGVALUESNUR0" value="0" />
                                                <label for="RATINGVALUESNUR0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESNUR10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESNUR0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq1" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--	<span style="font-size: 20px; font-weight: bold;">Care Taken In OT</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P1Q3" Text="Care Taken In OT"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE1Q3" id="RATINGVALUESCTI10" value="10" />
                                                <label for="RATINGVALUESCTI10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE1Q3" id="RATINGVALUESCTI9" value="9" />
                                                <label for="RATINGVALUESCTI9">9</label>
                                                <input type="radio" name="PAGE1Q3" id="RATINGVALUESCTI8" value="8" />
                                                <label for="RATINGVALUESNUR8">8</label>
                                                <input type="radio" name="PAGE1Q3" id="RATINGVALUESCTI7" value="7" />
                                                <label for="RATINGVALUESCTI7">7</label>
                                                <input type="radio" name="PAGE1Q3" id="RATINGVALUESCTI6" value="6" />
                                                <label for="RATINGVALUESCTI6">6</label>
                                                <input type="radio" name="PAGE1Q3" id="RATINGVALUESCTI5" value="5" />
                                                <label for="RATINGVALUESCTI5">5</label>
                                                <input type="radio" name="PAGE1Q3" id="RATINGVALUESCTI4" value="4" />
                                                <label for="RATINGVALUESCTI4">4</label>
                                                <input type="radio" name="PAGE1Q3" id="RATINGVALUESCTI3" value="3" />
                                                <label for="RATINGVALUESCTI3">3</label>
                                                <input type="radio" name="PAGE1Q3" id="RATINGVALUESCTI2" value="2" />
                                                <label for="RATINGVALUESCTI2">2</label>
                                                <input type="radio" name="PAGE1Q3" id="RATINGVALUESCTI1" value="1" />
                                                <label for="RATINGVALUESCTI1">1</label>
                                                <input type="radio" name="PAGE1Q3" id="RATINGVALUESCTI0" value="0" />
                                                <label for="RATINGVALUESCTI0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESCTI10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESCTI0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq1" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--	<span style="font-size: 20px; font-weight: bold;">Doctors Care And Advising In Ward</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P1Q4" Text="Doctors Care And Advising In Ward"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE1Q4" id="RATINGVALUESDCA10" value="10" />
                                                <label for="RATINGVALUESDCA10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE1Q4" id="RATINGVALUESDCA9" value="9" />
                                                <label for="RATINGVALUESDCA9">9</label>
                                                <input type="radio" name="PAGE1Q4" id="RATINGVALUESDCA8" value="8" />
                                                <label for="RATINGVALUESDCA8">8</label>
                                                <input type="radio" name="PAGE1Q4" id="RATINGVALUESDCA7" value="7" />
                                                <label for="RATINGVALUESDCA7">7</label>
                                                <input type="radio" name="PAGE1Q4" id="RATINGVALUESDCA6" value="6" />
                                                <label for="RATINGVALUESDCA6">6</label>
                                                <input type="radio" name="PAGE1Q4" id="RATINGVALUESDCA5" value="5" />
                                                <label for="RATINGVALUESDCA5">5</label>
                                                <input type="radio" name="PAGE1Q4" id="RATINGVALUESDCA4" value="4" />
                                                <label for="RATINGVALUESDCA4">4</label>
                                                <input type="radio" name="PAGE1Q4" id="RATINGVALUESDCA3" value="3" />
                                                <label for="RATINGVALUESDCA3">3</label>
                                                <input type="radio" name="PAGE1Q4" id="RATINGVALUESDCA2" value="2" />
                                                <label for="RATINGVALUESDCA2">2</label>
                                                <input type="radio" name="PAGE1Q4" id="RATINGVALUESDCA1" value="1" />
                                                <label for="RATINGVALUESDCA1">1</label>
                                                <input type="radio" name="PAGE1Q4" id="RATINGVALUESDCA0" value="0" />
                                                <label for="RATINGVALUESDCA0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESDCA10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESDCA0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq5" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <%-- QUESTION NEED TO ADD AREA --%>
                                                <%--<span style="font-size: 20px; font-weight: bold;">Insurance Desk </span>--%>
                                                <asp:Label runat="server" CssClass="QuestionHeading" ID="P1Q5" Text="Insurance Desk "></asp:Label>
                                            </div>
                                            <div class="col-md-6" style="text-align: center;">
                                                <div class="ratingNA">
                                                    <input type="checkbox" name="PAGE1Q5NA" id="RATINGVALUESINSNA" value="NA" onclick="OnNACLICKINS(this);" />
                                                    <label for="RATINGVALUESINSNA" class="NACHANGE">Not Availed</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating" id="INSRATING1TO10Radio">
                                                <input type="radio" name="PAGE1Q5" id="RATINGVALUESINS10" value="10" />
                                                <label for="RATINGVALUESINS10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE1Q5" id="RATINGVALUESINS9" value="9" />
                                                <label for="RATINGVALUESINS9">9</label>
                                                <input type="radio" name="PAGE1Q5" id="RATINGVALUESINS8" value="8" />
                                                <label for="RATINGVALUESINS8">8</label>
                                                <input type="radio" name="PAGE1Q5" id="RATINGVALUESINS7" value="7" />
                                                <label for="RATINGVALUESINS7">7</label>
                                                <input type="radio" name="PAGE1Q5" id="RATINGVALUESINS6" value="6" />
                                                <label for="RATINGVALUESINS6">6</label>
                                                <input type="radio" name="PAGE1Q5" id="RATINGVALUESINS5" value="5" />
                                                <label for="RATINGVALUESINS5">5</label>
                                                <input type="radio" name="PAGE1Q5" id="RATINGVALUESINS4" value="4" />
                                                <label for="RATINGVALUESINS4">4</label>
                                                <input type="radio" name="PAGE1Q5" id="RATINGVALUESINS3" value="3" />
                                                <label for="RATINGVALUESINS3">3</label>
                                                <input type="radio" name="PAGE1Q5" id="RATINGVALUESINS2" value="2" />
                                                <label for="RATINGVALUESINS2">2</label>
                                                <input type="radio" name="PAGE1Q5" id="RATINGVALUESINS1" value="1" />
                                                <label for="RATINGVALUESINS1">1</label>
                                                <input type="radio" name="PAGE1Q5" id="RATINGVALUESINS0" value="0" />
                                                <label for="RATINGVALUESINS0">0</label>
                                            </div>
                                            <div class="ratinglabel" id="INSRATING1TO10Label">
                                                <label for="RATINGVALUESINS10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESINS0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq1" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--	<span style="font-size: 20px; font-weight: bold;">Billing Counter</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P1Q6" Text="Billing Counter"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE1Q6" id="RATINGVALUESBCT10" value="10" />
                                                <label for="RATINGVALUESBCT10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE1Q6" id="RATINGVALUESBCT9" value="9" />
                                                <label for="RATINGVALUESBCT9">9</label>
                                                <input type="radio" name="PAGE1Q6" id="RATINGVALUESBCT8" value="8" />
                                                <label for="RATINGVALUESBCT8">8</label>
                                                <input type="radio" name="PAGE1Q6" id="RATINGVALUESBCT7" value="7" />
                                                <label for="RATINGVALUESBCT7">7</label>
                                                <input type="radio" name="PAGE1Q6" id="RATINGVALUESBCT6" value="6" />
                                                <label for="RATINGVALUESBCT6">6</label>
                                                <input type="radio" name="PAGE1Q6" id="RATINGVALUESBCT5" value="5" />
                                                <label for="RATINGVALUESBCT5">5</label>
                                                <input type="radio" name="PAGE1Q6" id="RATINGVALUESBCT4" value="4" />
                                                <label for="RATINGVALUESBCT4">4</label>
                                                <input type="radio" name="PAGE1Q6" id="RATINGVALUESBCT3" value="3" />
                                                <label for="RATINGVALUESBCT3">3</label>
                                                <input type="radio" name="PAGE1Q6" id="RATINGVALUESBCT2" value="2" />
                                                <label for="RATINGVALUESBCT2">2</label>
                                                <input type="radio" name="PAGE1Q6" id="RATINGVALUESBCT1" value="1" />
                                                <label for="RATINGVALUESBCT1">1</label>
                                                <input type="radio" name="PAGE1Q6" id="RATINGVALUESBCT0" value="0" />
                                                <label for="RATINGVALUESBCT0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESBCT10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESBCT0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq1" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span style="font-size: 20px; font-weight: bold;">Discharge Process</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P1Q7" Text="Discharge Process"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE1Q7" id="RATINGVALUEDCP10" value="10" />
                                                <label for="RATINGVALUEDCP10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE1Q7" id="RATINGVALUEDCP9" value="9" />
                                                <label for="RATINGVALUEDCP9">9</label>
                                                <input type="radio" name="PAGE1Q7" id="RATINGVALUEDCP8" value="8" />
                                                <label for="RATINGVALUEDCP8">8</label>
                                                <input type="radio" name="PAGE1Q7" id="RATINGVALUEDCP7" value="7" />
                                                <label for="RATINGVALUEDCP7">7</label>
                                                <input type="radio" name="PAGE1Q7" id="RATINGVALUEDCP6" value="6" />
                                                <label for="RATINGVALUEDCP6">6</label>
                                                <input type="radio" name="PAGE1Q7" id="RATINGVALUEDCP5" value="5" />
                                                <label for="RATINGVALUEDCP5">5</label>
                                                <input type="radio" name="PAGE1Q7" id="RATINGVALUEDCP4" value="4" />
                                                <label for="RATINGVALUEDCP4">4</label>
                                                <input type="radio" name="PAGE1Q7" id="RATINGVALUEDCP3" value="3" />
                                                <label for="RATINGVALUEDCP3">3</label>
                                                <input type="radio" name="PAGE1Q7" id="RATINGVALUEDCP2" value="2" />
                                                <label for="RATINGVALUEDCP2">2</label>
                                                <input type="radio" name="PAGE1Q7" id="RATINGVALUEDCP1" value="1" />
                                                <label for="RATINGVALUEDCP1">1</label>
                                                <input type="radio" name="PAGE1Q7" id="RATINGVALUEDCP0" value="0" />
                                                <label for="RATINGVALUEDCP0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUEDCP10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUEDCP0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="text-align: center; justify-content: center; margin-top: 2%; margin-bottom: 2%">
                                    <input type="button" class="btn btn-success" value="Proceed" onclick="ToPage1();" />
                                </div>
                            </div>


                            <div id="Page1" style="display: none;">

                               <%-- <div style="display: flex; flex-direction: row; justify-content: space-between;">
                                    <h2 class="fs-title">Feedback</h2>
                                    <p style="font-size: 22px; color: red;">If not used the service select - Not Availed</p>
                                </div>--%>
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
                                                <%--<span style="font-size: 20px; font-weight: bold;">Pharmacy</span>--%>
                                                <asp:Label runat="server" CssClass="QuestionHeading" ID="P2Q1" Text="Pharmacy"></asp:Label>
                                            </div>
                                            <div class="col-md-6" style="text-align: center;">
                                                <div class="ratingNA">
                                                    <input type="checkbox" name="PAGE2Q1NA" id="RATINGVALUESPHANA" value="NA" onclick="OnNACLICKPHA(this);" />
                                                    <label for="RATINGVALUESPHANA" class="NACHANGE">Not Availed</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating" id="PHARATING1TO10Radio">
                                                <input type="radio" name="PAGE2Q1" id="RATINGVALUESPHA10" value="10" />
                                                <label for="RATINGVALUESPHA10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE2Q1" id="RATINGVALUESPHA9" value="9" />
                                                <label for="RATINGVALUESPHA9">9</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESPHA8" value="8" />
                                                <label for="RATINGVALUESPHA8">8</label>
                                                <input type="radio" name="PAGE2Q1" id="RATINGVALUESPHA7" value="7" />
                                                <label for="RATINGVALUESPHA7">7</label>
                                                <input type="radio" name="PAGE2Q1" id="RATINGVALUESPHA6" value="6" />
                                                <label for="RATINGVALUESPHA6">6</label>
                                                <input type="radio" name="PAGE3Q1" id="RATINGVALUESPHA5" value="5" />
                                                <label for="RATINGVALUESPHA5">5</label>
                                                <input type="radio" name="PAGE2Q1" id="RATINGVALUESPHA4" value="4" />
                                                <label for="RATINGVALUESPHA4">4</label>
                                                <input type="radio" name="PAGE2Q1" id="RATINGVALUESPHA3" value="3" />
                                                <label for="RATINGVALUESPHA3">3</label>
                                                <input type="radio" name="PAGE2Q1" id="RATINGVALUESPHA2" value="2" />
                                                <label for="RATINGVALUESPHA2">2</label>
                                                <input type="radio" name="PAGE2Q1" id="RATINGVALUESPHA1" value="1" />
                                                <label for="RATINGVALUESPHA1">1</label>
                                                <input type="radio" name="PAGE2Q1" id="RATINGVALUESPHA0" value="0" />
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
                                    <div class="col-md-6 col-sm-12" id="aq10" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <%-- QUESTION NEED TO ADD AREA --%>
                                                <%--<span style="font-size: 20px; font-weight: bold;">Canteen</span>--%>
                                                <asp:Label runat="server" CssClass="QuestionHeading" ID="P2Q2" Text="Canteen/Cafeteria"></asp:Label>
                                            </div>
                                            <div class="col-md-6" style="text-align: center;">
                                                <div class="ratingNA">
                                                    <input type="checkbox" name="PAGE2Q2NA" id="RATINGVALUESCANNA" value="NA" onclick="OnNACLICKCAN(this);" />
                                                    <label for="RATINGVALUESCANNA" class="NACHANGE">Not Availed</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating" id="CANRATING1TO10Radio">
                                                <input type="radio" name="PAGE2Q2" id="RATINGVALUESCAN10" value="10" />
                                                <label for="RATINGVALUESCAN10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE2Q2" id="RATINGVALUESCAN9" value="9" />
                                                <label for="RATINGVALUESCAN9">9</label>
                                                <input type="radio" name="PAGE2Q2" id="RATINGVALUESCAN8" value="8" />
                                                <label for="RATINGVALUESCAN8">8</label>
                                                <input type="radio" name="PAGE2Q2" id="RATINGVALUESCAN7" value="7" />
                                                <label for="RATINGVALUESCAN7">7</label>
                                                <input type="radio" name="PAGE2Q2" id="RATINGVALUESCAN6" value="6" />
                                                <label for="RATINGVALUESCAN6">6</label>
                                                <input type="radio" name="PAGE2Q2" id="RATINGVALUESCAN5" value="5" />
                                                <label for="RATINGVALUESCAN5">5</label>
                                                <input type="radio" name="PAGE2Q2" id="RATINGVALUESCAN4" value="4" />
                                                <label for="RATINGVALUESCAN4">4</label>
                                                <input type="radio" name="PAGE2Q2" id="RATINGVALUESCAN3" value="3" />
                                                <label for="RATINGVALUESCAN3">3</label>
                                                <input type="radio" name="PAGE2Q2" id="RATINGVALUESCAN2" value="2" />
                                                <label for="RATINGVALUESCAN2">2</label>
                                                <input type="radio" name="PAGE2Q2" id="RATINGVALUESCAN1" value="1" />
                                                <label for="RATINGVALUESCAN1">1</label>
                                                <input type="radio" name="PAGE2Q2" id="RATINGVALUESCAN0" value="0" />
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
                                        <%--<span style="font-size: 20px; font-weight: bold;">Display/Direction Boards</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P2Q3" Text="Display/Direction Boards"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE2Q3" id="RATINGVALUESDDB10" value="10" />
                                                <label for="RATINGVALUESDDB10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE2Q3" id="RATINGVALUESDDB9" value="9" />
                                                <label for="RATINGVALUESDDB9">9</label>
                                                <input type="radio" name="PAGE2Q3" id="RATINGVALUESDDB8" value="8" />
                                                <label for="RATINGVALUESDDB8">8</label>
                                                <input type="radio" name="PAGE2Q3" id="RATINGVALUESDDB7" value="7" />
                                                <label for="RATINGVALUESDDB7">7</label>
                                                <input type="radio" name="PAGE2Q3" id="RATINGVALUESDDB6" value="6" />
                                                <label for="RATINGVALUESDDB6">6</label>
                                                <input type="radio" name="PAGE2Q3" id="RATINGVALUESDDB5" value="5" />
                                                <label for="RATINGVALUESDDB5">5</label>
                                                <input type="radio" name="PAGE2Q3" id="RATINGVALUESDDB4" value="4" />
                                                <label for="RATINGVALUESDDB4">4</label>
                                                <input type="radio" name="PAGE2Q3" id="RATINGVALUESDDB3" value="3" />
                                                <label for="RATINGVALUESDDB3">3</label>
                                                <input type="radio" name="PAGE2Q3" id="RATINGVALUESDDB2" value="2" />
                                                <label for="RATINGVALUESDDB2">2</label>
                                                <input type="radio" name="PAGE2Q3" id="RATINGVALUESDDB1" value="1" />
                                                <label for="RATINGVALUESDDB1">1</label>
                                                <input type="radio" name="PAGE2Q3" id="RATINGVALUESDDB0" value="0" />
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
                                        <%--<span style="font-size: 20px; font-weight: bold;">Security</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P2Q4" Text="Security"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE2Q4" id="RATINGVALUESSCE10" value="10" />
                                                <label for="RATINGVALUESSCE10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE2Q4" id="RATINGVALUESSCE9" value="9" />
                                                <label for="RATINGVALUESSCE9">9</label>
                                                <input type="radio" name="PAGE2Q4" id="RATINGVALUESSCE8" value="8" />
                                                <label for="RATINGVALUESSCE8">8</label>
                                                <input type="radio" name="PAGE2Q4" id="RATINGVALUESSCE7" value="7" />
                                                <label for="RATINGVALUESSCE7">7</label>
                                                <input type="radio" name="PAGE2Q4" id="RATINGVALUESSCE6" value="6" />
                                                <label for="RATINGVALUESSCE6">6</label>
                                                <input type="radio" name="PAGE2Q4" id="RATINGVALUESSCE5" value="5" />
                                                <label for="RATINGVALUESSCE5">5</label>
                                                <input type="radio" name="PAGE2Q4" id="RATINGVALUESSCE4" value="4" />
                                                <label for="RATINGVALUESSCE4">4</label>
                                                <input type="radio" name="PAGE2Q4" id="RATINGVALUESSCE3" value="3" />
                                                <label for="RATINGVALUESSCE3">3</label>
                                                <input type="radio" name="PAGE2Q4" id="RATINGVALUESSCE2" value="2" />
                                                <label for="RATINGVALUESSCE2">2</label>
                                                <input type="radio" name="PAGE2Q4" id="RATINGVALUESSCE1" value="1" />
                                                <label for="RATINGVALUESSCE1">1</label>
                                                <input type="radio" name="PAGE2Q4" id="RATINGVALUESSCE0" value="0" />
                                                <label for="RATINGVALUESSCE0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESSCE10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESSCE0">Poor</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" id="aq12" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span style="font-size: 20px; font-weight: bold;">Overall Cleanliness</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P2Q5" Text="Overall Cleanliness"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE2Q5" id="RATINGVALUESOVC10" value="10" />
                                                <label for="RATINGVALUESOVC10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE2Q5" id="RATINGVALUESOVC9" value="9" />
                                                <label for="RATINGVALUESOVC9">9</label>
                                                <input type="radio" name="PAGE2Q5" id="RATINGVALUESOVC8" value="8" />
                                                <label for="RATINGVALUESOVC8">8</label>
                                                <input type="radio" name="PAGE2Q5" id="RATINGVALUESOVC7" value="7" />
                                                <label for="RATINGVALUESOVC7">7</label>
                                                <input type="radio" name="PAGE2Q5" id="RATINGVALUESOVC6" value="6" />
                                                <label for="RATINGVALUESOVC6">6</label>
                                                <input type="radio" name="PAGE2Q5" id="RATINGVALUESOVC5" value="5" />
                                                <label for="RATINGVALUESOVC5">5</label>
                                                <input type="radio" name="PAGE2Q5" id="RATINGVALUESOVC4" value="4" />
                                                <label for="RATINGVALUESOVC4">4</label>
                                                <input type="radio" name="PAGE2Q5" id="RATINGVALUESOVC3" value="3" />
                                                <label for="RATINGVALUESOVC3">3</label>
                                                <input type="radio" name="PAGE2Q5" id="RATINGVALUESOVC2" value="2" />
                                                <label for="RATINGVALUESOVC2">2</label>
                                                <input type="radio" name="PAGE2Q5" id="RATINGVALUESOVC1" value="1" />
                                                <label for="RATINGVALUESOVC1">1</label>
                                                <input type="radio" name="PAGE2Q5" id="RATINGVALUESOVC0" value="0" />
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
                                        <%--<span style="font-size: 20px; font-weight: bold;">Overall Rating Of Sankara Nethralaya</span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P2Q6" Text="Overall Rating Of Sankara Nethralaya"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <div class="rating">
                                                <input type="radio" name="PAGE2Q6" id="RATINGVALUESOVLL10" value="10" />
                                                <label for="RATINGVALUESOVLL10" class="bordercheck">10</label>
                                                <input type="radio" name="PAGE2Q6" id="RATINGVALUESOVLL9" value="9" />
                                                <label for="RATINGVALUESOVLL9">9</label>
                                                <input type="radio" name="PAGE2Q6" id="RATINGVALUESOVLL8" value="8" />
                                                <label for="RATINGVALUESOVLL8">8</label>
                                                <input type="radio" name="PAGE2Q6" id="RATINGVALUESOVLL7" value="7" />
                                                <label for="RATINGVALUESOVLL7">7</label>
                                                <input type="radio" name="PAGE2Q6" id="RATINGVALUESOVLL6" value="6" />
                                                <label for="RATINGVALUESOVLL6">6</label>
                                                <input type="radio" name="PAGE2Q6" id="RATINGVALUESOVLL5" value="5" />
                                                <label for="RATINGVALUESOVLL5">5</label>
                                                <input type="radio" name="PAGE2Q6" id="RATINGVALUESOVLL4" value="4" />
                                                <label for="RATINGVALUESOVLL4">4</label>
                                                <input type="radio" name="PAGE2Q6" id="RATINGVALUESOVLL3" value="3" />
                                                <label for="RATINGVALUESOVLL3">3</label>
                                                <input type="radio" name="PAGE2Q6" id="RATINGVALUESOVLL2" value="2" />
                                                <label for="RATINGVALUESOVLL2">2</label>
                                                <input type="radio" name="PAGE2Q6" id="RATINGVALUESOVLL1" value="1" />
                                                <label for="RATINGVALUESOVLL1">1</label>
                                                <input type="radio" name="PAGE2Q6" id="RATINGVALUESOVLL0" value="0" />
                                                <label for="RATINGVALUESOVLL0">0</label>
                                            </div>
                                            <div class="ratinglabel">
                                                <label for="RATINGVALUESOVLL10" class="Makeitend">Excellent</label>
                                                <label for="RATINGVALUESOVLL0">Poor</label>
                                            </div>
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
                                        <%--<span style="font-size: 20px; font-weight: bold;">Reason For Choosing Our Hospital? </span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P1Q0" Text="Reason For Choosing Our Hospital?"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <%--<select class="form-control" id="RFORHVDDL" runat="server" name="reasonchoose">
												<option value="" selected="selected">Select</option>
												<option value="Referred By Doctor">Referred By Doctor</option>
												<option value="Word Of Mouth">Word Of Mouth</option>
												<option value="Old Patient">Old Patient</option>
												<option value="Social Media">Social Media</option>
												<option value="Closer To My House">Closer To My House</option>
											</select>--%>
                                            <asp:RadioButtonList ID="RFORHVDDL" runat="server" RepeatDirection="Horizontal" class="button-checkbox CssClass">
                                                <asp:ListItem Value="Referred By Doctor">Referred By Doctor</asp:ListItem>
                                                <asp:ListItem Value="Word Of Mouth">Word Of Mouth</asp:ListItem>
                                                <asp:ListItem Value="Old Patient">Old Patient</asp:ListItem>
                                                <asp:ListItem Value="Social Media">Social Media</asp:ListItem>
                                                <asp:ListItem Value="Closer To My House">Closer To My House</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span style="font-size: 20px; font-weight: bold;">Will You Recommend Our Hospital To Others? </span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P3Q1" Text="Will You Recommend Our Hospital To Others?"></asp:Label>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            <%--<select class="form-control" runat="server" id="Recommed" name="recommedchoose">
												<option value="" selected="selected">-- SELECT--</option>
												<option value="Yes">Yes</option>
												<option value="No">No</option>
											</select>--%>

                                            <asp:RadioButtonList ID="Recommed" runat="server" RepeatDirection="Horizontal" class="button-checkbox CssClass">
                                                <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                                <asp:ListItem Value="No">No</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--	<span style="font-size: 20px; font-weight: bold;">Appreciation If Any </span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P3Q2" Text="Appreciation If Any"></asp:Label>
                                        <span style="font-size: 12px;">(Maximum characters: 2000)<br />
                                            You have
                                            <input readonly type="text" id="countdownapp" name="countdownapp" size="4" value="2000">
                                            characters left.</span>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <%-- STAR NEED TO ADD AREA --%>
                                        <div class="row" style="margin: 0%;">
                                            ​<textarea id="txtappreciation" class="form-control" onkeyup="limitTextApp(this,2000);this.value=this.value.replace(/[^a-zA-Z,.,,,:, ]/g,'');"
                                                onkeydown="limitTextApp(this,2000);" runat="server" rows="2" cols="70"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="row" style="margin: 0%;">
                                    <div class="col-md-6 col-sm-12" style="margin-bottom: 3%; justify-content: center; margin-top: 1%;">
                                        <%-- QUESTION NEED TO ADD AREA --%>
                                        <%--<span style="font-size: 20px; font-weight: bold;">Leave Your Valuable Suggestion For Our Improvement To Serve You Better: </span>--%>
                                        <asp:Label runat="server" CssClass="QuestionHeading" ID="P3Q3" Text="Leave Your Valuable Suggestion For Our Improvement To Serve You Better:"></asp:Label>
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
                                    <asp:Button ID="Save" runat="server" class="btn btn-success pull-left" type="submit" OnClick="Save_Click" Text="Save" Style="display: none;" />
                                </div>
                            </div>


                            <div id="Page3" style="display: none;">

                                <div class="row" style="text-align: center; justify-content: center; margin-top: 2%; margin-bottom: 2%;">
                                    <input type="button" class="btn btn-info" value="Previous" onclick="Page3ChecktoPage2();" />


                                </div>
                            </div>


                            <div id="Page4" style="display: none;">
                                <div class="row" style="margin: 0%;">
                                    <h2 class="fs-title text-center">Success !</h2>
                                    <br />
                                    <br />
                                    <div class="row justify-content-center">
                                        <div style="text-align: center;">
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
                            <div id="Page5" style="display: none;">
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
                        <asp:HiddenField ID="HNDOPP1Q0" runat="server" />
                        <asp:HiddenField ID="HNDOPP1Q1" runat="server" />
                        <asp:HiddenField ID="HNDOPP1Q2" runat="server" />
                        <asp:HiddenField ID="HNDOPP1Q3" runat="server" />
                        <asp:HiddenField ID="HNDOPP1Q4" runat="server" />
                        <asp:HiddenField ID="HNDOPP1Q5" runat="server" />
                        <asp:HiddenField ID="HNDOPP1Q6" runat="server" />
                        <asp:HiddenField ID="HNDOPP1Q7" runat="server" />
                        <asp:HiddenField ID="HNDOPP2Q1" runat="server" />
                        <asp:HiddenField ID="HNDOPP2Q2" runat="server" />
                        <asp:HiddenField ID="HNDOPP2Q3" runat="server" />
                        <asp:HiddenField ID="HNDOPP2Q4" runat="server" />
                        <asp:HiddenField ID="HNDOPP2Q5" runat="server" />
                        <asp:HiddenField ID="HNDOPP2Q6" runat="server" />
                        <asp:HiddenField ID="HNDOPP3Q1" runat="server" />
                        <asp:HiddenField ID="HNDOPP3Q2" runat="server" />
                        <asp:HiddenField ID="HNDOPP3Q3" runat="server" />
                        <asp:HiddenField ID="HNDPATIPID" runat="server" />
                    </div>
                </div>
            </div>
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

        <script type="text/javascript">
            function LoadPatPageDtls(InputDtls) {
                if (InputDtls === "Completed") {
                    document.getElementById("Page0HomeMenu").style.display = "none";
                    document.getElementById("Page1").style.display = "none";
                    document.getElementById("Page2").style.display = "none";
                    document.getElementById("Page3").style.display = "none";
                    document.getElementById("Page4").style.display = "block";
                    document.getElementById("Page5").style.display = "none";
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
                    document.getElementById("Page5").style.display = "block";
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
                    document.getElementById("UserMsgDiv").style.display = "none";
                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
                    $("#MasterCoverScreen").hide();
                }
                else if (InputDtls === "ErrorMsg") {
                    document.getElementById("Page0HomeMenu").style.display = "none";
                    document.getElementById("Page1").style.display = "none";
                    document.getElementById("Page2").style.display = "none";
                    document.getElementById("Page3").style.display = "none";
                    document.getElementById("Page4").style.display = "none";
                    document.getElementById("Page5").style.display = "none";
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
                    document.getElementById("UserMsgDiv").style.display = "block";
                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "please check the URL or link expired";
                    $("#MasterCoverScreen").hide();
                }
            }


            function ToPage1() {
                var DatadtlsofSelectedPAGE1Q1 = document.getElementsByName("PAGE1Q1");
                var DatadtlsofSelectedPAGE1Q2 = document.getElementsByName("PAGE1Q2");
                var DatadtlsofSelectedPAGE1Q3 = document.getElementsByName("PAGE1Q3");
                var DatadtlsofSelectedPAGE1Q4 = document.getElementsByName("PAGE1Q4");
                var DatadtlsofSelectedPAGE1Q5 = document.getElementsByName("PAGE1Q5");
                var DatadtlsofSelectedPAGE1Q6 = document.getElementsByName("PAGE1Q6");
                var DatadtlsofSelectedPAGE1Q7 = document.getElementsByName("PAGE1Q7");

                var DataofSelectedPAGE1Q1 = "";
                var DataofSelectedPAGE1Q2 = "";
                var DataofSelectedPAGE1Q3 = "";
                var DataofSelectedPAGE1Q4 = "";
                var DataofSelectedPAGE1Q5 = "";
                var DataofSelectedPAGE1Q6 = "";
                var DataofSelectedPAGE1Q7 = "";

                for (var i = 0; i < DatadtlsofSelectedPAGE1Q1.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q1[i].checked) {
                        DataofSelectedPAGE1Q1 = DatadtlsofSelectedPAGE1Q1[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q2.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q2[i].checked) {
                        DataofSelectedPAGE1Q2 = DatadtlsofSelectedPAGE1Q2[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q3.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q3[i].checked) {
                        DataofSelectedPAGE1Q3 = DatadtlsofSelectedPAGE1Q3[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q4.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q4[i].checked) {
                        DataofSelectedPAGE1Q4 = DatadtlsofSelectedPAGE1Q4[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q5.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q5[i].checked) {
                        DataofSelectedPAGE1Q5 = DatadtlsofSelectedPAGE1Q5[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q6.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q6[i].checked) {
                        DataofSelectedPAGE1Q6 = DatadtlsofSelectedPAGE1Q6[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q7.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q7[i].checked) {
                        DataofSelectedPAGE1Q7 = DatadtlsofSelectedPAGE1Q7[i].value;
                    }
                }
                var GETDTLSNAINS = document.getElementById("RATINGVALUESINSNA");
                var FINALINSCHECKFLAG = "N";
                if (GETDTLSNAINS.checked) {
                    document.getElementById("<%=HNDOPP1Q5.ClientID%>").value = "Not Availed";
                    FINALINSCHECKFLAG = "Y";
                }
                else if (DataofSelectedPAGE1Q5 != "" && DataofSelectedPAGE1Q5 != "undefined" && DataofSelectedPAGE1Q5 != null) {
                    document.getElementById("<%=HNDOPP1Q5.ClientID%>").value = DataofSelectedPAGE1Q5;
                    FINALINSCHECKFLAG = "Y";
                }
                else {
                    document.getElementById("<%=HNDOPP1Q5.ClientID%>").value = "";
                    FINALINSCHECKFLAG = "N";
                }


                if (DataofSelectedPAGE1Q1 != "" && DataofSelectedPAGE1Q1 != "undefined" && DataofSelectedPAGE1Q1 != null) {
                    document.getElementById("<%=HNDOPP1Q1.ClientID%>").value = DataofSelectedPAGE1Q1;
                    if (DataofSelectedPAGE1Q2 != "" && DataofSelectedPAGE1Q2 != "undefined" && DataofSelectedPAGE1Q2 != null) {
                        document.getElementById("<%=HNDOPP1Q2.ClientID%>").value = DataofSelectedPAGE1Q2;
                            if (DataofSelectedPAGE1Q3 != "" && DataofSelectedPAGE1Q3 != "undefined" && DataofSelectedPAGE1Q3 != null) {
                                document.getElementById("<%=HNDOPP1Q3.ClientID%>").value = DataofSelectedPAGE1Q3;
                                if (DataofSelectedPAGE1Q4 != "" && DataofSelectedPAGE1Q4 != "undefined" && DataofSelectedPAGE1Q4 != null) {
                                    document.getElementById("<%=HNDOPP1Q4.ClientID%>").value = DataofSelectedPAGE1Q4;
                                    if (FINALINSCHECKFLAG === "Y") {
                                        if (DataofSelectedPAGE1Q6 != "" && DataofSelectedPAGE1Q6 != "undefined" && DataofSelectedPAGE1Q6 != null) {
                                            document.getElementById("<%=HNDOPP1Q6.ClientID%>").value = DataofSelectedPAGE1Q6;
                                            if (DataofSelectedPAGE1Q7 != "" && DataofSelectedPAGE1Q7 != "undefined" && DataofSelectedPAGE1Q7 != null) {
                                                document.getElementById("<%=HNDOPP1Q7.ClientID%>").value = DataofSelectedPAGE1Q7;

                                                document.getElementById("Page0HomeMenu").style.display = "none";
                                                document.getElementById("Page1").style.display = "block";
                                                document.getElementById("UserMsgDiv").style.display = "none";
                                                document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
                                            }
                                            else {
                                                //alert(" Please select Discharge Process ");
                                                document.getElementById("UserMsgDiv").style.display = "block";
                                                document.getElementById("<%=warninglabel.ClientID%>").innerHTML = " Please select Discharge Process Rating ";
                                            }

                                        }
                                        else {
                                            //alert(" Please select Billing Counter ");
                                            document.getElementById("UserMsgDiv").style.display = "block";
                                            document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Billing Counter Rating";
                                        }

                                    }
                                    else {
                                        //alert(" Please select Insurance Desk ");
                                        document.getElementById("UserMsgDiv").style.display = "block";
                                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Insurance Desk  or not availed ";
                                    }

                                }
                                else {
                                    //alert("Please select Doctors Care And Advising In Ward ");
                                    document.getElementById("UserMsgDiv").style.display = "block";
                                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Doctors Care And Advising In Ward Rating";
                                }

                            }
                            else {
                                //alert("Please select Care Taken In OT ");
                                document.getElementById("UserMsgDiv").style.display = "block";
                                document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Care Taken In OT Rating ";
                            }

                        }
                        else {
                            //alert("Please select Nurses ");
                            document.getElementById("UserMsgDiv").style.display = "block";
                            document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Nurses Rating";
                    }
                }
                else {
                    //alert("Please select Admissions");
                    document.getElementById("UserMsgDiv").style.display = "block";
                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Admissions Rating";
                }


            }

            function HomeMenu() {
                document.getElementById("Page0HomeMenu").style.display = "block";
                document.getElementById("Page1").style.display = "none";
                document.getElementById("UserMsgDiv").style.display = "none";
                document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
            }


            function Page1ChecktoPage2() {
                var DatadtlsofSelectedPAGE2Q1 = document.getElementsByName("PAGE2Q1");
                var DatadtlsofSelectedPAGE2Q2 = document.getElementsByName("PAGE2Q2");
                var DatadtlsofSelectedPAGE2Q3 = document.getElementsByName("PAGE2Q3");
                var DatadtlsofSelectedPAGE2Q4 = document.getElementsByName("PAGE2Q4");
                var DatadtlsofSelectedPAGE2Q5 = document.getElementsByName("PAGE2Q5");
                var DatadtlsofSelectedPAGE2Q6 = document.getElementsByName("PAGE2Q6");

                var DataofSelectedPAGE2Q1 = "";
                var DataofSelectedPAGE2Q2 = "";
                var DataofSelectedPAGE2Q3 = "";
                var DataofSelectedPAGE2Q4 = "";
                var DataofSelectedPAGE2Q5 = "";
                var DataofSelectedPAGE2Q6 = "";

                for (var i = 0; i < DatadtlsofSelectedPAGE2Q1.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q1[i].checked) {
                        DataofSelectedPAGE2Q1 = DatadtlsofSelectedPAGE2Q1[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE2Q2.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q2[i].checked) {
                        DataofSelectedPAGE2Q2 = DatadtlsofSelectedPAGE2Q2[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE2Q3.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q3[i].checked) {
                        DataofSelectedPAGE2Q3 = DatadtlsofSelectedPAGE2Q3[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE2Q4.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q4[i].checked) {
                        DataofSelectedPAGE2Q4 = DatadtlsofSelectedPAGE2Q4[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE2Q5.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q5[i].checked) {
                        DataofSelectedPAGE2Q5 = DatadtlsofSelectedPAGE2Q5[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE2Q6.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q6[i].checked) {
                        DataofSelectedPAGE2Q6 = DatadtlsofSelectedPAGE2Q6[i].value;
                    }
                }

                var GETDTLSNAPHA = document.getElementById("RATINGVALUESPHANA");
                var FINALPHSCHECKFLAG = "N";
                if (GETDTLSNAPHA.checked) {
                    document.getElementById("<%=HNDOPP2Q1.ClientID%>").value = "Not Availed";
                    FINALPHSCHECKFLAG = "Y";

                }
                else if (DataofSelectedPAGE2Q1 != "" && DataofSelectedPAGE2Q1 != "undefined" && DataofSelectedPAGE2Q1 != null) {
                    document.getElementById("<%=HNDOPP2Q1.ClientID%>").value = DataofSelectedPAGE2Q1;
                    FINALPHSCHECKFLAG = "Y";
                }
                else {
                    document.getElementById("<%=HNDOPP2Q1.ClientID%>").value = "";
                    FINALPHSCHECKFLAG = "N";
                }
                var GETDTLSNACAN = document.getElementById("RATINGVALUESCANNA");
                var FINALCANCHECKFLAG = "N";
                if (GETDTLSNACAN.checked) {
                    document.getElementById("<%=HNDOPP2Q2.ClientID%>").value = "Not Availed";
                    FINALCANCHECKFLAG = "Y";
                }
                else if (DataofSelectedPAGE2Q2 != "" && DataofSelectedPAGE2Q2 != "undefined" && DataofSelectedPAGE2Q2 != null) {
                    document.getElementById("<%=HNDOPP2Q2.ClientID%>").value = DataofSelectedPAGE2Q2;
                    FINALCANCHECKFLAG = "Y";
                }
                else {
                    document.getElementById("<%=HNDOPP2Q2.ClientID%>").value = "";
                    FINALCANCHECKFLAG = "N";
                }
                if (FINALPHSCHECKFLAG === "Y") {
                    if (FINALCANCHECKFLAG === "Y") {
                        if (DataofSelectedPAGE2Q3 != "" && DataofSelectedPAGE2Q3 != "undefined" && DataofSelectedPAGE2Q3 != null) {
                            document.getElementById("<%=HNDOPP2Q3.ClientID%>").value = DataofSelectedPAGE2Q3;
                            if (DataofSelectedPAGE2Q4 != "" && DataofSelectedPAGE2Q4 != "undefined" && DataofSelectedPAGE2Q4 != null) {
                                document.getElementById("<%=HNDOPP2Q4.ClientID%>").value = DataofSelectedPAGE2Q4;
                                if (DataofSelectedPAGE2Q5 != "" && DataofSelectedPAGE2Q5 != "undefined" && DataofSelectedPAGE2Q5 != null) {
                                    document.getElementById("<%=HNDOPP2Q5.ClientID%>").value = DataofSelectedPAGE2Q5;
                                    if (DataofSelectedPAGE2Q6 != "" && DataofSelectedPAGE2Q6 != "undefined" && DataofSelectedPAGE2Q6 != null) {
                                        document.getElementById("<%=HNDOPP2Q6.ClientID%>").value = DataofSelectedPAGE2Q6;
                                        document.getElementById("Page1").style.display = "none";
                                        document.getElementById("Page2").style.display = "block";
                                        document.getElementById("UserMsgDiv").style.display = "none";
                                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "";
                                    }
                                    else {
                                        //alert("6");
                                        document.getElementById("UserMsgDiv").style.display = "block";
                                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = " Please select Overall Rating Of Sankara Nethralaya";
                                    }

                                }
                                else {
                                    //alert("5");
                                    document.getElementById("UserMsgDiv").style.display = "block";
                                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = " Please select Overall Cleanliness ";
                                }

                            }
                            else {
                                //alert("4");
                                document.getElementById("UserMsgDiv").style.display = "block";
                                document.getElementById("<%=warninglabel.ClientID%>").innerHTML = " Please select Security ";
                            }

                        }
                        else {
                            //alert("3");
                            document.getElementById("UserMsgDiv").style.display = "block";
                            document.getElementById("<%=warninglabel.ClientID%>").innerHTML = " Please select Display/Direction Boards ";
                        }

                    }
                    else {
                        //alert("2");
                        document.getElementById("UserMsgDiv").style.display = "block";
                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = " Please select Canteen or not availed ";
                    }

                }
                else {
                    //alert("1");
                    document.getElementById("UserMsgDiv").style.display = "block";
                    document.getElementById("<%=warninglabel.ClientID%>").innerHTML = " Please select Pharmacy or not availed";
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
                var SelectedValueREC = $('input[name="<%= Recommed.ClientID %>"]:checked').val();

                if (typeof SelectedValueRFORHV !== "undefined" && SelectedValueRFORHV !== null && SelectedValueRFORHV !== "") {
                    document.getElementById("<%=HNDOPP1Q0.ClientID%>").value = SelectedValueRFORHV;

                    if (typeof SelectedValueREC !== "undefined" && SelectedValueREC !== null && SelectedValueREC !== "") {
                        document.getElementById("<%=HNDOPP3Q1.ClientID%>").value = SelectedValueREC;

                        document.getElementById("<%=HNDOPP3Q2.ClientID%>").value = document.getElementById("<%=txtappreciation.ClientID%>").value;
                        document.getElementById("<%=HNDOPP3Q3.ClientID%>").value = document.getElementById("<%=txtsuggestion.ClientID%>").value;
                        document.getElementById("Page3").style.display = "none";
                        var Q1Check = document.getElementById("<%=HNDOPP1Q0.ClientID%>").value;
                        var Q2Check = document.getElementById("<%=HNDOPP1Q1.ClientID%>").value;
                        var Q3Check = document.getElementById("<%=HNDOPP1Q2.ClientID%>").value;
                        var Q4Check = document.getElementById("<%=HNDOPP1Q3.ClientID%>").value;
                        var Q5Check = document.getElementById("<%=HNDOPP1Q4.ClientID%>").value;
                        var Q6Check = document.getElementById("<%=HNDOPP1Q5.ClientID%>").value;
                        var Q7Check = document.getElementById("<%=HNDOPP1Q6.ClientID%>").value;
                        var Q8Check = document.getElementById("<%=HNDOPP1Q7.ClientID%>").value;
                        var Q9Check = document.getElementById("<%=HNDOPP2Q1.ClientID%>").value;
                        var Q10Check = document.getElementById("<%=HNDOPP2Q2.ClientID%>").value;
                        var Q11Check = document.getElementById("<%=HNDOPP2Q3.ClientID%>").value;
                        var Q12Check = document.getElementById("<%=HNDOPP2Q4.ClientID%>").value;
                        var Q13Check = document.getElementById("<%=HNDOPP2Q5.ClientID%>").value;
                        var Q14Check = document.getElementById("<%=HNDOPP2Q6.ClientID%>").value;
                        var Q15Check = document.getElementById("<%=HNDOPP3Q1.ClientID%>").value;
                        var Q16Check = document.getElementById("<%=HNDOPP3Q2.ClientID%>").value;
                        var Q17Check = document.getElementById("<%=HNDOPP3Q3.ClientID%>").value;
                        var APIPIDCheck = document.getElementById("<%=HNDPATIPID.ClientID%>").value;
                        if (Q1Check !== "" && Q1Check !== null && Q2Check !== "" && Q2Check !== null && Q3Check !== "" && Q3Check !== null
                            && Q4Check !== "" && Q4Check !== null && Q5Check !== "" && Q5Check !== null && Q6Check !== "" && Q6Check !== null
                            && Q7Check !== "" && Q7Check !== null && Q8Check !== "" && Q8Check !== null && Q9Check !== "" && Q9Check !== null
                            && Q10Check !== "" && Q10Check !== null && Q11Check !== "" && Q11Check !== null && Q12Check !== "" && Q12Check !== null
                            && Q13Check !== "" && Q13Check !== null && Q14Check !== "" && Q14Check !== null && Q15Check !== "" && Q15Check !== null
                            && APIPIDCheck !== "" && APIPIDCheck !== null) {
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
                        document.getElementById("<%=warninglabel.ClientID%>").innerHTML = "Please select Will You Recommend Our Hospital To Others?";
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
            function Page3ChecktoSaveMode() {


            }

            function OnNACLICKINS(Dtls) {
                if ($(Dtls).is(":checked")) {
                    document.getElementById("INSRATING1TO10Radio").style.display = "none";
                    document.getElementById("INSRATING1TO10Label").style.display = "none";
                } else {
                    document.getElementById("INSRATING1TO10Radio").style.display = "flex";
                    document.getElementById("INSRATING1TO10Label").style.display = "flex";

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
                var DatadtlsofSelectedPAGE1Q1 = document.getElementsByName("PAGE1Q1");
                var DatadtlsofSelectedPAGE1Q2 = document.getElementsByName("PAGE1Q2");
                var DatadtlsofSelectedPAGE1Q3 = document.getElementsByName("PAGE1Q3");
                var DatadtlsofSelectedPAGE1Q4 = document.getElementsByName("PAGE1Q4");
                var DatadtlsofSelectedPAGE1Q5 = document.getElementsByName("PAGE1Q5");
                var DatadtlsofSelectedPAGE1Q6 = document.getElementsByName("PAGE1Q6");
                var DatadtlsofSelectedPAGE1Q7 = document.getElementsByName("PAGE1Q7");
                var DatadtlsofSelectedPAGE2Q1 = document.getElementsByName("PAGE2Q1");
                var DatadtlsofSelectedPAGE2Q2 = document.getElementsByName("PAGE2Q2");
                var DatadtlsofSelectedPAGE2Q3 = document.getElementsByName("PAGE2Q3");
                var DatadtlsofSelectedPAGE2Q4 = document.getElementsByName("PAGE2Q4");
                var DatadtlsofSelectedPAGE2Q5 = document.getElementsByName("PAGE2Q5");
                var DatadtlsofSelectedPAGE2Q6 = document.getElementsByName("PAGE2Q6");


                var DataofSelectedPAGE1Q1 = "";
                var DataofSelectedPAGE1Q2 = "";
                var DataofSelectedPAGE1Q3 = "";
                var DataofSelectedPAGE1Q4 = "";
                var DataofSelectedPAGE1Q5 = "";
                var DataofSelectedPAGE1Q6 = "";
                var DataofSelectedPAGE1Q7 = "";
                var DataofSelectedPAGE2Q1 = "";
                var DataofSelectedPAGE2Q2 = "";
                var DataofSelectedPAGE2Q3 = "";
                var DataofSelectedPAGE2Q4 = "";
                var DataofSelectedPAGE2Q5 = "";
                var DataofSelectedPAGE2Q6 = "";

                for (var i = 0; i < DatadtlsofSelectedPAGE1Q1.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q1[i].checked) {
                        DataofSelectedPAGE1Q1 = DatadtlsofSelectedPAGE1Q1[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q2.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q2[i].checked) {
                        DataofSelectedPAGE1Q2 = DatadtlsofSelectedPAGE1Q2[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q3.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q3[i].checked) {
                        DataofSelectedPAGE1Q3 = DatadtlsofSelectedPAGE1Q3[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q4.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q4[i].checked) {
                        DataofSelectedPAGE1Q4 = DatadtlsofSelectedPAGE1Q4[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q5.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q5[i].checked) {
                        DataofSelectedPAGE1Q5 = DatadtlsofSelectedPAGE1Q5[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q6.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q6[i].checked) {
                        DataofSelectedPAGE1Q6 = DatadtlsofSelectedPAGE1Q6[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE1Q7.length; i++) {
                    if (DatadtlsofSelectedPAGE1Q7[i].checked) {
                        DataofSelectedPAGE1Q7 = DatadtlsofSelectedPAGE1Q7[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE2Q1.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q1[i].checked) {
                        DataofSelectedPAGE2Q1 = DatadtlsofSelectedPAGE2Q1[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE2Q2.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q2[i].checked) {
                        DataofSelectedPAGE2Q2 = DatadtlsofSelectedPAGE2Q2[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE2Q3.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q3[i].checked) {
                        DataofSelectedPAGE2Q3 = DatadtlsofSelectedPAGE2Q3[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE2Q4.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q4[i].checked) {
                        DataofSelectedPAGE2Q4 = DatadtlsofSelectedPAGE2Q4[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE2Q5.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q5[i].checked) {
                        DataofSelectedPAGE2Q5 = DatadtlsofSelectedPAGE2Q5[i].value;
                    }
                }
                for (var i = 0; i < DatadtlsofSelectedPAGE2Q6.length; i++) {
                    if (DatadtlsofSelectedPAGE2Q6[i].checked) {
                        DataofSelectedPAGE2Q6 = DatadtlsofSelectedPAGE2Q6[i].value;
                    }
                }


                if (DataofSelectedPAGE1Q1 != "" && DataofSelectedPAGE1Q1 != "undefined" && DataofSelectedPAGE1Q1 != null) {
                    alert(DataofSelectedPAGE1Q1);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE1Q2 != "" && DataofSelectedPAGE1Q2 != "undefined" && DataofSelectedPAGE1Q2 != null) {
                    alert(DataofSelectedPAGE1Q2);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE1Q3 != "" && DataofSelectedPAGE1Q3 != "undefined" && DataofSelectedPAGE1Q3 != null) {
                    alert(DataofSelectedPAGE1Q3);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE1Q4 != "" && DataofSelectedPAGE1Q4 != "undefined" && DataofSelectedPAGE1Q4 != null) {
                    alert(DataofSelectedPAGE1Q4);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE1Q5 != "" && DataofSelectedPAGE1Q5 != "undefined" && DataofSelectedPAGE1Q5 != null) {
                    alert(DataofSelectedPAGE1Q5);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE1Q6 != "" && DataofSelectedPAGE1Q6 != "undefined" && DataofSelectedPAGE1Q6 != null) {
                    alert(DataofSelectedPAGE1Q6);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE1Q7 != "" && DataofSelectedPAGE1Q7 != "undefined" && DataofSelectedPAGE1Q7 != null) {
                    alert(DataofSelectedPAGE1Q7);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE2Q1 != "" && DataofSelectedPAGE2Q1 != "undefined" && DataofSelectedPAGE2Q1 != null) {
                    alert(DataofSelectedPAGE2Q1);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE2Q2 != "" && DataofSelectedPAGE2Q2 != "undefined" && DataofSelectedPAGE2Q2 != null) {
                    alert(DataofSelectedPAGE2Q2);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE2Q3 != "" && DataofSelectedPAGE2Q3 != "undefined" && DataofSelectedPAGE2Q3 != null) {
                    alert(DataofSelectedPAGE2Q3);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE2Q4 != "" && DataofSelectedPAGE2Q4 != "undefined" && DataofSelectedPAGE2Q4 != null) {
                    alert(DataofSelectedPAGE2Q4);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE2Q5 != "" && DataofSelectedPAGE2Q5 != "undefined" && DataofSelectedPAGE2Q5 != null) {
                    alert(DataofSelectedPAGE2Q5);
                }
                else {
                    alert("please provide rating to proceed");
                }

                if (DataofSelectedPAGE2Q6 != "" && DataofSelectedPAGE2Q6 != "undefined" && DataofSelectedPAGE2Q6 != null) {
                    alert(DataofSelectedPAGE2Q6);
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
        </script >
    </form >
</body >

</html >


