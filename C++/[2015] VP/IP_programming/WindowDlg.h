#pragma once


// CWindowDlg dialog

class CWindowDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CWindowDlg)

public:
	CWindowDlg(CWnd* pParent = NULL);   // standard constructor
	virtual ~CWindowDlg();

// Dialog Data
	enum { IDD = IDD_DIALOG3 };

	UINT getWindow();

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
private:
	UINT m_DlgWindow;
};
