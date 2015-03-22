
// IP_programmingView.h : interface of the CIP_programmingView class
//

#pragma once


class CIP_programmingView : public CView
{
protected: // create from serialization only
	CIP_programmingView();
	DECLARE_DYNCREATE(CIP_programmingView)

// Attributes
public:
	CIP_programmingDoc* GetDocument() const;

// Operations
public:

// Overrides
public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);

// Implementation
public:
	virtual ~CIP_programmingView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnButtonFastForward();
	afx_msg void OnButtonFastReverse();
	afx_msg void OnButtonForward();
	afx_msg void OnButtonPause();
	afx_msg void OnButtonPlay();
	afx_msg void OnButtonReverse();
	afx_msg void OnButtonStop();
	afx_msg void OnTimer(UINT_PTR nIDEvent);
	afx_msg void OnUpdateButtonFastForward(CCmdUI *pCmdUI);
	afx_msg void OnUpdateButtonFastReverse(CCmdUI *pCmdUI);
	afx_msg void OnUpdateButtonForward(CCmdUI *pCmdUI);
	afx_msg void OnUpdateButtonPause(CCmdUI *pCmdUI);
	afx_msg void OnUpdateButtonPlay(CCmdUI *pCmdUI);
	afx_msg void OnUpdateButtonReverse(CCmdUI *pCmdUI);
	afx_msg void OnUpdateButtonStop(CCmdUI *pCmdUI);
	afx_msg void OnFilterNoise();
	afx_msg void OnFilterMeanfilter();
};

#ifndef _DEBUG  // debug version in IP_programmingView.cpp
inline CIP_programmingDoc* CIP_programmingView::GetDocument() const
   { return reinterpret_cast<CIP_programmingDoc*>(m_pDocument); }
#endif

