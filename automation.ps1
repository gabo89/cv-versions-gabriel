$documents_path = Split-Path -parent $MyInvocation.MyCommand.Definition
echo "Path is: $documents_path"

$word_app = New-Object -ComObject Word.Application

# This filter will find .doc as well as .docx documents
Get-ChildItem -Path $documents_path -Filter *.doc? | ForEach-Object {

    $document = $word_app.Documents.Open($_.FullName)

    $pdf_filename = "$($_.DirectoryName)\$($_.BaseName).pdf"

    echo "saved file is: $pdf_filename"

    $document.SaveAs([ref] $pdf_filename, [ref] 17)

    $document.Close()
}

$word_app.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($word_app)
Remove-Variable word_app
