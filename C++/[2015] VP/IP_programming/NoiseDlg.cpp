// NoiseDlg.cpp : implementation file
//

#include "stdafx.h"
#include "IP_programming.h"
#include "NoiseDlg.h"
#include "afxdialogex.h"


// CNoiseDlg dialog

IMPLEMENT_DYNAMIC(CNoiseDlg, CDialogEx)

CNoiseDlg::CNoiseDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CNoiseDlg::IDD, pParent)
	, m_DlgNoise(0)
{

}

CNoiseDlg::~CNoiseDlg()
{
}

void CNoiseDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT1, m_DlgNoise);
	DDV_MinMaxUInt(pDX, m_DlgNoise, 0, 100);
}


BEGIN_MESSAGE_MAP(CNoiseDlg, CDialogEx)
END_MESSAGE_MAP()


// CNoiseDlg message handlers

UINT CNoiseDlg::getNoise()
{
	return m_DlgNoise;
}