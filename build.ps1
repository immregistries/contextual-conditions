$ErrorActionPreference = 'Stop'

if (-not (Test-Path .\process\templates\word\aira-reference-document.docx)) {
    throw "Shared templates are missing. Run: git submodule update --init"
}

$python = Get-Command python -ErrorAction Stop
& $python.Source .\process\tools\build_core_markdown.py --assembly ContextualConditions.qmd
if ($LASTEXITCODE -ne 0) {
    throw "Core Markdown generation failed with exit code $LASTEXITCODE."
}

$quarto = Get-Command quarto -ErrorAction Stop
& $quarto.Source render

if ($LASTEXITCODE -ne 0) {
    throw "Quarto build failed with exit code $LASTEXITCODE."
}

& $python.Source .\process\tools\apply_word_table_style.py .\output\ContextualConditions.docx
if ($LASTEXITCODE -ne 0) {
    throw "Applying the Word table style failed with exit code $LASTEXITCODE."
}

Write-Host "Built core document in output/."
