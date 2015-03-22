
// IP_programmingDoc.cpp : implementation of the CIP_programmingDoc class
//

#include "stdafx.h"
// SHARED_HANDLERS can be defined in an ATL project implementing preview, thumbnail
// and search filter handlers and allows sharing of document code with that project.
#ifndef SHARED_HANDLERS
#include "IP_programming.h"
#endif

#include "IP_programmingDoc.h"

#include <propkey.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CIP_programmingDoc

IMPLEMENT_DYNCREATE(CIP_programmingDoc, CDocument)

BEGIN_MESSAGE_MAP(CIP_programmingDoc, CDocument)
END_MESSAGE_MAP()


// CIP_programmingDoc construction/destruction

CIP_programmingDoc::CIP_programmingDoc()
{
	// TODO: add one-time construction code here

}

CIP_programmingDoc::~CIP_programmingDoc()
{
}

BOOL CIP_programmingDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: add reinitialization code here
	// (SDI documents will reuse this document)

	return TRUE;
}




// CIP_programmingDoc serialization

void CIP_programmingDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: add storing code here
	}
	else
	{
		// TODO: add loading code here
	}
}

#ifdef SHARED_HANDLERS

// Support for thumbnails
void CIP_programmingDoc::OnDrawThumbnail(CDC& dc, LPRECT lprcBounds)
{
	// Modify this code to draw the document's data
	dc.FillSolidRect(lprcBounds, RGB(255, 255, 255));

	CString strText = _T("TODO: implement thumbnail drawing here");
	LOGFONT lf;

	CFont* pDefaultGUIFont = CFont::FromHandle((HFONT) GetStockObject(DEFAULT_GUI_FONT));
	pDefaultGUIFont->GetLogFont(&lf);
	lf.lfHeight = 36;

	CFont fontDraw;
	fontDraw.CreateFontIndirect(&lf);

	CFont* pOldFont = dc.SelectObject(&fontDraw);
	dc.DrawText(strText, lprcBounds, DT_CENTER | DT_WORDBREAK);
	dc.SelectObject(pOldFont);
}

// Support for Search Handlers
void CIP_programmingDoc::InitializeSearchContent()
{
	CString strSearchContent;
	// Set search contents from document's data. 
	// The content parts should be separated by ";"

	// For example:  strSearchContent = _T("point;rectangle;circle;ole object;");
	SetSearchContent(strSearchContent);
}

void CIP_programmingDoc::SetSearchContent(const CString& value)
{
	if (value.IsEmpty())
	{
		RemoveChunk(PKEY_Search_Contents.fmtid, PKEY_Search_Contents.pid);
	}
	else
	{
		CMFCFilterChunkValueImpl *pChunk = NULL;
		ATLTRY(pChunk = new CMFCFilterChunkValueImpl);
		if (pChunk != NULL)
		{
			pChunk->SetTextValue(PKEY_Search_Contents, value, CHUNK_TEXT);
			SetChunkValue(pChunk);
		}
	}
}

#endif // SHARED_HANDLERS

// CIP_programmingDoc diagnostics

#ifdef _DEBUG
void CIP_programmingDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CIP_programmingDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG


// CIP_programmingDoc commands


BOOL CIP_programmingDoc::OnOpenDocument(LPCTSTR lpszPathName)
{
	if (!CDocument::OnOpenDocument(lpszPathName))
		return FALSE;

	CFileOpenDlg myDlg;
	if(myDlg.DoModal() == IDOK)
	{
		//////////////////////////////////////////////////////////////////
		// Source code
		//  ---> USE FUNCTION, OBJECT ORIENTED PROGRAMMING APPROACH
		//////////////////////////////////////////////////////////////////
		Image.m_uiHeight=myDlg.GetHeight();
		Image.m_uiWidth=myDlg.GetWidth();

		Image.m_pucBMP=(UCHAR*)malloc(Image.m_uiWidth*Image.m_uiHeight*3); //output image

		Image.m_fp=fopen(lpszPathName, "rb"); //file sturct
		
		if(myDlg.GetMode()==0)
		{
			Image.m_uiImgSize=Image.m_uiWidth*Image.m_uiHeight;
			Image.m_pucImgbuf=(UCHAR*)malloc(Image.m_uiImgSize);

			Image.MyClass_GrayBMP();
		}
		else if(myDlg.GetMode()==1)
		{
			Image.m_uiImgSize=Image.m_uiWidth*Image.m_uiHeight*3;
			Image.m_pucImgbuf=(UCHAR*)malloc(Image.m_uiImgSize);

			Image.MyClass_ColorBMP();
		}
		else if(myDlg.GetMode()==2)
		{
			Image.m_bSequence=TRUE;

			Image.m_uiImgSize=(Image.m_uiWidth*Image.m_uiHeight*3)/2;
			Image.m_pucImgbuf=(UCHAR*)malloc(Image.m_uiImgSize);

			Image.MyClass_YUVBMP();
		}
	}

	return TRUE;
}
