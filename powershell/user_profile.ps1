# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Import-Module posh-git
# oh-my-posh --init --shell pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/montys.omp.json | Invoke-Expression
# oh-my-posh --init --shell pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/tokyo.omp.json | Invoke-Expression
# oh-my-posh --init --shell pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/tokyo.omp.json | Invoke-Expression


# Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
# Get-PSReadLineKeyHandler
# Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function Complete

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineOption -PredictionViewStyle ListView

# Env
# $env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"


# Eza
Function eza-lta {
    eza -lTag --header --hyperlink --git --icons
}
Function eza-l2 {
    eza -lTL2 --header --hyperlink --git --icons
}
Function eza-lt {
    eza --icons --header --hyperlink --git -lTL
}

# Alias
Set-Alias -Name vi -Value nvim
Set-Alias -Name nvi -Value neovide
Set-Alias lta eza-lta
Set-Alias l2 eza-l2
Set-Alias lt eza-lt
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}
