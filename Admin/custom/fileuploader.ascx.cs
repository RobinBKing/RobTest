namespace Admin
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
    using ObjectLibrary;
	using System.Data.SqlClient;

	/// <summary>
	///		Summary description for imagerotate.
	/// </summary>
    public class fileuploader : WebBack.core.controls.ControlDef
	{
		protected HtmlInputFile ImageFile;
		protected Literal FileDisplay; 
		Literal errorMessage = new Literal();

		public override void Page_Load(object sender, System.EventArgs e)
		{
			if(WBTools.IsNumeric(Request.QueryString["View"]) && Request.QueryString["View"] != "")
			{
				ImageFile.Disabled=true;
			}	
			Trace.Write("LOading status: " + this.CurrentStatus);
			DataTable dt = WBData.GetDataTable("Select * from wb_Files" + this.CurrentStatus + " where ArchiveId=" + this.ArchiveId);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                if (System.IO.File.Exists(Server.MapPath("../../Files/" + dr["FileName"])))
                {
                    FileDisplay.Text = "<a target=_blank href='../../Files/" + dr["FileName"] + "'>" + dr["FileName"] + "</a>";
                }
               
            }
		}

        public override void takeAction(ref SqlTransaction trans)
        {		
			Trace.Write("Saving status: " + this.CurrentStatus);

			string fieldValue = "";

			Trace.Write("Uploading...",System.IO.Path.GetFileName(ImageFile.PostedFile.FileName));				
			if(null != ImageFile.PostedFile && ImageFile.PostedFile.FileName != "" )
			{	

				if(Request.QueryString["Edit"] != "-1")
				{
					Trace.Write("Uploading Existing...",System.IO.Path.GetFileName(ImageFile.PostedFile.FileName));
					string ext = System.IO.Path.GetExtension(ImageFile.PostedFile.FileName).ToLower();
										
					fieldValue = ArchiveId + "_Image" + ext;
					ImageFile.PostedFile.SaveAs(Server.MapPath("../../Files/" + ArchiveId + "_" + System.IO.Path.GetFileName(ImageFile.PostedFile.FileName)));																	
					
					WBData.ExecuteSql("Update WB_FilesQueued Set FileName='" + ArchiveId + "_" + System.IO.Path.GetFileName(ImageFile.PostedFile.FileName) + "' where Id=" + Request.QueryString["id"],trans);
	//				Trace.Write("executetest.","Update Files Set FileName='" + ArchiveId + "_" + System.IO.Path.GetFileName(ImageFile.PostedFile.FileName) + "' where WebBackObjectSet=" + WebBackObjectSetId);
                    FileDisplay.Text = "<a target=_blank href='../../Files/" + ArchiveId + "_" + System.IO.Path.GetFileName(ImageFile.PostedFile.FileName) + "'>" + ArchiveId + "_" + System.IO.Path.GetFileName(ImageFile.PostedFile.FileName) + "</a>";
				}
                else if (!System.IO.File.Exists(Server.MapPath("../Files../" + ArchiveId + "_" + System.IO.Path.GetFileName(ImageFile.PostedFile.FileName))))
				{
					Trace.Write("Uploading new...",System.IO.Path.GetFileName(ImageFile.PostedFile.FileName));

					string ext = System.IO.Path.GetExtension(ImageFile.PostedFile.FileName).ToLower();
										
					fieldValue = ArchiveId + "_Image" + ext;
                    ImageFile.PostedFile.SaveAs(Server.MapPath("../../Files/" + ArchiveId + "_" + System.IO.Path.GetFileName(ImageFile.PostedFile.FileName)));

                    WBData.ExecuteSql("Update WB_FilesQueued Set FileName='" + ArchiveId + "_" + System.IO.Path.GetFileName(ImageFile.PostedFile.FileName) + "' where id=" + Request.QueryString["id"], trans);
                    FileDisplay.Text = "<a target=_blank href='../../Files/" + ArchiveId + "_" + System.IO.Path.GetFileName(ImageFile.PostedFile.FileName) + "'>" + ArchiveId + "_" + System.IO.Path.GetFileName(ImageFile.PostedFile.FileName) + "</a>";
				}
				else
				{
					errorMessage.Text = "The Filename '" + System.IO.Path.GetFileName(ImageFile.PostedFile.FileName) + "' already exists, please rename the file and try again.";							
					WBData.ExecuteSql("Select TotalFailure from something",trans);
				}
			}

            
		}
			



		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
