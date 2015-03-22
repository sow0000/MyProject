
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
};

#ifndef _DEBUG  // debug version in IP_programmingView.cpp
inline CIP_programmingDoc* CIP_programmingView::GetDocument() const
   { return reinterpret_cast<CIP_programmingDoc*>(m_pDocument); }
#endif

