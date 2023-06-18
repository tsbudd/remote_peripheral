Write-Host "Generating dart files from protos"

# Define variables relative to project src directory here
$user = (whoami).split("\")[1]
$projName = "flutter_template"
$projectRoot = "C:/Users/$user/Documents/Github/$projName"
$protoSrc = "proto"
$dartDir = "/lib/generated/proto"

# And here's where the magic happens
Set-Location $projectRoot
# $changed = git diff --name-only --diff-filter=AM
$changed = get-ChildItem $protoSrc -recurse | Select-Object -ExpandProperty Name
if($null -ne $changed) {
    $changedArray = $changed.Split(“`n”)

    foreach ($file in $changedArray) {
        if ($file.EndsWith(".proto")) {
            Write-Host "compiling: $file"
            $fileNameOnly = Split-Path $file -leaf
            Start-Process protoc.exe -ArgumentList "-I=`"$projectRoot/$protoSrc`"","--dart_out=`"$projectRoot$dartDir`"","$fileNameOnly" -NoNewWindow
        }
    }
}
Write-Host "Finished generating dart classes"
exit
#EOF