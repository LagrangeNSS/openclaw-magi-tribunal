param(
  [string]$OpenClawHome = (Join-Path $HOME ".openclaw"),
  [string]$HostWorkspace = (Join-Path (Join-Path $HOME ".openclaw") "workspace"),
  [switch]$InstallHostSkill,
  [switch]$NoBackup
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $PSScriptRoot
$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$BackupRoot = Join-Path $OpenClawHome "backups\magi-tribunal-$Timestamp"

function Copy-OverlayWithBackup {
  param(
    [Parameter(Mandatory = $true)][string]$Source,
    [Parameter(Mandatory = $true)][string]$Destination,
    [Parameter(Mandatory = $true)][string]$Label
  )

  if (-not (Test-Path -LiteralPath $Source)) {
    throw "Missing source: $Source"
  }

  if ((Test-Path -LiteralPath $Destination) -and -not $NoBackup) {
    New-Item -ItemType Directory -Force -Path $BackupRoot | Out-Null
    $BackupPath = Join-Path $BackupRoot $Label
    Copy-Item -LiteralPath $Destination -Destination $BackupPath -Recurse -Force
  }

  New-Item -ItemType Directory -Force -Path $Destination | Out-Null
  Get-ChildItem -LiteralPath $Source -Force | Copy-Item -Destination $Destination -Recurse -Force
}

$WorkspaceNames = @(
  "workspace-magi",
  "workspace-magi-melchior",
  "workspace-magi-balthasar",
  "workspace-magi-casper"
)

foreach ($Name in $WorkspaceNames) {
  $Source = Join-Path $RepoRoot $Name
  $Destination = Join-Path $OpenClawHome $Name
  Copy-OverlayWithBackup -Source $Source -Destination $Destination -Label $Name
  Write-Host "Installed $Name -> $Destination"
}

$ConfigPath = Join-Path $OpenClawHome "openclaw.json"
if ((Test-Path -LiteralPath $ConfigPath) -and -not $NoBackup) {
  New-Item -ItemType Directory -Force -Path $BackupRoot | Out-Null
  Copy-Item -LiteralPath $ConfigPath -Destination (Join-Path $BackupRoot "openclaw.json") -Force
  Write-Host "Backed up config -> $BackupRoot"
}

if ($InstallHostSkill) {
  $HostSkillSource = Join-Path $RepoRoot "host-integration\skills\magi-tribunal"
  $HostSkillDestination = Join-Path $HostWorkspace "skills\magi-tribunal"
  Copy-OverlayWithBackup -Source $HostSkillSource -Destination $HostSkillDestination -Label "host-skill-magi-tribunal"
  Write-Host "Installed host skill -> $HostSkillDestination"
  Write-Host "Add host-integration/AGENTS.snippet.md to the host AGENTS.md routing rules."
}

Write-Host ""
Write-Host "Next step: merge openclaw.magi.example.json5 into $ConfigPath."
Write-Host "Keep the explicit workspace fields and magi.subagents.allowAgents."
