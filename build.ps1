<#
  This script creates the wix merge module for gpii-wix-installer.
#>

Push-Location (Split-Path -parent $PSCommandPath)

function Clean {
    rm -r temp, output, build
}

Clean

Write-Output "Prepare build folder"
mkdir build

## documorph folder content
cp -r documorph-widget\* build\

Write-Output "Generate fragment (.wxs file) with build folder"
mkdir temp
heat dir build -dr DocuMorphDirectory -ke -srd -cg DocuMorphDirectory -gg -var var.buildFolder -out temp\DocuMorphDirectory.wxs

Write-Output "Generating .wixobj files"
candle documorph.wxs temp\DocuMorphDirectory.wxs -dbuildFolder=build -out temp\

Write-Output "Building merge module"
mkdir output
light temp\documorph.wixobj temp\DocuMorphDirectory.wixobj  -sacl -o output/documorph.msm

Pop-Location
