//
// SharePoint JSLink 
// Change View Column Width
//
// @see
// https://kogzee.wordpress.com/2013/10/21/sharepoint-2013-using-client-side-rendering-jslink-to-change-column-widths-in-lists/
// https://blogs.technet.microsoft.com/sharepoint_support/2014/07/28/jslink-2/
// https://blogs.technet.microsoft.com/sharepoint_support/2014/07/28/jslink-2/
//
(function () {
	// Initialize the variable that stores the objects.
	var overrideCtx = {};
	overrideCtx.Templates = {};
	overrideCtx.OnPostRender = postRenderHandler;

	// Register the template overrides.
	SPClientTemplates.TemplateManager.RegisterTemplateOverrides(overrideCtx);
})();

// ------------------------------------------------------------------
// OnPostRender Event Function
// ------------------------------------------------------------------
function postRenderHandler(ctx) {
	$(“div[name=’Column1’]”).css(“width”, “50px”);
	$(“div[name=’Column2’]”).css(“width”, “100px”);
}
