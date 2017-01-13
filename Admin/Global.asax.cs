using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace WebBack.Admin {
    public class Global : System.Web.HttpApplication {

        protected void Application_Start(object sender, EventArgs e) {
            //ObjectLibrary.WebBackInstance.PasswordPolicy.Enabled = false;
            ObjectLibrary.WebBackInstance.Module_LinkChecker.Enabled = true;
            WebBack.WBPage.WBAction = new WebBack.Custom.CustomActions();
        }

        // initialize our internal default WebBack behaviors
        public override void Init()
        {
            base.Init();
            WBGlobalProxy.Init(this);
        }

        protected void Session_Start(object sender, EventArgs e) {

        }

        protected void Application_BeginRequest(object sender, EventArgs e) {
            ObjectLibrary.WBTools.SetQueryStringTrace();
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e) {

        }

        protected void Application_Error(object sender, EventArgs e) {

        }

        protected void Session_End(object sender, EventArgs e) {

        }

        protected void Application_End(object sender, EventArgs e) {

        }
    }
}