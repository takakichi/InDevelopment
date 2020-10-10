using Microsoft.Office.DocumentManagement.DocumentSets;
using Microsoft.SharePoint;
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.UI.WebControls.WebParts;
using System.Linq;
using System.Collections.Generic;
using System.Net.Mail;
using System.Net;
using System.IO;
using System.Web.UI.WebControls;
using System.Text;
using Microsoft.SharePoint.Taxonomy;
using System.Xml;
protected void btnSubmit_Click(object sender, EventArgs e)
          {
                   using (SPSite site = new SPSite(SPContext.Current.Site.Url))
                   {
                             using (SPWeb web = site.OpenWeb())
                             {
                                      #region newdocset
                                      SPList EmployeeDocuments = web.Lists[ÅgLibrary NameÅh];
                                      if (EmployeeDocuments != null)
                                      {
                                                SPContentType contentType = web.ContentTypes[ÅgDocument SetÅh];
                                                if (contentType != null)
                                                {
                                                          var hashTable = new Hashtable();
                                                          hashTable.Add(ÅgDocumentSet1Åh, ÅgNew Doc SettingÅh);
                                                          DocumentSet documentSet = DocumentSet.Create(EmployeeDocuments.RootFolder, DocumentSetName, EmployeeDocuments.ContentTypes.BestMatch(contentType.Id), hashTable, true);
                                                          documentSet.Item.ProgId = ÅgSharePoint.DocumentSetÅh;
                                                          web.AllowUnsafeUpdates = true;
                                                          try
                                                          {
                                                                   documentSet.Item.Update();
                                                          }
                                                         catch { }
                                                          web.AllowUnsafeUpdates = false;
                                                }
                                      }
                                      #endregion
                                      #region LinkToDocument
                                      if (EmployeeDocuments is SPDocumentLibrary)
                                      {
                                                SPDocumentLibrary docLib = (SPDocumentLibrary)EmployeeDocuments;
                                                if (docLib.ContentTypesEnabled)
                                                {
                                                          SPContentType myCType = EmployeeDocuments.ContentTypes[ÅgLink to a DocumentÅh];
                                                          if (myCType != null)
                                                          {
                                                                   SPFolder Folder = web.GetFolder(DocumentSetName);
                                                                   string redirectAspx = RedirectAspxPage();
                                                                   string replaceURL = redirectAspx.Replace(Åg{0}Åh, ÅgURL of file in libraryÅh);
                                                                   string replaceDocumentType = redirectAspx.Replace(ÅgdocxÅh, Åg<file type>Åh);
                                                                   SPFile file = Folder.Files.Add(web.Url + Åg/Åh + EmployeeDocuments.Title + Åg/Åh + Folder.Url + Åg/Åh + Ågfile nameÅh + Åg.aspxÅh, UTF8Encoding.UTF8.GetBytes(replaceDocumentType));
                                                                   //set list item properties
                                                                   SPListItem item = file.Item;
                                                                   SPContentType contentTypeLink = web.ContentTypes[ÅgLink to a DocumentÅh];
                                                                   item[ÅgContentTypeIdÅh] = contentTypeLink.Id;
                                                                   item.Update();
                                                                   if (item[ÅgContentTypeÅh].ToString() == ÅgLink to a DocumentÅh)
                                                                   {
                                                                             SPFieldUrlValue fieldUrl = new SPFieldUrlValue() { Description = ÅgLink To Åh + Ågfile nameÅh, Url = Ågurl of file in libraryÅh };
                                                                             item[ÅgURLÅh] = fieldUrl;
                                                                             item.Update();
                                                                   }
                                                          }
                                                }
                                      }
                                      #endregion
                             }
                   }
          }
