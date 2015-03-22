
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
#include "NoiseDlg.h"
#include "WindowDlg.h"

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
	ON_COMMAND(ID_BUTTON_FAST_FORWARD, &CIP_programmingView::OnButtonFastForward)
	ON_COMMAND(ID_BUTTON_FAST_REVERSE, &CIP_programmingView::OnButtonFastReverse)
	ON_COMMAND(ID_BUTTON_FORWARD, &CIP_programmingView::OnButtonForward)
	ON_COMMAND(ID_BUTTON_PAUSE, &CIP_programmingView::OnButtonPause)
	ON_COMMAND(ID_BUTTON_PLAY, &CIP_programmingView::OnButtonPlay)
	ON_COMMAND(ID_BUTTON_REVERSE, &CIP_programmingView::OnButtonReverse)
	ON_COMMAND(ID_BUTTON_STOP, &CIP_programmingView::OnButtonStop)
	ON_WM_TIMER()
	ON_UPDATE_COMMAND_UI(ID_BUTTON_FAST_FORWARD, &CIP_programmingView::OnUpdateButtonFastForward)
	ON_UPDATE_COMMAND_UI(ID_BUTTON_FAST_REVERSE, &CIP_programmingView::OnUpdateButtonFastReverse)
	ON_UPDATE_COMMAND_UI(ID_BUTTON_FORWARD, &CIP_programmingView::OnUpdateButtonForward)
	ON_UPDATE_COMMAND_UI(ID_BUTTON_PAUSE, &CIP_programmingView::OnUpdateButtonPause)
	ON_UPDATE_COMMAND_UI(ID_BUTTON_PLAY, &CIP_programmingView::OnUpdateButtonPlay)
	ON_UPDATE_COMMAND_UI(ID_BUTTON_REVERSE, &CIP_programmingView::OnUpdateButtonReverse)
	ON_UPDATE_COMMAND_UI(ID_BUTTON_STOP, &CIP_programmingView::OnUpdateButtonStop)
	ON_COMMAND(ID_FILTER_NOISE, &CIP_programmingView::OnFilterNoise)
	ON_COMMAND(ID_FILTER_MEANFILTER, &CIP_programmingView::OnFilterMeanfilter)
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


void CIP_programmingView::OnButtonFastForward()
{
	KillTimer(2);
	SetTimer(1, 17, NULL);
}


void CIP_programmingView::OnButtonFastReverse()
{
	KillTimer(1);
	SetTimer(2, 17, NULL);
}


void CIP_programmingView::OnButtonForward()
{
	KillTimer(1);
	KillTimer(2);

	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;
	
	pDoc->Image.MyClass_YUVBMP();

	Invalidate(FALSE);
}


void CIP_programmingView::OnButtonPause()
{
	KillTimer(1);
	KillTimer(2);
}


void CIP_programmingView::OnButtonPlay()
{
	KillTimer(2);
	SetTimer(1, 33, NULL);
}


void CIP_programmingView::OnButtonReverse()
{
	KillTimer(1);
	KillTimer(2);

	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	pDoc->Image.MyClass_Reverse();

	Invalidate(FALSE);
}


void CIP_programmingView::OnButtonStop()
{
	KillTimer(1);
	KillTimer(2);

	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	pDoc->Image.MyClass_Stop();

	Invalidate(FALSE);
}


void CIP_programmingView::OnTimer(UINT_PTR nIDEvent)
{
	// TODO: Add your message handler code here and/or call default

	CView::OnTimer(nIDEvent);

	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	if(nIDEvent==1){
		pDoc->Image.MyClass_YUVBMP();
		Invalidate(FALSE);
	}
	else if(nIDEvent==2)
	{
		pDoc->Image.MyClass_Reverse();
		Invalidate(FALSE);
	}
}


void CIP_programmingView::OnUpdateButtonFastForward(CCmdUI *pCmdUI)
{
	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	pCmdUI->Enable(pDoc->Image.MyClass_IsSequence());
}


void CIP_programmingView::OnUpdateButtonFastReverse(CCmdUI *pCmdUI)
{
	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	pCmdUI->Enable(pDoc->Image.MyClass_IsSequence());
}


void CIP_programmingView::OnUpdateButtonForward(CCmdUI *pCmdUI)
{
	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	pCmdUI->Enable(pDoc->Image.MyClass_IsSequence());
}


void CIP_programmingView::OnUpdateButtonPause(CCmdUI *pCmdUI)
{
	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	pCmdUI->Enable(pDoc->Image.MyClass_IsSequence());
}


void CIP_programmingView::OnUpdateButtonPlay(CCmdUI *pCmdUI)
{
	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	pCmdUI->Enable(pDoc->Image.MyClass_IsSequence());
}


void CIP_programmingView::OnUpdateButtonReverse(CCmdUI *pCmdUI)
{
	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	pCmdUI->Enable(pDoc->Image.MyClass_IsSequence());
}


void CIP_programmingView::OnUpdateButtonStop(CCmdUI *pCmdUI)
{
	CIP_programmingDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	pCmdUI->Enable(pDoc->Image.MyClass_IsSequence());
}


void CIP_programmingView::OnFilterNoise()
{
	CNoiseDlg noiseDlg;
	if(noiseDlg.DoModal() == IDOK)
	{
		CIP_programmingDoc* pDoc = GetDocument();
		ASSERT_VALID(pDoc);
		if (!pDoc)
			return;

		pDoc->Image.MyClass_MakeNoise(noiseDlg.getNoise());

		Invalidate(FALSE);
	}
}


void CIP_programmingView::OnFilterMeanfilter()
{
	CWindowDlg windowDlg;
	if(windowDlg.DoModal() == IDOK)
	{
		CIP_programmingDoc* pDoc = GetDocument();
		ASSERT_VALID(pDoc);
		if (!pDoc)
			return;

		pDoc->Image.MyClass_MeanFilter(windowDlg.getWindow());

		Invalidate(FALSE);
	}
}
