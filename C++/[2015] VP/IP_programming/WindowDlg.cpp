// WindowDlg.cpp : implementation file
//

#include "stdafx.h"
#include "IP_programming.h"
#include "WindowDlg.h"
#include "afxdialogex.h"


// CWindowDlg dialog

IMPLEMENT_DYNAMIC(CWindowDlg, CDialogEx)

CWindowDlg::CWindowDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CWindowDlg::IDD, pParent)
	, m_DlgWindow(0)
{

}

CWindowDlg::~CWindowDlg()
{
}

void CWindowDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT1, m_DlgWindow);
	DDV_MinMaxUInt(pDX, m_DlgWindow, 1, 9);
}


BEGIN_MESSAGE_MAP(CWindowDlg, CDialogEx)
END_MESSAGE_MAP()


// CWindowDlg message handlers

UINT CWindowDlg::getWindow()
{
	return m_DlgWindow;
}