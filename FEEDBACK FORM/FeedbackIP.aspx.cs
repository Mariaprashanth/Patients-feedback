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
						string Appidip = HttpUtility.UrlDecode(Request.QueryString["dtls"]);
						HNDPATIPID.Value = DecryptFeedback(Appidip);
						string ReturnFlag = FindPatientInformationIP(HNDPATIPID.Value);
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

	private string FindPatientInformationIP(string APPTID)
	{
		string ReturnVariable = "";
		try
		{
			string Query = "";
			Query += "SELECT distinct 1 as COUNT FROM sndb.snlive.dbo.FB_PATIENT_FEEDBACK_FORM_IP WHERE FPFI_IP_NUM='" + HNDPATIPID.Value + "';";
			Query += "exec sndb.snlive.dbo.FB_FETCH_PAT_DTLS_IP '" + HNDPATIPID.Value + "';";
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
			MasterCS.Errorlog(ex, APPLICATIONPATH.TrimStart().TrimEnd().ToString() + "_Pages_Patient_FeedbackIP FindPatientInformationIP");
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


	private string FBIPINSERT()
	{
		string ReturnVariable = "";
		try
		{
			string query = "SELECT WAT_IP_NUM, WAT_MR_NUM, WAT_ADMN_DT, WAT_LOCATION_CD, RRH_FIRST_NAME AS PATIENTNAME,RRH_PAT_SEX, dbo.Lab_CalculateAge(RRH_PAT_DOB, getdate()) as PatientAge, ";
			query += "WAT_DOCTOR_INCHARGE,WAT_REF_DOCTOR_IND,ARM_RESOURCE_NAME AS DOCTOR_NAME FROM sndb.snlive.dbo.WA_ADMISSION_TXN left outer join sndb.snlive.dbo.RE_REGISTRATION_HEADER on RRH_MR_NUM = WAT_MR_NUM ";
			query += "LEFT OUTER JOIN sndb.snlive.dbo.AP_RESOURCE_MASTER ON ARM_RESOURCE_ID = WAT_DOCTOR_INCHARGE WHERE WAT_IP_NUM = '" + HNDPATIPID.Value + "' ";
			if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
			SqlCommand cmd1 = new SqlCommand(query, con);
			SqlDataAdapter dar = new SqlDataAdapter(cmd1);
			DataSet ds = new DataSet();
			dar.Fill(ds);
			if (con.State == ConnectionState.Open) { con.Close(); } else { }
			if (ds.Tables[0].Rows.Count >= 1)
			{
				var patipnum = ds.Tables[0].Rows[0]["WAT_IP_NUM"].ToString().TrimEnd().TrimStart();
				var patmrdnum = ds.Tables[0].Rows[0]["WAT_MR_NUM"].ToString().TrimEnd().TrimStart();
				var patname = ds.Tables[0].Rows[0]["PATIENTNAME"].ToString().TrimEnd().TrimStart();
				var patage = ds.Tables[0].Rows[0]["PatientAge"].ToString().TrimEnd().TrimStart();
				var patlocation = ds.Tables[0].Rows[0]["WAT_LOCATION_CD"].ToString().TrimEnd().TrimStart();
				var patres = ds.Tables[0].Rows[0]["WAT_DOCTOR_INCHARGE"].ToString().TrimEnd().TrimStart();
				var patresname = ds.Tables[0].Rows[0]["DOCTOR_NAME"].ToString().TrimEnd().TrimStart();
				string insertquery = "insert into sndb.snlive.dbo.FB_PATIENT_FEEDBACK_FORM_IP (FPFI_IP_NUM,FPFI_MRD_NUMBER,FPFI_PAT_NAME,FPFI_PAT_AGE,FPFI_PAT_LOCATION,FPFI_LABEL_CHOOSE,FPFI_REASON,FPFI_Q1,FPFI_ANS1,FPFI_Q2,FPFI_ANS2,FPFI_Q3,FPFI_ANS3,FPFI_Q4,FPFI_ANS4,FPFI_Q5,FPFI_ANS5,";
				insertquery += "FPFI_Q6,FPFI_ANS6,FPFI_Q7,FPFI_ANS7,FPFI_Q8,FPFI_ANS8,FPFI_Q9,FPFI_ANS9,FPFI_Q10,FPFI_ANS10,FPFI_Q11,FPFI_ANS11,FPFI_Q12,FPFI_ANS12,FPFI_Q13,FPFI_ANS13 ";
				insertquery += ",FPFI_LABEL_RECOMMEND,FPFI_RECOMMEND,FPFI_LABEL_APPRECIATION,FPFI_APPRECIATION,FPFI_LABEL_SUGGESTION,FPFI_SUGGESTION,FPFI_RESOURCE_ID,FPFI_RESOURCE_NAME,FPFI_CRT_ID,FPFI_CRT_DT,FPFI_LAST_UPT_ID,FPFI_LAST_UPT_DT)";
				insertquery += "values ('" + patipnum + "','" + patmrdnum + "','" + patname + "','" + patage + "','" + patlocation + "','" + P1Q0.Text + "','" + HNDOPP1Q0.Value + "', ";
				insertquery += " '" + P1Q1.Text + "','" + HNDOPP1Q1.Value + "','" + P1Q2.Text + "','" + HNDOPP1Q2.Value + "','" + P1Q3.Text + "','" + HNDOPP1Q3.Value + "','" + P1Q4.Text + "','" + HNDOPP1Q4.Value + "','" + P1Q5.Text + "','" + HNDOPP1Q5.Value + "',";
				insertquery += " '" + P1Q6.Text + "','" + HNDOPP1Q6.Value + "','" + P1Q7.Text + "','" + HNDOPP1Q7.Value + "','" + P2Q1.Text + "','" + HNDOPP2Q1.Value + "','" + P2Q2.Text + "','" + HNDOPP2Q2.Value + "','" + P2Q3.Text + "', '" + HNDOPP2Q3.Value + "', ";
				insertquery += " '" + P2Q4.Text + "','" + HNDOPP2Q4.Value + "','" + P2Q5.Text + "','" + HNDOPP2Q5.Value + "','" + P2Q6.Text + "','" + HNDOPP2Q6.Value + "', ";
				insertquery += " '" + P3Q1.Text + "', '" + HNDOPP3Q1.Value + "','" + P3Q2.Text + "','" + HNDOPP3Q2.Value + "','" + P3Q3.Text + "','" + HNDOPP3Q3.Value + "','" + patres + "','" + patresname + "','PATIENT',GETDATE(),'PATIENT',GETDATE() ); ";
				insertquery += " if(@@ROWCOUNT >= 1) begin select 'YES' as STATUS end else begin select 'NO' as STATUS end; ";
				if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
				SqlCommand cmd2 = new SqlCommand(insertquery, con);
				//cmd2.ExecuteNonQuery();
				SqlDataAdapter da1r = new SqlDataAdapter(cmd2);
				DataSet d1s = new DataSet();
				da1r.Fill(d1s);
				if (con.State == ConnectionState.Open) { con.Close(); } else { }
				if (d1s.Tables[0].Rows.Count >= 1)
				{
					if (d1s.Tables[0].Rows[0]["STATUS"].ToString() == "YES")
					{
						if (con.State == ConnectionState.Open) { con.Close(); con.Open(); } else { con.Open(); }
						SqlCommand cmdsub = new SqlCommand("Update sndb.snlive.dbo.SN_FEEDBACK_FLAG set SFF_SUBMITTED_FLAG='Y' where SFF_PATIENT_ID ='" + HNDPATIPID.Value + "' ", con);
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
			MasterCS.Errorlog(ex, APPLICATIONPATH.TrimStart().TrimEnd().ToString() + "_Pages_Patient_FeedbackIP FindPatientInformationIP");
			ReturnVariable = "ErrorMsg";
		}
		return ReturnVariable;
	}

	protected void Save_Click(object sender, EventArgs e)
	{
		string CHEKFLAG = CHECKBEFOREINSERT();
		if (CHEKFLAG == "NEEDTODO")
		{
			string RESULT = FBIPINSERT();
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

	private string CHECKBEFOREINSERT()
	{
		string ReturnVariable = "";
		try
		{			
			string Query = "select * from sndb.snlive.dbo.FB_PATIENT_FEEDBACK_FORM_IP where FPFI_IP_NUM='"+ HNDPATIPID.Value +"'";
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
			MasterCS.Errorlog(ex, APPLICATIONPATH.TrimStart().TrimEnd().ToString() + "_Pages_Patient_FeedbackIP CHECKBEFOREINSERT");
			ReturnVariable = "ErrorMsg";
		}
		return ReturnVariable;
	}
}