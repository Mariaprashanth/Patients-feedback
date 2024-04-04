using System;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Linq;
using SN_Master_Libray;

public partial class Pages_Patient_FeedbackOP : Page
{
	SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ServerConnection"].ConnectionString);
	readonly string APPLICATIONPATH = ConfigurationManager.AppSettings["APPLICATIONPATH"].ToString();
	readonly SN_Master MasterCS = new SN_Master();
	protected void Page_Load(object sender, EventArgs e)
	{
		if (Request.QueryString.HasKeys() == true)
		{
			if (Request.QueryString.AllKeys.Contains("dtls") == true)
			{
				if (string.IsNullOrWhiteSpace(Request.QueryString["dtls"]) == false)
				{
					if (!IsPostBack)
					{
						string appdid = HttpUtility.UrlDecode(Request.QueryString["dtls"]);
						
						HNDPATAPPTID.Value = DecryptFeedback(appdid);
						string ReturnFlag = FindPatientInformation(HNDPATAPPTID.Value);
						if (ReturnFlag == "AllreadyCompleted")
						{
							ClientScript.RegisterStartupScript(GetType(), "LoadFeedbackDtls", "LoadPatPageDtls('AllreadyCompleted');", true);
                            Label1.Visible = false;

                        }
						else if (ReturnFlag == "NeedtoComplete")
						{
							ClientScript.RegisterStartupScript(GetType(), "LoadFeedbackDtls", "LoadPatPageDtls('NeedtoComplete');", true);
						}
						else
						{
							ClientScript.RegisterStartupScript(GetType(), "LoadFeedbackDtls", "LoadPatPageDtls('ErrorMsg');", true);
						}
					}
					else
					{
						//Donothing
					}
				}
				else
				{
					ClientScript.RegisterStartupScript(GetType(), "LoadFeedbackDtls", "LoadPatPageDtls('ErrorMsg');", true);
				}
			}
			else
			{
				ClientScript.RegisterStartupScript(GetType(), "LoadFeedbackDtls", "LoadPatPageDtls('ErrorMsg');", true);
			}
		}
		else
		{
			ClientScript.RegisterStartupScript(GetType(), "LoadFeedbackDtls", "LoadPatPageDtls('ErrorMsg');", true);
		}
	}

	private string FindPatientInformation(string APPTID)
	{
		string ReturnVariable = "";
		try
		{
			string Query = "";
			Query += "SELECT distinct 1 as COUNT FROM sndb.snlive.dbo.FB_PATIENT_FEEDBACK_FORM_OP WHERE FPFO_APPT_ID='" + HNDPATAPPTID.Value + "';";
			Query += "exec sndb.snlive.dbo.FB_FETCH_PAT_DTLS '" + HNDPATAPPTID.Value + "';";
			//Query += "SELECT distinct 1 as COUNT FROM sndb.snlive.dbo.FB_PATIENT_FEEDBACK_FORM_OP WHERE FPFO_APPT_ID='APPT/160823/103399';";
			//Query += "exec sndb.snlive.dbo.FB_FETCH_PAT_DTLS 'APPT/160823/103399';";
			if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
			SqlCommand cmd = new SqlCommand(Query, con);
			SqlDataAdapter da = new SqlDataAdapter(cmd);
			DataSet ds = new DataSet();
			da.Fill(ds);
			if (con.State == ConnectionState.Open) { con.Close(); } else { }
			if (ds.Tables[0].Rows.Count >= 1)
			{
				ReturnVariable = "AllreadyCompleted";
			}
			else
			{
				if (ds.Tables[1].Rows.Count >= 1)
				{
					string DTLDMRD = ds.Tables[1].Rows[0]["PT_MRD"].ToString().TrimEnd().TrimStart();
					if (DTLDMRD != "" && DTLDMRD != null)
					{
						PATMRDNUM.Text = ds.Tables[1].Rows[0]["PT_MRD"].ToString().TrimEnd().TrimStart();
						PATNAME.Text = ds.Tables[1].Rows[0]["PT_NAME"].ToString().TrimEnd().TrimStart();
						PATAGE.Text = ds.Tables[1].Rows[0]["PT_AGE"].ToString().TrimEnd().TrimStart();
						PATGENDER.Text = ds.Tables[1].Rows[0]["PT_GENDER"].ToString().TrimEnd().TrimStart();
						ReturnVariable = "NeedtoComplete";
					}
					else
					{
						ReturnVariable = "ErrorMsg";
					}
				}
				else
				{
					ReturnVariable = "ErrorMsg";
				}
			}
		}
		catch (Exception ex)
		{
			MasterCS.Errorlog(ex, APPLICATIONPATH.TrimStart().TrimEnd().ToString() + "_Pages_Patient_FeedbackOP FindPatientInformation");
			ReturnVariable = "ErrorMsg";
		}
		return ReturnVariable;
	}

