
// IP_programmingView.cpp : implementation of the CIP_programmingView class
//

#include "stdafx.h"
// SHARED_HANDLERS can be defined in an ATL project implementing preview, thumbnail
// and search filter handlers and allows sharing of document code with that project.
#ifndef SHARED_HANDLERS
#include "IP_programming.h"
#endif

#include "IP_programmingDoc.h"
#include "IP_programmingView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CIP_programmingView

IMPLEMENT_DYNCREATE(CIP_programmingView, CView)

BEGIN_MESSAGE_MAP(CIP_programmingView, CView)
	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, &CView::OnFilePrintPreview)
END_MESSAGE_MAP()

// CIP_programmingView construction/destruction

CIP_programmingView::CIP_programmingView()
{
	// TODO: add construction code here

}

CIP_programmingView::~CIP_programmingView()
{
}

BOOL CIP_programmingView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return CView::PreCreateWindow(cs);
}

// CIP_programmingView drawing

void CIP_programmingView::OnDraw(CDC* pDC)
{
	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	// Show BMP image
	if(pDoc->Image.m_pucBMP)
	{
		StretchDIBits(pDC->GetSafeHdc(),
			0, 0, pDoc->Image.m_uiWidth, pDoc->Image.m_uiHeight,
			0, 0, pDoc->Image.m_BMPheader.biWidth, pDoc->Image.m_BMPheader.biHeight,
			pDoc->Image.m_pucBMP, (LPBITMAPINFO)&pDoc->Image.m_BMPheader, DIB_RGB_COLORS, SRCCOPY);
	}
}


// CIP_programmingView printing

BOOL CIP_programmingView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// default preparation
	return DoPreparePrinting(pInfo);
}

void CIP_programmingView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add extra initialization before printing
}

void CIP_programmingView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add cleanup after printing
}


// CIP_programmingView diagnostics

#ifdef _DEBUG
void CIP_programmingView::AssertValid() const
{
	CView::AssertValid();
}

void CIP_programmingView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CIP_programmingDoc* CIP_programmingView::GetDocument() const // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CIP_programmingDoc)));
	return (CIP_programmingDoc*)m_pDocument;
}
#endif //_DEBUG


// CIP_programmingView message handlers
