
// IP_programming.h : main header file for the IP_programming application
//
#pragma once

#ifndef __AFXWIN_H__
	#error "include 'stdafx.h' before including this file for PCH"
#endif

#include "resource.h"       // main symbols


// CIP_programmingApp:
// See IP_programming.cpp for the implementation of this class
//

class CIP_programmingApp : public CWinApp
{
public:
	CIP_programmingApp();


// Overrides
public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();

// Implementation
	afx_msg void OnAppAbout();
	DECLARE_MESSAGE_MAP()
};

extern CIP_programmingApp theApp;
