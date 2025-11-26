# 定義 Windows API 以偵測使用者閒置時間
Add-Type @"
using System;
using System.Runtime.InteropServices;

public static class UserInput
{
    [DllImport("user32.dll")]
    public static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);

    [StructLayout(LayoutKind.Sequential)]
    public struct LASTINPUTINFO
    {
        public uint cbSize;
        public uint dwTime;
    }

    public static TimeSpan GetIdleTime()
    {
        LASTINPUTINFO lii = new LASTINPUTINFO();
        lii.cbSize = (uint)Marshal.SizeOf(lii);
        GetLastInputInfo(ref lii);
        return TimeSpan.FromMilliseconds(Environment.TickCount - lii.dwTime);
    }
}
"@

Add-Type -AssemblyName System.Windows.Forms

# 設定參數
$global:activeTime = 0
$checkInterval = 300                   # 檢查間隔 (秒)
$maxUsageTime = 3600                    # 最大使用時間 (秒，60 分鐘)
$idleThreshold = 300                   # 閒置時間閾值 (秒)

# 顯示提醒視窗函數
function ShowReminderForm
{
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "WARNING : Break Reminder"
    $form.Size = "400,350"
    $form.StartPosition = "CenterScreen"
    $form.TopMost = $true
    $form.BackColor = [System.Drawing.Color]::White
    $form.FormBorderStyle = "FixedDialog"

    # 標題標籤
    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Time to take a break!`nYou've been active for 30 minutes."
    $label.Font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $label.ForeColor = [System.Drawing.Color]::Black
    $label.AutoSize = $false
    $label.Size = "350,40"
    $label.Location = "25,30"
    $label.TextAlign = "MiddleCenter"

    # 圖片顯示
    $pictureBox = New-Object System.Windows.Forms.PictureBox
    $pictureBox.Size = "120,120"
    $pictureBox.Location = "140,80"
    $pictureBox.SizeMode = "StretchImage"
    $picturePath = Join-Path $PSScriptRoot "cat.gif"
    $pictureBox.Image = [System.Drawing.Image]::FromFile($picturePath)

    # 確認按鈕
    $btnConfirm = New-Object System.Windows.Forms.Button
    $btnConfirm.Text = "Confirm"
    $btnConfirm.Size = "100,40"
    $btnConfirm.Location = "80,230"
    $btnConfirm.Add_Click({
        $form.Close()
        $global:activeTime = 0                # 重設計時器
    })

    # 取消按鈕
    $btnCancel = New-Object System.Windows.Forms.Button
    $btnCancel.Text = "Cancel"
    $btnCancel.Size = "100,40"
    $btnCancel.Location = "220,230"
    $btnCancel.Add_Click({
        $form.Close()
        Stop-Process -Id $PID              # 終止整個 PowerShell 程式
    })

    # 新增控制項到表單
    $form.Controls.Add($pictureBox)
    $form.Controls.Add($label)
    $form.Controls.Add($btnConfirm)
    $form.Controls.Add($btnCancel)

    $form.ShowDialog()
}

# 初始化監控
Write-Host "Monitoring user activity..."
$idle = [UserInput]::GetIdleTime().TotalSeconds
Write-Host ("Current idle time: " + [math]::Round($idle, 2) + " seconds")
Write-Host ("Accumulated active usage: " + $activeTime + " seconds")

# 主監控迴圈
while ($true)
{
    Start-Sleep -Seconds $checkInterval
    $idle = [UserInput]::GetIdleTime().TotalSeconds
    Write-Host ("Current idle time: " + [math]::Round($idle, 2) + " seconds. ") -NoNewline

    # 檢查是否在活動中
    if ($idle -lt $idleThreshold)
    {
        $global:activeTime += $checkInterval
        Write-Host ("Accumulated active usage: " + $global:activeTime + " seconds")
    }
    else
    {
        Write-Host ("Idle time exceeds " + $idleThreshold + " seconds. Skipping this interval.")
        $global:activeTime = 0
    }

    # 檢查是否超過最大使用時間
    if ($global:activeTime -ge $maxUsageTime)
    {
        ShowReminderForm
    }
}