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
                                      SPList EmployeeDocuments = web.Lists[�gLibrary Name�h];
                                      if (EmployeeDocuments != null)
                                      {
                                                SPContentType contentType = web.ContentTypes[�gDocument Set�h];
                                                if (contentType != null)
                                                {
                                                          var hashTable = new Hashtable();
                                                          hashTable.Add(�gDocumentSet1�h, �gNew Doc Setting�h);
                                                          DocumentSet documentSet = DocumentSet.Create(EmployeeDocuments.RootFolder, DocumentSetName, EmployeeDocuments.ContentTypes.BestMatch(contentType.Id), hashTable, true);
                                                          documentSet.Item.ProgId = �gSharePoint.DocumentSet�h;
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
                                                          SPContentType myCType = EmployeeDocuments.ContentTypes[�gLink to a Document�h];
                                                          if (myCType != null)
                                                          {
                                                                   SPFolder Folder = web.GetFolder(DocumentSetName);
                                                                   string redirectAspx = RedirectAspxPage();
                                                                   string replaceURL = redirectAspx.Replace(�g{0}�h, �gURL of file in library�h);
                                                                   string replaceDocumentType = redirectAspx.Replace(�gdocx�h, �g<file type>�h);
                                                                   SPFile file = Folder.Files.Add(web.Url + �g/�h + EmployeeDocuments.Title + �g/�h + Folder.Url + �g/�h + �gfile name�h + �g.aspx�h, UTF8Encoding.UTF8.GetBytes(replaceDocumentType));
                                                                   //set list item properties
                                                                   SPListItem item = file.Item;
                                                                   SPContentType contentTypeLink = web.ContentTypes[�gLink to a Document�h];
                                                                   item[�gContentTypeId�h] = contentTypeLink.Id;
                                                                   item.Update();
                                                                   if (item[�gContentType�h].ToString() == �gLink to a Document�h)
                                                                   {
                                                                             SPFieldUrlValue fieldUrl = new SPFieldUrlValue() { Description = �gLink To �h + �gfile name�h, Url = �gurl of file in library�h };
                                                                             item[�gURL�h] = fieldUrl;
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
                   builder.AppendLine(�g<%@ Register TagPrefix=�fSharePoint�f Namespace=�fMicrosoft.SharePoint.WebControls�f Assembly=�fMicrosoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c�f %>�h);
                   builder.AppendLine(�g<%@ Import Namespace=�fSystem.IO�f %>�h);
                   builder.AppendLine(�g<%@ Import Namespace=�fMicrosoft.SharePoint�f %>�h);
                   builder.AppendLine(�g<%@ Import Namespace=�fMicrosoft.SharePoint.Utilities�f %>�h);
                   builder.AppendLine(�g<%@ Import Namespace=�fMicrosoft.SharePoint.WebControls�f %>�h);
                   builder.AppendLine(�g<html xmlns:mso=\�hurn:schemas-microsoft-com:office:office\�h xmlns:msdt=\�huuid:C2F41010-65B3-11d1-A29F-00AA00C14882\�h>�h);
                   builder.AppendLine(�g<head>�h);
                   builder.AppendLine(�g<meta name=\�hWebPartPageExpansion\�h content=\�hfull\�h /> <meta name=�fprogid�f content=�fSharePoint.Link�f /> �g);
                   builder.AppendLine(�g<!?[if gte mso 9]><SharePoint:CTFieldRefs runat=server Prefix=\�hmso:\�h FieldList=\�hFileLeafRef,URL\�h><xml>�h);
                   builder.AppendLine(�g<mso:CustomDocumentProperties>�h);
                   builder.AppendLine(�g<mso:ContentTypeId msdt:dt=\�hstring\�h>0x01010A00DC3917D9FAD55147B56FF78B40FF3ABB</mso:ContentTypeId>�h);
                   builder.AppendLine(�g<mso:IconOverlay msdt:dt=\�hstring\�h>|docx|linkoverlay.gif</mso:IconOverlay;
                   builder.AppendLine(�g<mso:URL msdt:dt=\�hstring\�h>{0}, {0}</mso:URL>�h);
                   builder.AppendLine(�g</mso:CustomDocumentProperties>�h);
                   builder.AppendLine(�g</xml></SharePoint:CTFieldRefs><![endif]?>�h);
                   builder.AppendLine(�g</head>�h);
                   builder.AppendLine(�g<body>�h);
                   builder.AppendLine(�g<form id=�fForm1�� runat=�fserver�f>�h);
                   builder.AppendLine(�g<SharePoint:UrlRedirector id=�fRedirector1�� runat=�fserver�f />�h);
                   builder.AppendLine(�g</form>�h);
                   builder.AppendLine(�g</body>�h);
                   builder.AppendLine(�g</html>�h);
                   return builder.ToString();
          }
                   StringBuilder builder = new StringBuilder();
                   builder.AppendLine(�g<%@ Register TagPrefix=�fSharePoint�f Namespace=�fMicrosoft.SharePoint.WebControls�f Assembly=�fMicrosoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c�f %>�h);
                   builder.AppendLine(�g<%@ Import Namespace=�fSystem.IO�f %>�h);
                   builder.AppendLine(�g<%@ Import Namespace=�fMicrosoft.SharePoint�f %>�h);
                   builder.AppendLine(�g<%@ Import Namespace=�fMicrosoft.SharePoint.Utilities�f %>�h);
                   builder.AppendLine(�g<%@ Import Namespace=�fMicrosoft.SharePoint.WebControls�f %>�h);
                   builder.AppendLine(�g<html xmlns:mso=\�hurn:schemas-microsoft-com:office:office\�h xmlns:msdt=\�huuid:C2F41010-65B3-11d1-A29F-00AA00C14882\�h>�h);
                   builder.AppendLine(�g<head>�h);
                   builder.AppendLine(�g<meta name=\�hWebPartPageExpansion\�h content=\�hfull\�h /> <meta name=�fprogid�f content=�fSharePoint.Link�f /> �g);
                   builder.AppendLine(�g<!?[if gte mso 9]><SharePoint:CTFieldRefs runat=server Prefix=\�hmso:\�h FieldList=\�hFileLeafRef,URL\�h><xml>�h);
                   builder.AppendLine(�g<mso:CustomDocumentProperties>�h);
                   builder.AppendLine(�g<mso:ContentTypeId msdt:dt=\�hstring\�h>0x01010A00DC3917D9FAD55147B56FF78B40FF3ABB</mso:ContentTypeId>�h);
                   builder.AppendLine(�g<mso:IconOverlay msdt:dt=\�hstring\�h>|docx|linkoverlay.gif</mso:IconOverlay;
                   builder.AppendLine(�g<mso:URL msdt:dt=\�hstring\�h>{0}, {0}</mso:URL>�h);
                   builder.AppendLine(�g</mso:CustomDocumentProperties>�h);
                   builder.AppendLine(�g</xml></SharePoint:CTFieldRefs><![endif]?>�h);
                   builder.AppendLine(�g</head>�h);
                   builder.AppendLine(�g<body>�h);
                   builder.AppendLine(�g<form id=�fForm1�� runat=�fserver�f>�h);
                   builder.AppendLine(�g<SharePoint:UrlRedirector id=�fRedirector1�� runat=�fserver�f />�h);
                   builder.AppendLine(�g</form>�h);
                   builder.AppendLine(�g</body>�h);
                   builder.AppendLine(�g</html>�h);
                   return builder.ToString();
          }
