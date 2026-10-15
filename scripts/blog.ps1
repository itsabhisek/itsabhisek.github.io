<#
.SYNOPSIS
Build the blog, commit local changes, or push the current branch.
.EXAMPLE
.\scripts\blog.ps1 Build
.EXAMPLE
.\scripts\blog.ps1 Commit -Message "Make the blog more compact"
.EXAMPLE
.\scripts\blog.ps1 Push
.NOTES
Commit stages all non-ignored changes. Push sends existing commits only.
Pushing saves code to GitHub. Deploy separately using Run workflow on GitHub.
Use -WhatIf to preview an action without running it.
#>
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('Build', 'Commit', 'Push')]
    [string]$Action,

    [string]$Message
)

$ErrorActionPreference = 'Stop'

function Invoke-Checked {
    param([string]$Program, [string[]]$Arguments)
    & $Program @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Program failed (exit code $LASTEXITCODE). No further steps were run."
    }
}

$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location -LiteralPath $projectRoot
try {
    switch ($Action) {
        'Build' {
            if ($PSCmdlet.ShouldProcess($projectRoot, 'Run npm run build')) {
                if (-not (Test-Path -LiteralPath 'node_modules')) {
                    Invoke-Checked -Program 'npm.cmd' -Arguments @('ci')
                }
                Invoke-Checked -Program 'npm.cmd' -Arguments @('run', 'build')
                Write-Host 'Build complete. Run npm run preview to view it locally.'
            }
        }
        'Commit' {
            if ([string]::IsNullOrWhiteSpace($Message)) {
                throw 'Supply a commit message: .\scripts\blog.ps1 Commit -Message "Update blog"'
            }
            if ($PSCmdlet.ShouldProcess($projectRoot, "Stage all changes and commit: $Message")) {
                $changes = & git status --porcelain
                if ($LASTEXITCODE -ne 0) { throw 'Could not read Git status.' }
                if (-not $changes) {
                    Write-Host 'Nothing to commit.'
                    break
                }
                Invoke-Checked -Program 'git' -Arguments @('add', '--all')
                Invoke-Checked -Program 'git' -Arguments @('commit', '-m', $Message)
                Write-Host 'Committed locally. Nothing has been pushed.'
            }
        }
        'Push' {
            $branch = & git branch --show-current
            if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($branch)) {
                throw 'Check out a branch before pushing.'
            }
            if ($PSCmdlet.ShouldProcess("origin/$branch", 'Push committed code to GitHub')) {
                Invoke-Checked -Program 'git' -Arguments @('push', '--set-upstream', 'origin', $branch)
                Write-Host "Pushed $branch. To deploy, manually run the Pages workflow on main at https://github.com/itsabhisek/itsabhisek.github.io/actions/workflows/deploy.yml"
            }
        }
    }
}
finally {
    Pop-Location
}
