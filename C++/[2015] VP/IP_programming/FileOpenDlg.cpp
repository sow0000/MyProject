// FileOnenDlg.cpp : implementation file
//

#include "stdafx.h"
#include "IP_programming.h"
#include "FileOpenDlg.h"
#include "afxdialogex.h"


// CFileOpenDlg dialog

IMPLEMENT_DYNAMIC(CFileOpenDlg, CDialogEx)

CFileOpenDlg::CFileOpenDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CFileOpenDlg::IDD, pParent)
	, m_DlgWidth(0)
	, m_DlgHeight(0)
	, m_DlgMode(0)
{

}

CFileOpenDlg::~CFileOpenDlg()
{
}

void CFileOpenDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT1, m_DlgWidth);
	DDX_Text(pDX, IDC_EDIT2, m_DlgHeight);
}


BEGIN_MESSAGE_MAP(CFileOpenDlg, CDialogEx)
	ON_BN_CLICKED(IDC_RADIO1, &CFileOpenDlg::OnBnClickedRadio1)
	ON_BN_CLICKED(IDC_RADIO2, &CFileOpenDlg::OnBnClickedRadio2)
	ON_BN_CLICKED(IDC_RADIO3, &CFileOpenDlg::OnBnClickedRadio3)
END_MESSAGE_MAP()


// CFileOpenDlg message handlers


void CFileOpenDlg::OnBnClickedRadio1()
{
	m_DlgMode=0;
}


void CFileOpenDlg::OnBnClickedRadio2()
{
	m_DlgMode=1;
}


void CFileOpenDlg::OnBnClickedRadio3()
{
	m_DlgMode=2;
}


UINT CFileOpenDlg::GetWidth()
{
	return m_DlgWidth;
}

UINT CFileOpenDlg::GetHeight()
{
	return m_DlgHeight;
}

unsigned char CFileOpenDlg::GetMode()
{
	return m_DlgMode;
}