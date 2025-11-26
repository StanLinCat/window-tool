#類型定義（僅在未定義時載入）
if (-not ("Mouse" -as [type]))
{
    Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class InputMonitor
{
    [DllImport("user32.dll")]
    private static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);

    [StructLayout(LayoutKind.Sequential)]
    private struct LASTINPUTINFO
    {
        public uint cbSize;
        public uint dwTime;
    }

    public static uint GetLastInputTime()
    {
        LASTINPUTINFO lastInputInfo = new LASTINPUTINFO();
        lastInputInfo.cbSize = (uint)Marshal.SizeOf(lastInputInfo);
        if (!GetLastInputInfo(ref lastInputInfo))
        {
            return 0;
        }
        return lastInputInfo.dwTime;
    }
}

public class Mouse
{
    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);

    [DllImport("user32.dll")]
    public static extern void mouse_event(int dwFlags, int dx, int dy, int cButtons, int dwExtraInfo);

    [DllImport("user32.dll")]
    public static extern bool GetCursorPos(ref POINT lpPoint);

    [StructLayout(LayoutKind.Sequential)]
    public struct POINT
    {
        public int X;
        public int Y;
    }

    public const int MOUSEEVENTF_LEFTDOWN = 0x02;
    public const int MOUSEEVENTF_LEFTUP = 0x04;
}
"@
}

#滑鼠目標座標定義
$pos1 = [PSCustomObject]@{
    X = 200
    Y = 250
}

$pos2 = [PSCustomObject]@{
    X = 200
    Y = 300
}

$currentPos = $pos1
$movementSpeed = 30                         # 每步延遲（毫秒）

#平滑移動並點擊函數
function SmoothMoveTo
{
    param (
        [int]$targetX,
        [int]$targetY
    )

    $steps = 20
    $startPoint = New-Object Mouse+POINT
    [Mouse]::GetCursorPos([ref]$startPoint)
    $startX = $startPoint.X
    $startY = $startPoint.Y

    Write-Host "Moving from ($startX, $startY) to ($targetX, $targetY)"

    # 平滑移動到目標位置
    for ($i = 1; $i -le $steps; $i++)
    {
        $x = $startX + (($targetX - $startX) * $i / $steps)
        $y = $startY + (($targetY - $startY) * $i / $steps)
        $ok = [Mouse]::SetCursorPos([int]$x, [int]$y)

        if (-not $ok)
        {
            Write-Warning "SetCursorPos failed at step $i → ($x,$y)"
        }
        Start-Sleep -Milliseconds $movementSpeed
    }

    # 確認最終位置
    [Mouse]::SetCursorPos($targetX, $targetY)
    $finalPoint = New-Object Mouse+POINT
    [Mouse]::GetCursorPos([ref]$finalPoint)
    $dx = [Math]::Abs($finalPoint.X - $targetX)
    $dy = [Math]::Abs($finalPoint.Y - $targetY)

    # 如果位置精確，執行點擊
    if ($dx -le 2 -and $dy -le 2)
    {
        Write-Host "Arrived at target ($targetX, $targetY). Clicking..."
        [Mouse]::mouse_event([Mouse]::MOUSEEVENTF_LEFTDOWN, $targetX, $targetY, 0, 0)
        Start-Sleep -Milliseconds 50
        [Mouse]::mouse_event([Mouse]::MOUSEEVENTF_LEFTUP, $targetX, $targetY, 0, 0)
    }
    else
    {
        Write-Warning "Final position inaccurate → ($($finalPoint.X), $($finalPoint.Y))"
    }
}

#主迴圈：根據使用者閒置時間控制滑鼠
while ($true)
{
    $lastInputTime = [InputMonitor]::GetLastInputTime()
    $currentTickCount = [Environment]::TickCount
    $inactivityTime = ($currentTickCount - $lastInputTime) / 1000

    Write-Host "Inactivity: $inactivityTime seconds"

    # 如果閒置超過 300 秒，移動滑鼠
    if ($inactivityTime -ge 300)
    {
        SmoothMoveTo -targetX $currentPos.X -targetY $currentPos.Y
        $currentPos = if ($currentPos -eq $pos1) { $pos2 } else { $pos1 }
    }

    Start-Sleep -Seconds 300
}