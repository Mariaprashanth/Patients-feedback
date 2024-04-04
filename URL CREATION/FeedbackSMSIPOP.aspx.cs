using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

public partial class FeedbackSMSIPOP : Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ServerConnectionLIVE"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ValidateDtls();
            //SENDSMSVTEL();
            INSERTEMAILSENDBULK();
        }
    }
    
    private void ValidateDtls()
    {
        try
        {
            string NewQuery = "exec SN_FEEDBACK_FETCH_DTLS_RESENDDATA;";
            if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
            SqlCommand cmd = new SqlCommand(NewQuery, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (con.State == ConnectionState.Open) { con.Close(); } else { }
            if (ds.Tables.Count == 1)
            {
                if (ds.Tables[0].Rows.Count >= 1)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        string USRID = dr["USRID"].ToString();
                        string REFNUMBER = dr["REFNUMBER"].ToString();
                        string PATTYPE = dr["PATTYPE"].ToString();
                        string MRDNUMBER = dr["MRDNUMBER"].ToString();
                        GenrateShortURLForSNFOPANDIP(USRID, REFNUMBER, PATTYPE, MRDNUMBER);
                    }
                }
            }
            ////OP 
            //string QueryString;
            //QueryString = "SELECT MFL_CRT_UID,APD_APPOINTMENT_ID,'OP'as OPTYPE,RVD_MR_NUM FROM AP_APPOINTMENT_DTLS ";
            //QueryString += "inner join RE_REGISTRATION_VISIT_DETAIL on RVD_APPNT_NUM=APD_APPOINTMENT_ID and RVD_MR_NUM=APD_ACTUAL_MRD_NO ";
            //QueryString += "inner join MR_FOLLOW_UP on MFL_MRD_NUMBER=RVD_MR_NUM and MFL_VISIT_NO=RVD_VST_NUM and ";
            //QueryString += "CONVERT(VARCHAR(10),MFL_CRT_DT,121) = CONVERT(VARCHAR(10),RVD_VST_DT,121) and MFL_REMARKS<>'' ";
            //QueryString += "where CONVERT(VARCHAR(10),APD_CONSULTATION_DT,121) > CONVERT(VARCHAR(10),'2021-09-29',121) AND ";
            //QueryString += "APD_TREATMENT_CODE IN ('REG','GA') AND APD_APPOINTMENT_STATUS ='ASRE' AND APD_SPECIALITY_CODE <> 'PHY' ";
            //QueryString += "and APD_APPOINTMENT_ID not in (select distinct SFF_PATIENT_ID from SN_FEEDBACK_FLAG WHERE SFF_PATIENT_TYPE = 'OP') ";
            //if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
            //SqlCommand cmd = new SqlCommand(QueryString, con);
            //SqlDataAdapter da = new SqlDataAdapter(cmd);
            //DataSet ds = new DataSet();
            //da.Fill(ds);
            //if (con.State == ConnectionState.Open) { con.Close(); } else { }
            //foreach (DataRow dr in ds.Tables[0].Rows)
            //{
            //    string USRID = dr["MFL_CRT_UID"].ToString();
            //    string APPTID = dr["APD_APPOINTMENT_ID"].ToString();
            //    string MRNUM = dr["RVD_MR_NUM"].ToString();
            //    GenrateShortURLForSNFOPANDIP(USRID, APPTID, "OP", MRNUM);
            //}
            ////IP
            //string QueryString1;
            //QueryString1 = "SELECT BCC_CRT_UID,WAT_IP_NUM,'IP'as OPTYPE,WAT_MR_NUM,WAT_CRT_DT,WAT_LOCATION_CD,WAT_DHRG_DT FROM WA_ADMISSION_TXN ";
            //QueryString1 += "inner join BI_CLEARANCE_DETAIL on WAT_IP_NUM = BCC_PAT_NUM and CONVERT(VARCHAR(10),BCC_CRT_DT,121) >= CONVERT(VARCHAR(10),GETDATE()-2,121) ";
            //QueryString1 += "WHERE WAT_PAT_STATUS <> 'INAI' and WAT_IP_NUM not in (select SFF_PATIENT_ID from SN_FEEDBACK_FLAG WHERE SFF_PATIENT_TYPE = 'IP') ORDER BY WAT_DHRG_DT";
            //if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
            //SqlCommand cmd1 = new SqlCommand(QueryString1, con);
            //SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
            //DataSet ds1 = new DataSet();
            //da1.Fill(ds1);
            //if (con.State == ConnectionState.Open) { con.Close(); } else { }
            //foreach (DataRow dr1 in ds1.Tables[0].Rows)
            //{
            //    string USRID = dr1["BCC_CRT_UID"].ToString();
            //    string APPTID = dr1["WAT_IP_NUM"].ToString();
            //    string MRNUM = dr1["WAT_MR_NUM"].ToString();
            //    GenrateShortURLForSNFOPANDIP(USRID, APPTID, "IP", MRNUM);
            //}
        }
        catch(Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx ValidateDtls");
        }
    }

    public void GenrateShortURLForSNFOPANDIP(string USERID, string IPORAPPTID, string TYPEIPOROP, string MRDNUMBER)
    {
        try
        {
            string Flag = FindDoneornot(IPORAPPTID, TYPEIPOROP);
            if (Flag == "N")
            {
                string Type = "";
                string randomcode = "";
                int length = 7;
                const string valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
                StringBuilder retVal = new StringBuilder();
                using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
                {
                    byte[] uintBuffer = new byte[sizeof(uint)];

                    while (length-- > 0)
                    {
                        rng.GetBytes(uintBuffer);
                        uint num = BitConverter.ToUInt32(uintBuffer, 0);
                        retVal.Append(valid[(int)(num % (uint)valid.Length)]);
                    }
                }
                randomcode = retVal.ToString();
                string SURLFINALVALUE = randomcode;
                string EncryptIPOROPID = Encrypt(IPORAPPTID);
                //string Path = "https://snmail.in/snfeedbacknew/default.aspx?dtls=" + EncryptIPOROPID + "&type=" + TYPEIPOROP;
                string Path = "https://snmail.in/snto/pages/patient/feedback.aspx?dtls=" + EncryptIPOROPID + "&type=" + TYPEIPOROP;
                string Query = "";
                Query += "insert into SN_SHORT_URL_FEEDBACK (SSUF_SURL_VALUE,SSUF_PATH_TO_REDIRECT,SSUF_REF_DTLS,SSUF_SURL_STATUS,";
                Query += "SSUF_CRT_DT,SSUF_CRT_UID,SSUF_UPD_DT,SSUF_UPD_UID,SSUF_SUBMITTED_FLAG,SSUF_MRD_NO) ";
                Query += " values('" + SURLFINALVALUE + "','" + Path + "','NA','A',getdate(),'" + USERID + "',getdate(),'" + USERID + "','N','" + MRDNUMBER + "');";
                Query += "INSERT INTO SN_FEEDBACK_FLAG (SFF_PATIENT_ID,SFF_PATIENT_TYPE,SFF_SURL_CODE,SFF_SUBMITTED_FLAG,SFF_CRT_DT,SFF_CRT_UID,SFF_LAST_UPT_DT,SFF_LAST_UPT_UID,SFF_MRD_NUMBER) ";
                Query += " VALUES('" + IPORAPPTID + "','" + TYPEIPOROP + "','" + randomcode + "','N',getdate(),'" + USERID + "',getdate(),'" + USERID + "','" + MRDNUMBER + "')";
                if (TYPEIPOROP == "OP")
                {
                    Type = "SN Feedback OP";
                    Query += "select TOP 1 isnull(GPM_PARAMETER_VALUE+'. '+RRH_FIRST_NAME,'Patient') AS PATIENTNAME,MCD_MOBILE from AP_APPOINTMENT_DTLS inner join RE_REGISTRATION_HEADER on APD_ACTUAL_MRD_NO =RRH_MR_NUM ";
                    Query += "inner join GA_PARAMETER_MASTER ON RRH_PAT_TITLE=GPM_PARAMETER_CD inner join MR_PATIENT_COMMUNICATION_DETAILS on MCD_MR_NUM=RRH_MR_NUM and MCD_STATUS_FLAG='A' WHERE APD_APPOINTMENT_ID='" + IPORAPPTID + "'; ";
                }
                else if (TYPEIPOROP == "IP")
                {
                    Type = "SN Feedback IP";
                    //Query += "SELECT TOP 1 isnull(GPM_PARAMETER_VALUE +'. '+RRH_FIRST_NAME,'Patient') as PATIENTNAME,MCD_MOBILE FROM WA_ADMISSION_TXN inner join RE_REGISTRATION_HEADER ON WAT_MR_NUM=RRH_MR_NUM  ";
                    //Query += "inner join GA_PARAMETER_MASTER ON RRH_PAT_TITLE=GPM_PARAMETER_CD inner join MR_PATIENT_COMMUNICATION_DETAILS on MCD_MR_NUM=RRH_MR_NUM and MCD_STATUS_FLAG='A' where WAT_IP_NUM = '" + IPORAPPTID + "';";
                    Query += "exec FB_FETCH_MULTI_MOBILE_IP '" + IPORAPPTID.TrimEnd().TrimStart().ToString() + "','" + MRDNUMBER.TrimEnd().TrimStart().ToString() + "';";
                }
                else
                {
                    Type = "";
                    Query = "";
                }
                if (Query != "")
                {
                    if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
                    SqlCommand cmd = new SqlCommand(Query, con);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    if (con.State == ConnectionState.Open) { con.Close(); } else { }
                    if (ds.Tables[0].Rows.Count == 1)
                    {
                        string PatientName = ds.Tables[0].Rows[0]["PATIENTNAME"].ToString();
                        string PAT_MOBILE = ds.Tables[0].Rows[0]["MCD_MOBILE"].ToString();
                        string FINALMSG = "";
                        if (TYPEIPOROP == "OP")
                        {
                            FINALMSG = "Dear " + PatientName + " We solicit your feedback for your Out Patient Consultation at Sankara Nethralaya https://snmail.in/snf/" + SURLFINALVALUE;
                        }
                        else if (TYPEIPOROP == "IP")
                        {
                            FINALMSG = "Dear " + PatientName + " We solicit your feedback for the Inpatient Services you availed at Sankara Nethralaya https://snmail.in/snf/" + SURLFINALVALUE;
                        }
                        else
                        {

                        }
                        if (FINALMSG != "")
                        {
                            SENDSMSVIADBBULK(PAT_MOBILE, FINALMSG, Type, USERID);
                        }
                    }
                    else if (ds.Tables[0].Rows.Count >= 1)
                    {
                        foreach (DataRow dr in ds.Tables[0].Rows)
                        {
                            string PatientName = dr["PATIENTNAME"].ToString();
                            string PAT_MOBILE = dr["MCD_MOBILE"].ToString();
                            string FINALMSG = "";
                            if (TYPEIPOROP == "OP")
                            {
                                FINALMSG = "Dear " + PatientName + " We solicit your feedback for your Out Patient Consultation at Sankara Nethralaya https://snmail.in/snf/" + SURLFINALVALUE;
                            }
                            else if (TYPEIPOROP == "IP")
                            {
                                FINALMSG = "Dear " + PatientName + " We solicit your feedback for the Inpatient Services you availed at Sankara Nethralaya https://snmail.in/snf/" + SURLFINALVALUE;
                            }
                            else
                            {

                            }
                            if (FINALMSG != "")
                            {
                                SENDSMSVIADBBULK(PAT_MOBILE, FINALMSG, Type, USERID);
                            }
                        }
                    }
                }
                //INSERTEMAILSENDBULK();
            }
        }
        catch(Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx GenrateShortURLForSNFOPANDIP");
        }
    }

    private string INSERTEMAILSENDBULK()
    {
        string ReturnData = "";
        try
        {
            string FETCHQUERY = "SELECT distinct SFF_SERIAL_NUMBER,SFF_PATIENT_TYPE,isnull(MCD_MAIL,'')as MCD_MAIL,(GPM_PARAMETER_VALUE+'. '+RRH_FIRST_NAME) AS PATIENTNAME, " +
                "SFF_MRD_NUMBER,SFF_SURL_CODE,SFF_CRT_UID FROM SN_FEEDBACK_FLAG " +
                "LEFT OUTER JOIN MR_PATIENT_COMMUNICATION_DETAILS ON SFF_MRD_NUMBER = MCD_MR_NUM " +
                "LEFT OUTER JOIN RE_REGISTRATION_HEADER ON SFF_MRD_NUMBER = RRH_MR_NUM " +
                "LEFT OUTER JOIN GA_PARAMETER_MASTER ON RRH_PAT_TITLE=GPM_PARAMETER_CD WHERE MCD_STATUS_FLAG = 'A' " +
                "AND SFF_MAIL_FLAG IS NULL AND CONVERT(VARCHAR(10),SFF_CRT_DT,121) >= CONVERT(VARCHAR(10),getdate()-10,121) ";
            if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
            SqlCommand cmdfetchquery = new SqlCommand(FETCHQUERY,con);
            SqlDataAdapter dafetchquery = new SqlDataAdapter(cmdfetchquery);
            DataSet dsfetchquery = new DataSet();
            dafetchquery.Fill(dsfetchquery);
            if (con.State == ConnectionState.Open) { con.Close(); } else { }
            if (dsfetchquery.Tables.Count >= 1)
            {
                if (dsfetchquery.Tables[0].Rows.Count >= 1)
                {
                    foreach (DataRow drfetchquery in dsfetchquery.Tables[0].Rows)
                    {
                        string SERIALNUMBER = drfetchquery["SFF_SERIAL_NUMBER"].ToString();
                        string SHORT_URL = drfetchquery["SFF_SURL_CODE"].ToString();
                        string FEEDBACKTYPE = drfetchquery["SFF_PATIENT_TYPE"].ToString();
                        string PATIENT_NAME = drfetchquery["PATIENTNAME"].ToString();
                        string PAT_EMAILID = drfetchquery["MCD_MAIL"].ToString();
                        string USRID = drfetchquery["SFF_CRT_UID"].ToString();
                        string PURPOSE = "";
                        string strPostResponseEMAIL = "";
                        string Subject = "";
                        string Body = "";
                        if (FEEDBACKTYPE == "OP")
                        {
                            Subject = "Sankara Nethralaya OutPatient - Feedback";
                            Body = "Dear " + PATIENT_NAME + ", Greetings from Sankara Nethralaya !! Just Spend a minute helping us to improve our services. " +
                                "Please fill in your valuable feedback for your Outpatient consultation at Sankara Nethralaya by clicking the link " +
                                "https://snmail.in/snf/" + SHORT_URL + " Regards Management Sankara Nethralaya This is a automated mail please donot reply back.";
                            PURPOSE = "SN_FEEDBACK_OP";
                        }
                        else if (FEEDBACKTYPE == "IP")
                        {
                            Subject = "Sankara Nethralaya InPatient - Feedback";
                            Body = "Dear " + PATIENT_NAME + ", Greetings from Sankara Nethralaya !! Just Spend a minute helping us to improve our services. " +
                                "Please fill in your valuable feedback for your Outpatient consultation at Sankara Nethralaya by clicking the link " +
                                "https://snmail.in/snf/" + SHORT_URL + " Regards Management Sankara Nethralaya This is a automated mail please donot reply back.";
                            PURPOSE = "SN_FEEDBACK_IP";
                        }
                        else
                        {
                            Subject = "";
                            Body = "";
                            PURPOSE = "";
                        }
                        string FromID = "sntele@snmail.org";
                        string FromIDNAME = "SN Patient Feedback";
                        string html = @"<html><body><div><table  width='75%' border='0' align='center' cellpadding='5' cellspacing='5'><tr><td BGCOLOR=#999999><strong>";
                        html += @"<font size='2' face='Arial'>Dear <b>" + PATIENT_NAME + "</b></font></strong></td></tr>";
                        html += @"<tr><td><b><font size='2'> Greetings from Sankara Nethralaya !!</font></B></td></tr>";
                        html += @"<tr><td><B><font size='2'> Just Spend a minute helping us to improve our services.</font></b></td></tr>";
                        if (FEEDBACKTYPE == "OP")
                        {
                            html += @"<tr><td><b><font size='2'> Please fill in your valuable feedback for your Outpatient consultation at Sankara Nethralaya by clicking the link ";
                            html += @"<a href='https://snmail.in/snf/" + SHORT_URL + "'>OPFeedback</a> </font></b></td></tr> ";
                        }
                        else if (FEEDBACKTYPE == "IP")
                        {
                            html += @"<tr><td><b><font size='2'> Please fill in your valuable feedback for the Inpatient services you availed at Sankara Nethralaya by clicking the link ";
                            html += @"<a href='https://snmail.in/snf/" + SHORT_URL + "'>IPFeedback</a> </font></b></td></tr> ";
                        }
                        html += @"<tr><td><b><font size='2'> Regards</font></b></td></tr><tr><td><b><font size='2'> Management</font></b></td></tr>";
                        html += @"<tr><td><b><font size='2'> Sankara Nethralaya</font></b></td></tr>";
                        html += @"<tr><td>&nbsp;<td></tr><tr><td><span>This is a automated mail please donot reply back.</span></td></tr></table></body></html>";
                        if (Subject != null && Subject != "" && Body != null && Body != "" && PURPOSE != null && PURPOSE != "")
                        {
                            strPostResponseEMAIL = SENDEMAILVIADB(Subject, Body, PAT_EMAILID, FromID, FromIDNAME, html.Replace("'", "''"), PURPOSE, USRID);
                            if (strPostResponseEMAIL == "Error")
                            {
                                ReturnData = "ErrorEmail";
                                UPDATEFLAG(SERIALNUMBER, "NA");
                            }
                            else
                            {
                                ReturnData = "SuccessEmail";
                                UPDATEFLAG(SERIALNUMBER, "Y");
                            }
                        }
                        else
                        {
                            ReturnData = "ErrorEmail";
                            UPDATEFLAG(SERIALNUMBER, "N");
                        }
                    }
                }
                else
                {
                    ReturnData = "ErrorEmail";
                }
            }
            else
            {
                ReturnData = "ErrorEmail";
            }
        }
        catch(Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx INSERTEMAILSENDBULK");
            ReturnData = "ErrorEmail";
        }
        return ReturnData;
    }

    private void UPDATEFLAG(string IDGIVEN,string RESULT)
    {
        try
        {
            string QUERY = "update SN_FEEDBACK_FLAG set SFF_MAIL_FLAG='"+ RESULT + "' where SFF_SERIAL_NUMBER='" + IDGIVEN + "' and SFF_MAIL_FLAG is null;";
            if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
            SqlCommand cmd = new SqlCommand(QUERY, con);
            cmd.ExecuteNonQuery();
            if (con.State == ConnectionState.Open) { con.Close(); } else { }
        }
        catch (Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx UPDATEFLAG");
        }
    }

    private bool ValidateEmail(string EMAILID)
    {
        try
        {
            string email = EMAILID;
            Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
            Match match = regex.Match(email);
            if (match.Success)
            {
                var addr = new MailAddress(email);
                if (addr.Address == email)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }
        catch (Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx ValidateEmail");
            return false;
        }
    }

    private string SENDEMAILVIADB(string Subject, string Body, string TOEMAIL, string FromID, string FromIDNAME, string HTML, string Type,string USERID)
    {
        try
        {
            if (ValidateEmail(TOEMAIL) == true)
            {
                //string Query = "insert into [SNDB].snlive.dbo.SN_EMAIL_REGISTER ";
                //Query += "(SER_MODULE_OR_SCREEN,SER_PURPOSE,SER_TO_EMAIL_ID,SER_FROM_EMAIL_ID,SER_FROM_EMAIL_DISPLAY,SER_MESSAGE,SER_ALTBODY, ";
                //Query += "SER_EMAIL_SUBJECT,SER_STATUS_FROM_APPLICATION,SER_VENDOR_EMAIL_STATUS,SER_NUMBER_OF_ATTEMPT,SER_EMAIL_EXPIRY_DT,SER_EMAIL_DELIVERY_DT,SER_STATUS,SER_CRT_UID, ";
                //Query += "SER_CRT_DT,SER_LAST_UPD_UID,SER_LAST_UPD_DT) values ";
                //Query += "('HMS','" + Type + "','" + TOEMAIL + "','" + FromID + "','" + FromIDNAME + "','" + HTML + "','" + Body + "','" + Subject + "','NeedUpdate', ";
                //Query += "NULL,'0',convert(varchar(10),getdate(),121),NULL,'A','" + USERID + "',getdate(),'" + USERID + "',getdate()); ";
                //Query += "select SER_ID from [SNDB].snlive.dbo.SN_EMAIL_REGISTER where SER_TO_EMAIL_ID='" + TOEMAIL + "' and SER_FROM_EMAIL_ID='" + FromID + "' and convert(varchar(10),SER_EMAIL_EXPIRY_DT,121)=convert(varchar(10),getdate(),121) ";
                //Query += "and convert(varchar(10),SER_CRT_DT,121)=convert(varchar(10),getdate(),121) and SER_STATUS='A';";
                string Query = "if exists (select SER_ID from [SNDB].snlive.dbo.SN_EMAIL_REGISTER where SER_TO_EMAIL_ID='" + TOEMAIL + "' and SER_FROM_EMAIL_ID='" + FromID + "' and SER_ALTBODY='" + Body + "' ";
                Query += "and convert(varchar(10),SER_EMAIL_EXPIRY_DT,121)=convert(varchar(10),getdate(),121) and convert(varchar(10),SER_CRT_DT,121)=convert(varchar(10),getdate(),121) and SER_STATUS='A')";
                Query += "begin select SER_ID from [SNDB].snlive.dbo.SN_EMAIL_REGISTER where SER_TO_EMAIL_ID='" + TOEMAIL + "' and ";
                Query += "SER_FROM_EMAIL_ID='" + FromID + "' and convert(varchar(10),SER_EMAIL_EXPIRY_DT,121)=convert(varchar(10),getdate(),121) and SER_ALTBODY='" + Body + "' ";
                Query += "and convert(varchar(10),SER_CRT_DT,121)=convert(varchar(10),getdate(),121) and SER_STATUS='A'; end else begin ";
                Query += "insert into [SNDB].snlive.dbo.SN_EMAIL_REGISTER ";
                Query += "(SER_MODULE_OR_SCREEN,SER_PURPOSE,SER_TO_EMAIL_ID,SER_FROM_EMAIL_ID,SER_FROM_EMAIL_DISPLAY,SER_MESSAGE,SER_ALTBODY, ";
                Query += "SER_EMAIL_SUBJECT,SER_STATUS_FROM_APPLICATION,SER_VENDOR_EMAIL_STATUS,SER_NUMBER_OF_ATTEMPT,SER_EMAIL_EXPIRY_DT,SER_EMAIL_DELIVERY_DT,SER_STATUS,SER_CRT_UID, ";
                Query += "SER_CRT_DT,SER_LAST_UPD_UID,SER_LAST_UPD_DT) values ";
                Query += "('HMS','" + Type + "','" + TOEMAIL + "','" + FromID + "','" + FromIDNAME + "','" + HTML + "','" + Body + "','" + Subject + "','NeedUpdate', ";
                Query += "NULL,'0',convert(varchar(10),getdate(),121),NULL,'A','" + USERID + "',getdate(),'" + USERID + "',getdate()); ";
                Query += "select SER_ID from [SNDB].snlive.dbo.SN_EMAIL_REGISTER where SER_TO_EMAIL_ID='" + TOEMAIL + "' and ";
                Query += "SER_FROM_EMAIL_ID='" + FromID + "' and convert(varchar(10),SER_EMAIL_EXPIRY_DT,121)=convert(varchar(10),getdate(),121) ";
                Query += "and convert(varchar(10),SER_CRT_DT,121)=convert(varchar(10),getdate(),121) and SER_STATUS='A' and SER_ALTBODY='" + Body + "' ; ";
                Query += "end ";
                if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
                SqlCommand cmd = new SqlCommand(Query, con);
                SqlDataAdapter reader = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                reader.Fill(ds);
                if (con.State == ConnectionState.Open) { con.Close(); } else { }
                if (ds.Tables.Count >= 1)
                {
                    if (ds.Tables[0].Rows.Count >= 1)
                    {
                        return ds.Tables[0].Rows[0]["SER_ID"].ToString();
                    }
                    else
                    {
                        return "Error";
                    }
                }
                else
                {
                    return "Error";
                }
            }
            else
            {
                return "Error";
            }
            //return "Error";
        }
        catch (Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx SENDEMAILVIADB");
            return "Error";
        }
    }

    private void SENDSMSVIADBBULK(string PAT_MOBILE, string FINALMSG, string SMSType,string USRID)
    {
        try
        {
            //string Query = "insert into [SNDB].snlive.dbo.SN_SMS_REGISTER_BULK ";
            //Query += "(SSRB_MODULE_OR_SCREEN,SSRB_PURPOSE,SSRB_MOBILE_NUMBER,SSRB_MESSAGE,SSRB_VENDOR_SMS_ID,SSRB_VENDOR_SMS_STATUS,SSRB_STATUS_FROM_APPLICATION, ";
            //Query += "SSRB_NUMBER_OF_ATTEMPT,SSRB_SMS_EXPIRY_DT,SSRB_SMS_DELIVERY_DT,SSRB_STATUS,SSRB_CRT_UID,SSRB_CRT_DT,SSRB_LAST_UPD_UID,SSRB_LAST_UPD_DT) ";
            //Query += "values ";
            //Query += "('SN Patient Feedback','" + SMSType + "','" + PAT_MOBILE + "','" + FINALMSG + "',NULL,NULL,'NeedUpdate','0',convert(varchar(10),getdate(),121),NULL,'A','"+ USRID + "',getdate(),'"+ USRID + "',getdate()); ";
            //Query += "select SSRB_ID from [SNDB].snlive.dbo.SN_SMS_REGISTER_BULK where SSRB_MOBILE_NUMBER='" + PAT_MOBILE + "' and SSRB_MESSAGE='" + FINALMSG + "' and convert(varchar(10),SSRB_SMS_EXPIRY_DT,121)=convert(varchar(10),getdate(),121) ";
            //Query += "and convert(varchar(10),SSRB_CRT_DT,121)=convert(varchar(10),getdate(),121) and SSRB_STATUS='A';";
            string Query = "if exists (select SSRB_ID from [SNDB].snlive.dbo.SN_SMS_REGISTER_BULK where SSRB_MOBILE_NUMBER='" + PAT_MOBILE + "' ";
            Query += "and SSRB_MESSAGE='" + FINALMSG + "' and convert(varchar(10),SSRB_SMS_EXPIRY_DT,121)=convert(varchar(10),getdate(),121)";
            Query += "and convert(varchar(10),SSRB_CRT_DT,121)=convert(varchar(10),getdate(),121) and SSRB_STATUS='A') begin ";
            Query += "select SSRB_ID from [SNDB].snlive.dbo.SN_SMS_REGISTER_BULK where SSRB_MOBILE_NUMBER='" + PAT_MOBILE + "' ";
            Query += "and SSRB_MESSAGE='" + FINALMSG + "' and convert(varchar(10),SSRB_SMS_EXPIRY_DT,121)=convert(varchar(10),getdate(),121) ";
            Query += "and convert(varchar(10),SSRB_CRT_DT,121)=convert(varchar(10),getdate(),121) and SSRB_STATUS='A' end else begin ";
            Query += "insert into [SNDB].snlive.dbo.SN_SMS_REGISTER_BULK ";
            Query += "(SSRB_MODULE_OR_SCREEN,SSRB_PURPOSE,SSRB_MOBILE_NUMBER,SSRB_MESSAGE,SSRB_VENDOR_SMS_ID,SSRB_VENDOR_SMS_STATUS,SSRB_STATUS_FROM_APPLICATION, ";
            Query += "SSRB_NUMBER_OF_ATTEMPT,SSRB_SMS_EXPIRY_DT,SSRB_SMS_DELIVERY_DT,SSRB_STATUS,SSRB_CRT_UID,SSRB_CRT_DT,SSRB_LAST_UPD_UID,SSRB_LAST_UPD_DT) ";
            Query += "values ('SN Patient Feedback','" + SMSType + "','" + PAT_MOBILE + "','" + FINALMSG + "',NULL,NULL,'NeedUpdate','0',";
            Query += "convert(varchar(10),getdate(),121),NULL,'A','Patient',getdate(),'Patient',getdate()); end ";
            if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
            SqlCommand cmd = new SqlCommand(Query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (con.State == ConnectionState.Open) { con.Close(); } else { }
			//if (ds.Tables[0].Rows.Count >= 1)
			//{
			//	ds.Tables[0].Rows[0]["SSRB_ID"].ToString();
			//}
		}
        catch(Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx SENDSMSVIADBBULK");
        }
    }

    private string Encrypt(string clearText)
    {
        string EncryptionKey = "SNFEEDBACKFORM";
        byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(clearBytes, 0, clearBytes.Length);
                    cs.Close();
                }
                clearText = Convert.ToBase64String(ms.ToArray());
            }
        }
        return clearText;
    }

    private string FindDoneornot(string IPORAPPTID, string TYPEIPOROP)
    {
        try
        {
            string StringQueryForDatachecker = "select SFF_PATIENT_ID from SN_FEEDBACK_FLAG where ";
            StringQueryForDatachecker += "SFF_PATIENT_ID = '" + IPORAPPTID + "' and SFF_PATIENT_TYPE='" + TYPEIPOROP + "' ; ";
            if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
            SqlCommand CommandDatachecker = new SqlCommand(StringQueryForDatachecker, con);
            SqlDataAdapter DataCheckerReader = new SqlDataAdapter(CommandDatachecker);
            DataSet DataCheckerSet = new DataSet();
            DataCheckerReader.Fill(DataCheckerSet);
            if (con.State == ConnectionState.Open) { con.Close(); } else { }
            if (DataCheckerSet.Tables[0].Rows.Count >= 1) { return "Y"; } else { return "N"; }
        }
        catch(Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx FindDoneornot");
            return "Error";
        }
    }

    private void ErrorLog(Exception ex, string Message)
    {
        if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
        SqlCommand cmd = new SqlCommand("insert into SN_APP_ERROR_LOG (ERR_DATE,ERR_SOURCE,ERR_MESSAGE,ERR_APP) values (getdate(),@source,@message,@application)", con);
        cmd.Parameters.AddWithValue("@source", ex.Source.Replace("'", "''"));
        cmd.Parameters.AddWithValue("@message", ex.Message.Replace("'", "''"));
        cmd.Parameters.AddWithValue("@application", Message.Replace("'", "''"));
        cmd.ExecuteNonQuery();
        if (con.State == ConnectionState.Open) { con.Close(); } else { }
    }

    private void SENDSMSVTEL()
    {
        try
        {
            string MOBILE = "";
            string MESSAGE = "";
            string IDGOT = "";
            string Query = "select SSRB_ID,SSRB_MOBILE_NUMBER,SSRB_MESSAGE from [SNDB].snlive.dbo.SN_SMS_REGISTER_BULK where SSRB_STATUS_FROM_APPLICATION='NeedUpdate' " +
                "and convert(varchar(10),SSRB_SMS_EXPIRY_DT,121)=convert(varchar(10),getdate(),121) and SSRB_STATUS='A' and SSRB_MODULE_OR_SCREEN='SN Patient Feedback'; ";
            if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
            SqlCommand cmd = new SqlCommand(Query, con);
            //SqlDataReader reader = cmdnext.ExecuteReader();
            SqlDataAdapter reader = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            reader.Fill(ds);
            if (con.State == ConnectionState.Open) { con.Close(); } else { }
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                MOBILE = dr["SSRB_MOBILE_NUMBER"].ToString();
                MESSAGE = dr["SSRB_MESSAGE"].ToString();
                IDGOT = dr["SSRB_ID"].ToString();
                if (MOBILE != "NA" && MOBILE != "" && MOBILE != null)
                {
                    if (MOBILE.Length == 10)
                    {
                        POSTSMSTOVTELBULK(MOBILE, MESSAGE, IDGOT);
                    }
                    else
                    {
                        Deactivate(IDGOT);
                    }
                }
                else
                {
                    if (IDGOT != "NA")
                    {
                        Deactivate(IDGOT);
                    }
                    else
                    {
                        //DONOTHING
                    }
                }
                //POSTSMSTOVTELBULK(MOBILE, MESSAGE, IDGOT);
            }
        }
        catch (Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx SENDSMSVTEL");
        }
    }

    private void Deactivate(string IDGOT)
    {
        try
        {
            string Query = "update [SNDB].snlive.dbo.SN_SMS_REGISTER_BULK set SSRB_STATUS_FROM_APPLICATION='CheckToMobile',";
            Query += "SSRB_VENDOR_SMS_STATUS='Failed',SSRB_NUMBER_OF_ATTEMPT=SSRB_NUMBER_OF_ATTEMPT+1,";
            Query += "SSRB_LAST_UPD_UID='SMSSERVICE',SSRB_LAST_UPD_DT=getdate() where SSRB_ID='" + IDGOT + "';";
            if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
            SqlCommand cmd = new SqlCommand(Query, con);
            cmd.ExecuteNonQuery();
            if (con.State == ConnectionState.Open) { con.Close(); } else { }
        }
        catch (Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx Deactivate");
        }
    }

    private void POSTSMSTOVTELBULK(string MOBILE, string MESSAGE, string IDGOT)
    {
        try
        {
            string ApiData = SendSMSTOVTEL("sankaran", "Abcd@1234", MOBILE, MESSAGE);
            if (ApiData != "")
            {
                var data = (JObject)JsonConvert.DeserializeObject(ApiData);
                string SMSPOSTSTATUS = "";
                string SMSID = "";
                string Mobile = "";
                string SMSStatus = "";
                SMSPOSTSTATUS = data["status"].ToString();
                var ChildofSMSPostStatus = data["data"].Children();
                foreach (var DataofChildofSMSPostStatus in ChildofSMSPostStatus)
                {
                    SMSID = DataofChildofSMSPostStatus["id"].ToString();
                    Mobile = DataofChildofSMSPostStatus["mobile"].ToString();
                    SMSStatus = DataofChildofSMSPostStatus["status"].ToString();
                }
                //WriteToFile(SMSID + " " + Mobile + " " + SMSStatus);
                UPDATEDBBULK(IDGOT, Mobile, SMSID, SMSStatus);
            }
            else
            {
                UPDATEDBBULK(IDGOT, "", "", "");
            }
        }
        catch (Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx POSTSMSTOVTELBULK");
        }
    }

    private void UPDATEDBBULK(string IDGOT, string Mobile, string SMSID, string SMSStatus)
    {
        try
        {
            string Query = "";
            if (SMSStatus == "")
            {
                Query = "update [SNDB].snlive.dbo.SN_SMS_REGISTER_BULK set SSRB_NUMBER_OF_ATTEMPT=SSRB_NUMBER_OF_ATTEMPT+1,SSRB_LAST_UPD_UID='SMSSERVICE',SSRB_LAST_UPD_DT=getdate() where SSRB_ID='" + IDGOT + "'";
            }
            else if (SMSStatus != "")
            {
                Query = "update [SNDB].snlive.dbo.SN_SMS_REGISTER_BULK set SSRB_VENDOR_SMS_ID='" + SMSID + "',SSRB_STATUS_FROM_APPLICATION='Submitted',SSRB_VENDOR_SMS_STATUS='" + SMSStatus + "',SSRB_NUMBER_OF_ATTEMPT=SSRB_NUMBER_OF_ATTEMPT+1,SSRB_LAST_UPD_UID='SMSSERVICE',SSRB_LAST_UPD_DT=getdate() where SSRB_ID='" + IDGOT + "'";
            }
            else
            {
                Query = "update [SNDB].snlive.dbo.SN_SMS_REGISTER_BULK set SSRB_NUMBER_OF_ATTEMPT=SSRB_NUMBER_OF_ATTEMPT+1,SSRB_LAST_UPD_UID='SMSSERVICE',SSRB_LAST_UPD_DT=getdate() where SSRB_ID='" + IDGOT + "'";
            }
            if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
            SqlCommand cmd = new SqlCommand(Query, con);
            cmd.ExecuteNonQuery();
            if (con.State == ConnectionState.Open) { con.Close(); } else { }
        }
        catch (Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx UPDATEDBBULK");
        }
    }

    public string SendSMSTOVTEL(string User, string Password, string MobileNumber, string Message)
    {
        object stringpost = "api_key=Aee3d655cf36ff6e60f869249d93a28b4&method=sms&message=" + Message + "&to=" + MobileNumber + "&sender=NETHRA";
        //&method=sms&message=Test+sms&to=9172xxxxxxxx&sender=BRAND
        HttpWebRequest objWebRequest = null;
        HttpWebResponse objWebResponse = null;
        StreamWriter objStreamWriter = null;
        StreamReader objStreamReader = null;
        WebProxy objProxy1 = null;
        string stringResult = "";
        try
        {
            objWebRequest = (HttpWebRequest)WebRequest.Create("http://india.vtel.in/api/v4/?" + stringpost);
            objWebRequest.Method = "POST";
            if (objProxy1 != null)
            {
                objWebRequest.Proxy = objProxy1;
            }
            objWebRequest.Credentials = CredentialCache.DefaultCredentials;
            objWebRequest.ContentType = "application/x-www-form-urlencoded";
            objStreamWriter = new StreamWriter(objWebRequest.GetRequestStream());
            objStreamWriter.Write(stringpost);
            objStreamWriter.Flush();
            objStreamWriter.Close();
            objWebResponse = (HttpWebResponse)objWebRequest.GetResponse();
            objStreamReader = new StreamReader(objWebResponse.GetResponseStream());
            stringResult = objStreamReader.ReadToEnd();
            objStreamReader.Close();
            return stringResult;
        }
        catch (Exception ex)
        {
            ErrorLog(ex, "SNJOBS FeedbackSMSIPOP.aspx SendSMSTOVTEL");
            return stringResult;
        }
        finally
        {
            if (objStreamWriter != null)
            {
                objStreamWriter.Close();
            }
            if (objStreamReader != null)
            {
                objStreamReader.Close();
            }
            objWebRequest = null;
            objWebResponse = null;
            objProxy1 = null;
        }
    }
}