	private string DecryptFeedback(string cipherText)
	{
		string EncryptionKey = "SNFEEDBACKFORM";
		cipherText = cipherText.Replace(" ", "+");
		byte[] cipherBytes = Convert.FromBase64String(cipherText);
		using (Aes encryptor = Aes.Create())
		{
			Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
			encryptor.Key = pdb.GetBytes(32);
			encryptor.IV = pdb.GetBytes(16);
			using (MemoryStream ms = new MemoryStream())
			{
				using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
				{
					cs.Write(cipherBytes, 0, cipherBytes.Length);
					cs.Close();
				}
				cipherText = Encoding.Unicode.GetString(ms.ToArray());
			}
		}
		return cipherText;
	}

	private string FBOPINSERT()
	{
		string ReturnVariable = "";
		try
		{
			string query = "SELECT APD_PATIENT_TYPE AS PATIENT_TYPE,APD_APPOINTMENT_ID AS APPOINTMENT_ID,APD_ACTUAL_MRD_NO AS MRD_NO,APD_PATIENT_NAME AS PATIENTNAME,APD_RESOURCE_ID AS RESOURCE_ID, ";
			query += "ARM_RESOURCE_NAME AS DOCTOR_NAME,APD_CONSULTATION_DT AS CONSULTATION_DATE,APD_LOCATION_CODE AS CONSULT_LOCATION,APD_TREATMENT_CODE AS TREATMENT_CODE,APD_SPECIALITY_CODE AS SPECIALITY_CODE, ";
			query += "RRH_PAT_SEX, dbo.Lab_CalculateAge(RRH_PAT_DOB, getdate()) as PatientAge FROM sndb.snlive.dbo.AP_APPOINTMENT_DTLS LEFT outer JOIN sndb.snlive.dbo.RE_REGISTRATION_HEADER ON APD_ACTUAL_MRD_NO = RRH_MR_NUM ";
			query += "LEFT outer JOIN sndb.snlive.dbo.AP_RESOURCE_MASTER ON APD_RESOURCE_ID = ARM_RESOURCE_ID WHERE APD_APPOINTMENT_ID = '" + HNDPATAPPTID.Value + "' ";
			query += " UNION SELECT APD_PATIENT_TYPE AS PATIENT_TYPE,APD_APPOINTMENT_ID AS APPOINTMENT_ID,APD_ACTUAL_MRD_NO AS MRD_NO,APD_PATIENT_NAME AS PATIENTNAME,APD_RESOURCE_ID AS RESOURCE_ID, ";
			query += "ARM_RESOURCE_NAME AS DOCTOR_NAME,APD_CONSULTATION_DT AS CONSULTATION_DATE,APD_LOCATION_CODE AS CONSULT_LOCATION,APD_TREATMENT_CODE AS TREATMENT_CODE,APD_SPECIALITY_CODE AS SPECIALITY_CODE, ";
			query += "RRH_PAT_SEX, dbo.Lab_CalculateAge(RRH_PAT_DOB, getdate()) as PatientAge FROM sndb.snlive.dbo.AP_APPOINTMENT_DTLS_HISTORY LEFT outer JOIN sndb.snlive.dbo.RE_REGISTRATION_HEADER ON APD_ACTUAL_MRD_NO = RRH_MR_NUM ";
			query += "LEFT outer JOIN sndb.snlive.dbo.AP_RESOURCE_MASTER ON APD_RESOURCE_ID = ARM_RESOURCE_ID WHERE APD_APPOINTMENT_ID ='" + HNDPATAPPTID.Value + "' ";
			if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
			SqlCommand cmd1 = new SqlCommand(query, con);
			SqlDataAdapter dar = new SqlDataAdapter(cmd1);
			DataSet ds = new DataSet();
			dar.Fill(ds);
			if (con.State == ConnectionState.Open) { con.Close(); } else { }
			if (ds.Tables[0].Rows.Count >= 1)
			{
				var patapptno = ds.Tables[0].Rows[0]["APPOINTMENT_ID"].ToString().TrimEnd().TrimStart();
				var PATMRNUM = ds.Tables[0].Rows[0]["MRD_NO"].ToString().TrimEnd().TrimStart();
				var patname = ds.Tables[0].Rows[0]["PATIENTNAME"].ToString().TrimEnd().TrimStart();
				var patage = ds.Tables[0].Rows[0]["PatientAge"].ToString().TrimEnd().TrimStart();
				var patlocation = ds.Tables[0].Rows[0]["CONSULT_LOCATION"].ToString().TrimEnd().TrimStart();
				var patres = ds.Tables[0].Rows[0]["RESOURCE_ID"].ToString().TrimEnd().TrimStart();
				var patresname = ds.Tables[0].Rows[0]["DOCTOR_NAME"].ToString().TrimEnd().TrimStart();
				string insertquery = "insert into sndb.snlive.dbo.FB_PATIENT_FEEDBACK_FORM_OP (FPFO_APPT_ID,FPFO_MRD_NUMBER,FPFO_PAT_NAME,FPFO_PAT_AGE,FPFO_PAT_LOCATION,FPFO_LABEL_CHOOSE,FPFO_REASON,FPFO_LABEL_APPOINT,FPFO_APPOINTMENT,FPFO_Q1,FPFO_ANS1,FPFO_Q2,FPFO_ANS2,FPFO_Q3,FPFO_ANS3,FPFO_Q4,FPFO_ANS4,FPFO_Q5,FPFO_ANS5,";
				insertquery += "FPFO_Q6,FPFO_ANS6,FPFO_Q7,FPFO_ANS7,FPFO_Q8,FPFO_ANS8,FPFO_Q9,FPFO_ANS9,FPFO_Q10,FPFO_ANS10,FPFO_Q11,FPFO_ANS11,FPFO_Q12,FPFO_ANS12,FPFO_Q13,FPFO_ANS13,FPFO_Q14,FPFO_ANS14 ";
				insertquery += ",FPFO_LABEL_RECOMMEND,FPFO_RECOMMEND,FPFO_LABEL_APPRECIATION,FPFO_APPRECIATION,FPFO_LABEL_SUGGESTION,FPFO_SUGGESTION,FPFO_RESOURCE_ID,FPFO_RESOURCE_NAME,FPFO_CRT_ID,FPFO_CRT_DT,FPFO_LAST_UPT_ID,FPFO_LAST_UPT_DT)";
				insertquery += "values ('" + patapptno + "','" + PATMRNUM + "','" + patname + "','" + patage + "','" + patlocation + "','" + P2Q1.Text + "','" + HNDOPP2Q1.Value + "','" + P2Q2.Text + "','" + HNDOPP2Q2.Value + "', ";
				insertquery += " '" + P3Q1.Text + "', '" + HNDOPP3Q1.Value + "','" + P3Q2.Text + "','" + HNDOPP3Q2.Value + "','" + P3Q3.Text + "','" + HNDOPP3Q3.Value + "','" + P3Q4.Text + "','" + HNDOPP3Q4.Value + "','" + P3Q5.Text + "','" + HNDOPP3Q5.Value + "',";
				insertquery += " '" + P3Q6.Text + "', '" + HNDOPP3Q6.Value + "','" + P3Q7.Text + "','" + HNDOPP3Q7.Value + "','" + P4Q1.Text + "','" + HNDOPP4Q1.Value + "','" + P4Q2.Text + "','" + HNDOPP4Q2.Value + "', ";
				insertquery += " '" + P4Q3.Text + "', '" + HNDOPP4Q3.Value + "','" + P4Q4.Text + "','" + HNDOPP4Q4.Value + "','" + P4Q5.Text + "','" + HNDOPP4Q5.Value + "','" + P4Q6.Text + "','" + HNDOPP4Q6.Value + "','" + P4Q7.Text + "','" + HNDOPP4Q7.Value + "', ";
				insertquery += " '" + P5Q1.Text + "', '" + HNDOPP5Q1.Value + "','" + P5Q2.Text + "','" + HNDOPP5Q2.Value + "','" + P5Q3.Text + "','" + HNDOPP5Q3.Value + "','" + patres + "','" + patresname + "','PATIENT',GETDATE(),'PATIENT',GETDATE() ) ";
				insertquery += " if(@@ROWCOUNT >= 1) begin select 'YES' as STATUS end else begin select 'NO' as STATUS end; ";
				if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
				SqlCommand cmd2 = new SqlCommand(insertquery, con);
				SqlDataAdapter da1r = new SqlDataAdapter(cmd2);
				DataSet d1s = new DataSet();
				da1r.Fill(d1s);
				if (d1s.Tables[0].Rows.Count >= 1)
				{
					if (d1s.Tables[0].Rows[0]["STATUS"].ToString() == "YES")
					{
						if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
						SqlCommand cmdsub = new SqlCommand("Update sndb.snlive.dbo.SN_FEEDBACK_FLAG set SFF_SUBMITTED_FLAG='Y' where SFF_PATIENT_ID ='" + HNDPATAPPTID.Value + "' ", con);
						cmdsub.ExecuteNonQuery();
						if (con.State == ConnectionState.Open) { con.Close(); } else { }
						ReturnVariable = "Completed";
					}
					else
					{
						ReturnVariable = "ErrorMsg";
					}
				}
				else
				{
					ReturnVariable = "ErrorMsg";
				}
			}
		}
		catch (Exception ex)
		{
			MasterCS.Errorlog(ex, APPLICATIONPATH.TrimStart().TrimEnd().ToString() + "_Pages_Patient_FeedbackOP FindPatientInformationOP");
			ReturnVariable = "ErrorMsg";
		}
		return ReturnVariable;

	}

