
// IP_programmingDoc.h : interface of the CIP_programmingDoc class
//


#pragma once
#include "IP_ProgrammingMyClass.h"
#include "FileOpenDlg.h"


class CIP_programmingDoc : public CDocument
{
protected: // create from serialization only
	CIP_programmingDoc();
	DECLARE_DYNCREATE(CIP_programmingDoc)

// Attributes
public:
	CIP_ProgrammingMyClass Image;

// Operations
public:

// Overrides
public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
#ifdef SHARED_HANDLERS
	virtual void InitializeSearchContent();
	virtual void OnDrawThumbnail(CDC& dc, LPRECT lprcBounds);
#endif // SHARED_HANDLERS

// Implementation
public:
	virtual ~CIP_programmingDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	DECLARE_MESSAGE_MAP()

#ifdef SHARED_HANDLERS
	// Helper function that sets search content for a Search Handler
	void SetSearchContent(const CString& value);
#endif // SHARED_HANDLERS
public:
	virtual BOOL OnOpenDocument(LPCTSTR lpszPathName);
};
