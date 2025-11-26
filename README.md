### 簡單的辦公室電腦小工具
可以幫你開機後自動進入最佳工作視窗配置

#### 2025/11/26新增滑鼠控制
簡單說有些公司的電腦可能會限制你的螢幕閒置時間不超過15分鐘，為了防止別人在你不在的時候偷用你電腦。而假設你摸魚超過15分鐘，你的電腦畫面就會黑掉，摸魚可以但太明顯不太好，因此可以用這種方式來規避15分鐘自動黑屏的硬性設置。
也可以頻率變高，讓你微軟teams的橘燈不要太常亮起來，避免別人以為你很閒。


# Simple Office Computer Toolkit

A collection of automation scripts to optimize your workspace setup and activity monitoring.

## Features

### 🖥️ Automatic Window Configuration
Automatically opens your essential work programs and folders after boot, setting up your optimal workspace configuration instantly.

### 🖱️ Mouse Activity Monitor (New - 2025/11/26)
Automatically moves the mouse cursor at regular intervals to prevent screen lock timeouts and maintain active status.

---

## Why Use This?

Many corporate IT policies enforce automatic screen lock after 15 minutes of inactivity to prevent unauthorized access to unattended computers. However, this can interfere with your workflow when you need to step away briefly.

### Problem Scenarios:
- Your screen locks while you're taking a quick break
- Your company restricts idle time to prevent security risks
- You want to maintain "active" status on communication apps (like Microsoft Teams) to avoid appearing unavailable

### Solution:
This toolkit provides two complementary scripts:

1. **Batch Startup Script** - Automatically launches all your work tools at boot
2. **Mouse Monitor Script** - Keeps your system active by:
   - Detecting inactivity periods
   - Automatically moving the mouse after a configurable idle threshold (default: 5 minutes)
   - Preventing automatic screen lock
   - Maintaining your "online" status on chat applications

### Additional Benefits:
- Keeps your Microsoft Teams indicator from showing as "Away" or "Idle"
- Avoids drawing unnecessary attention with constant activity
- Seamless integration with your daily workflow

---

## Scripts Included

### `startup.bat`
Batch script that launches your preferred applications and folders on startup.

**Customizable elements:**
- Folders to open (File Explorer windows)
- Applications to launch
- Launch delays and order

### `mouse_monitor.ps1`
PowerShell script that monitors system inactivity and prevents screen lock.

**Key features:**
- Smooth, natural mouse movement
- Automatic detection of user inactivity
- Configurable idle threshold
- Alternates between preset cursor positions
- Includes activity logging

### `eye_protect.ps1`
PowerShell script that reminds you to take breaks during extended work sessions.

**Key features:**
- Tracks active usage time
- Displays break reminder after 60 minutes of continuous activity
- Distinguishes between active work and idle periods
- Customizable reminder messages

---

## Installation & Setup

1. Download all scripts to your preferred directory
2. Edit paths and parameters as needed:
   - Update folder paths in `startup.bat`
   - Adjust mouse positions in `mouse_monitor.ps1`
   - Configure break intervals in `eye_protect.ps1`
3. Add `startup.bat` to Windows startup folder or Task Scheduler
4. Run PowerShell scripts with appropriate execution policy

---

## Customization

### Mouse Monitor Settings:
```powershell
$pos1 = [PSCustomObject]@{ X = 200; Y = 250 }  # First position
$pos2 = [PSCustomObject]@{ X = 200; Y = 300 }  # Second position
$checkInterval = 300                             # Check every 5 minutes
$idleThreshold = 300                             # 5 minutes before activity triggers
```

### Eye Protection Settings:
```powershell
$checkInterval = 300       # Check every 5 minutes
$maxUsageTime = 3600       # 60 minutes before reminder
$idleThreshold = 300       # Ignore intervals if idle over 5 minutes
```

---

## Disclaimer

⚠️ **Important:** Use this toolkit responsibly and in accordance with your company's IT policies. This tool is designed to help with legitimate workflow optimization, not to circumvent security policies maliciously.

Always ensure you have permission to modify your system configuration and run automation scripts in your work environment.

---

## Last Updated
November 26, 2025