	protected void Save_Click(object sender, EventArgs e)
	{
		string CHEKFLAG = CHECKBEFOREINSERTOP();
		if (CHEKFLAG == "NEEDTODO")
		{
			string RESULT = FBOPINSERT();
			ClientScript.RegisterStartupScript(GetType(), "LoadFeedbackDtls", "LoadPatPageDtls('" + RESULT + "');", true);
		}
		else if (CHEKFLAG == "ADONE")
		{
			ClientScript.RegisterStartupScript(GetType(), "LoadFeedbackDtls", "LoadPatPageDtls('Completed');", true);
		}
		else
		{
			ClientScript.RegisterStartupScript(GetType(), "LoadFeedbackDtls", "LoadPatPageDtls('ErrorMsg');", true);
		}

	}

	private string CHECKBEFOREINSERTOP()
	{
		string ReturnVariable = "";
		try
		{
			string Query = "select * from sndb.snlive.dbo.FB_PATIENT_FEEDBACK_FORM_OP where FPFO_APPT_ID='" + HNDPATAPPTID.Value + "'";
			SqlCommand cmd = new SqlCommand(Query, con);
			SqlDataAdapter da = new SqlDataAdapter(cmd);
			DataSet ds = new DataSet();
			da.Fill(ds);
			if (ds.Tables.Count >= 1)
			{
				if (ds.Tables[0].Rows.Count == 0)
				{
					ReturnVariable = "NEEDTODO";
				}
				else
				{
					ReturnVariable = "ADONE";
				}
			}
			else
			{
				ReturnVariable = "ADONE";
			}

		}
		catch (Exception ex)
		{
			MasterCS.Errorlog(ex, APPLICATIONPATH.TrimStart().TrimEnd().ToString() + "_Pages_Patient_FeedbackOP CHECKBEFOREINSERTOP");
			ReturnVariable = "ErrorMsg";
		}
		return ReturnVariable;

	}

}
