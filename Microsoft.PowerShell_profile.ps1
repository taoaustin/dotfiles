# Put this is in $PROFILE
# or do like 
# . /custom/path/to/profile/user_profile.ps1, with this stuff in it.

# Prompt
Import-Module posh-git
Import-Module oh-my-posh
oh-my-posh init pwsh --config C:\Users\Austin\AppData\Local\oh-my-posh\themes/clean-detailed.omp.json | Invoke-Expression

# PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Icons
Import-Module -Name Terminal-Icons

function which ($command) {
    (Get-Command $command).Path
}
