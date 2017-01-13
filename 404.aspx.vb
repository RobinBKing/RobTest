Imports SatLib

Public Class _404
    Inherits SatFrontEnd.SatPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Response.StatusCode = 404

    End Sub

End Class