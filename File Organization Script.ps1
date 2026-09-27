# ============================================
# PowerShell File Organizer Script
# ============================================
# Description:
# Automatically sorts files in a folder into categorized subfolders
# by file type (Audio, Video, Documents, Images, Applications, Others).
# ============================================

# Set the target directory (modify as needed)
$BasePath = "D:\Misc\Downloads"

# Define file type categories
$Categories = @{
    "Audio"        = @(".mp3", ".wav", ".flac", ".aac", ".ogg", ".m4a")
    "Video"        = @(".mp4", ".mkv", ".avi", ".mov", ".wmv", ".flv")
    "Documents"    = @(".pdf", ".docx", ".doc", ".txt", ".pptx", ".xlsx", ".csv", ".rtf")
    "Images"       = @(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff", ".svg")
    "Applications" = @(".exe", ".msi", ".bat", ".cmd")
}

# Create subfolders if they don’t exist
foreach ($Category in $Categories.Keys + "Others") {
    $FolderPath = Join-Path $BasePath $Category
    if (-not (Test-Path $FolderPath)) {
        New-Item -Path $FolderPath -ItemType Directory | Out-Null
    }
}

# Organize files
Get-ChildItem -Path $BasePath -File | ForEach-Object {
    $FileMoved = $false

    foreach ($Category in $Categories.Keys) {
        if ($Categories[$Category] -contains $_.Extension.ToLower()) {
            Move-Item -Path $_.FullName -Destination (Join-Path $BasePath $Category)
            Write-Host "Moved $($_.Name) → $Category"
            $FileMoved = $true
            break
        }
    }

    # Move unclassified files to "Others"
    if (-not $FileMoved) {
        Move-Item -Path $_.FullName -Destination (Join-Path $BasePath "Others")
        Write-Host "Moved $($_.Name) → Others"
    }
}

Write-Host "File organization completed."
