#pragma once


// CFileOpenDlg dialog

class CFileOpenDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CFileOpenDlg)

public:
	CFileOpenDlg(CWnd* pParent = NULL);   // standard constructor
	virtual ~CFileOpenDlg();

// Dialog Data
	enum { IDD = IDD_DIALOG1 };

	afx_msg void OnBnClickedRadio1();
	afx_msg void OnBnClickedRadio2();

	UINT GetWidth();
	UINT GetHeight();
	UCHAR GetMode();

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()

private:
	UINT m_DlgWidth;
	UINT m_DlgHeight;
	UCHAR m_DlgMode;
};
