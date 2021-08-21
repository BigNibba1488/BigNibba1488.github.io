





$name = "cirno"


cd "E:\hell moe\images\$name"

$files = Get-ChildItem  -Filter *.png -file -Recurse | 
foreach-object {

    $Source = $_.FullName
    $test = [System.IO.Path]::GetDirectoryName($source)
    $base= $_.BaseName+".jpg"
    $basedir = $test+"\"+$base
    Write-Host $basedir
    Add-Type -AssemblyName system.drawing
    $imageFormat = "System.Drawing.Imaging.ImageFormat" -as [type]
    $image = [drawing.image]::FromFile($Source)
    # $image.Save($basedir, $imageFormat::jpeg) Don't save here!

    # Create a new image
    if($image.Height -gt 250){
        $factor = $image.Height / 250
    }else{
        $factor = 1
    }

    $NewImage = [System.Drawing.Bitmap]::new([int]($image.Width/$factor),[int]($image.Height/$factor))
    $NewImage.SetResolution(($image.HorizontalResolution/$factor),($image.VerticalResolution/$factor))

    # Add graphics based on the new image
    $Graphics = [System.Drawing.Graphics]::FromImage($NewImage)
    $Graphics.Clear([System.Drawing.Color]::White) # Set the color to white
    $Graphics.DrawImageUnscaled($image,0,0) # Add the contents of $image

    # Now save the $NewImage instead of $image
    $NewImage.Save($basedir,$imageFormat::Jpeg)

}  


exit


$name = "senko"


cd "E:\hell moe\images\$name"
$items = gci .

$i = 0
foreach($item in $items){
    Rename-Item $item -NewName "$($name)$i.jpg" 
    $i++
    #break
}


exit