public static string RedirectAspxPage()
          {
                   StringBuilder builder = new StringBuilder();
                   builder.AppendLine(Åg<%@ Register TagPrefix=ÅfSharePointÅf Namespace=ÅfMicrosoft.SharePoint.WebControlsÅf Assembly=ÅfMicrosoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429cÅf %>Åh);
                   builder.AppendLine(Åg<%@ Import Namespace=ÅfSystem.IOÅf %>Åh);
                   builder.AppendLine(Åg<%@ Import Namespace=ÅfMicrosoft.SharePointÅf %>Åh);
                   builder.AppendLine(Åg<%@ Import Namespace=ÅfMicrosoft.SharePoint.UtilitiesÅf %>Åh);
                   builder.AppendLine(Åg<%@ Import Namespace=ÅfMicrosoft.SharePoint.WebControlsÅf %>Åh);
                   builder.AppendLine(Åg<html xmlns:mso=\Åhurn:schemas-microsoft-com:office:office\Åh xmlns:msdt=\Åhuuid:C2F41010-65B3-11d1-A29F-00AA00C14882\Åh>Åh);
                   builder.AppendLine(Åg<head>Åh);
                   builder.AppendLine(Åg<meta name=\ÅhWebPartPageExpansion\Åh content=\Åhfull\Åh /> <meta name=ÅfprogidÅf content=ÅfSharePoint.LinkÅf /> Åg);
                   builder.AppendLine(Åg<!?[if gte mso 9]><SharePoint:CTFieldRefs runat=server Prefix=\Åhmso:\Åh FieldList=\ÅhFileLeafRef,URL\Åh><xml>Åh);
                   builder.AppendLine(Åg<mso:CustomDocumentProperties>Åh);
                   builder.AppendLine(Åg<mso:ContentTypeId msdt:dt=\Åhstring\Åh>0x01010A00DC3917D9FAD55147B56FF78B40FF3ABB</mso:ContentTypeId>Åh);
                   builder.AppendLine(Åg<mso:IconOverlay msdt:dt=\Åhstring\Åh>|docx|linkoverlay.gif</mso:IconOverlay;
                   builder.AppendLine(Åg<mso:URL msdt:dt=\Åhstring\Åh>{0}, {0}</mso:URL>Åh);
                   builder.AppendLine(Åg</mso:CustomDocumentProperties>Åh);
                   builder.AppendLine(Åg</xml></SharePoint:CTFieldRefs><![endif]?>Åh);
                   builder.AppendLine(Åg</head>Åh);
                   builder.AppendLine(Åg<body>Åh);
                   builder.AppendLine(Åg<form id=ÅfForm1Åå runat=ÅfserverÅf>Åh);
                   builder.AppendLine(Åg<SharePoint:UrlRedirector id=ÅfRedirector1Åå runat=ÅfserverÅf />Åh);
                   builder.AppendLine(Åg</form>Åh);
                   builder.AppendLine(Åg</body>Åh);
                   builder.AppendLine(Åg</html>Åh);
                   return builder.ToString();
          }
                   StringBuilder builder = new StringBuilder();
                   builder.AppendLine(Åg<%@ Register TagPrefix=ÅfSharePointÅf Namespace=ÅfMicrosoft.SharePoint.WebControlsÅf Assembly=ÅfMicrosoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429cÅf %>Åh);
                   builder.AppendLine(Åg<%@ Import Namespace=ÅfSystem.IOÅf %>Åh);
                   builder.AppendLine(Åg<%@ Import Namespace=ÅfMicrosoft.SharePointÅf %>Åh);
                   builder.AppendLine(Åg<%@ Import Namespace=ÅfMicrosoft.SharePoint.UtilitiesÅf %>Åh);
                   builder.AppendLine(Åg<%@ Import Namespace=ÅfMicrosoft.SharePoint.WebControlsÅf %>Åh);
                   builder.AppendLine(Åg<html xmlns:mso=\Åhurn:schemas-microsoft-com:office:office\Åh xmlns:msdt=\Åhuuid:C2F41010-65B3-11d1-A29F-00AA00C14882\Åh>Åh);
                   builder.AppendLine(Åg<head>Åh);
                   builder.AppendLine(Åg<meta name=\ÅhWebPartPageExpansion\Åh content=\Åhfull\Åh /> <meta name=ÅfprogidÅf content=ÅfSharePoint.LinkÅf /> Åg);
                   builder.AppendLine(Åg<!?[if gte mso 9]><SharePoint:CTFieldRefs runat=server Prefix=\Åhmso:\Åh FieldList=\ÅhFileLeafRef,URL\Åh><xml>Åh);
                   builder.AppendLine(Åg<mso:CustomDocumentProperties>Åh);
                   builder.AppendLine(Åg<mso:ContentTypeId msdt:dt=\Åhstring\Åh>0x01010A00DC3917D9FAD55147B56FF78B40FF3ABB</mso:ContentTypeId>Åh);
                   builder.AppendLine(Åg<mso:IconOverlay msdt:dt=\Åhstring\Åh>|docx|linkoverlay.gif</mso:IconOverlay;
                   builder.AppendLine(Åg<mso:URL msdt:dt=\Åhstring\Åh>{0}, {0}</mso:URL>Åh);
                   builder.AppendLine(Åg</mso:CustomDocumentProperties>Åh);
                   builder.AppendLine(Åg</xml></SharePoint:CTFieldRefs><![endif]?>Åh);
                   builder.AppendLine(Åg</head>Åh);
                   builder.AppendLine(Åg<body>Åh);
                   builder.AppendLine(Åg<form id=ÅfForm1Åå runat=ÅfserverÅf>Åh);
                   builder.AppendLine(Åg<SharePoint:UrlRedirector id=ÅfRedirector1Åå runat=ÅfserverÅf />Åh);
                   builder.AppendLine(Åg</form>Åh);
                   builder.AppendLine(Åg</body>Åh);
                   builder.AppendLine(Åg</html>Åh);
                   return builder.ToString();
          }
