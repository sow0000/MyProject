#pragma once


// CNoiseDlg dialog

class CNoiseDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CNoiseDlg)

public:
	CNoiseDlg(CWnd* pParent = NULL);   // standard constructor
	virtual ~CNoiseDlg();

// Dialog Data
	enum { IDD = IDD_DIALOG2 };

	UINT getNoise();

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
private:
	UINT m_DlgNoise;
};