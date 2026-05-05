# LLM-Hopper skill installer (Claude Code + Codex CLI) — Windows PowerShell.
#
# Usage:
#   .\install.ps1 -Target claude-code -Scope project
#   .\install.ps1 -Target codex
#   .\install.ps1 -Target all -DryRun
#   .\install.ps1 -Target all -Uninstall

[CmdletBinding()]
param(
    [ValidateSet('claude-code','codex','all')]
    [string]$Target = 'all',

    [ValidateSet('project','user')]
    [string]$Scope = 'project',

    [switch]$DryRun,
    [switch]$Uninstall
)

$ErrorActionPreference = 'Stop'

$ScriptDir = Split-Path -Parent $PSCommandPath
$PkgDir    = $ScriptDir
$RepoRoot  = (Resolve-Path (Join-Path $ScriptDir '..\..')).Path

function Copy-One {
    param([string]$Src, [string]$Dst)

    $dstDir = Split-Path -Parent $Dst
    if ($DryRun) {
        Write-Host "[dry-run] mkdir -p $dstDir"
        if ($Uninstall) {
            Write-Host "[dry-run] remove $Dst"
        } else {
            Write-Host "[dry-run] copy $Src -> $Dst"
        }
        return
    }

    if (-not (Test-Path $dstDir)) {
        New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
    }

    if ($Uninstall) {
        if (Test-Path $Dst) {
            Remove-Item $Dst -Force
            Write-Host "- removed $Dst"
        }
    } else {
        Copy-Item -Path $Src -Destination $Dst -Force
        Write-Host "- installed $Dst"
    }
}

function Install-ClaudeCode {
    if ($Scope -eq 'project') {
        $skillRoot    = Join-Path $RepoRoot '.claude\skills\llm-hopper'
        $commandsRoot = Join-Path $RepoRoot '.claude\commands'
    } else {
        $skillRoot    = Join-Path $HOME '.claude\skills\llm-hopper'
        $commandsRoot = Join-Path $HOME '.claude\commands'
    }

    Write-Host ""
    Write-Host "=== Claude Code ($Scope scope) ==="
    Copy-One (Join-Path $PkgDir 'claude-code\SKILL.md') (Join-Path $skillRoot 'SKILL.md')
    Get-ChildItem (Join-Path $PkgDir 'claude-code\commands') -Filter *.md | ForEach-Object {
        Copy-One $_.FullName (Join-Path $commandsRoot $_.Name)
    }
}

function Install-Codex {
    $promptsRoot = Join-Path $HOME '.codex\prompts'
    Write-Host ""
    Write-Host "=== Codex CLI (user scope) ==="
    Get-ChildItem (Join-Path $PkgDir 'codex\prompts') -Filter *.md | ForEach-Object {
        Copy-One $_.FullName (Join-Path $promptsRoot $_.Name)
    }
}

if ($Uninstall) {
    Write-Host "LLM-Hopper skill: UNINSTALL (target=$Target, scope=$Scope)"
} else {
    Write-Host "LLM-Hopper skill: install (target=$Target, scope=$Scope)"
}

switch ($Target) {
    'claude-code' { Install-ClaudeCode }
    'codex'       { Install-Codex }
    'all'         { Install-ClaudeCode; Install-Codex }
}

Write-Host ""
Write-Host "Done."
if (-not $Uninstall) {
    Write-Host "Restart your Claude Code or Codex CLI session in this directory."
    Write-Host "Type /help to confirm /hopper, /use-role, /role-status, /track-cost, /cost-report appear."
}
