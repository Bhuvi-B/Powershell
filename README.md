# PowerShell File Organizer

A simple PowerShell script that automatically sorts files in a target folder into categorized subfolders based on their file type — Audio, Video, Documents, Images, Applications, and Others.

## Features

- Scans a target directory and organizes files by extension
- Automatically creates category subfolders if they don't already exist
- Moves unrecognized file types into an `Others` folder
- Prints a log line to the console for every file moved

## Categories

| Category     | Extensions                                                  |
|--------------|--------------------------------------------------------------|
| Audio        | `.mp3` `.wav` `.flac` `.aac` `.ogg` `.m4a`                    |
| Video        | `.mp4` `.mkv` `.avi` `.mov` `.wmv` `.flv`                     |
| Documents    | `.pdf` `.docx` `.doc` `.txt` `.pptx` `.xlsx` `.csv` `.rtf`    |
| Images       | `.jpg` `.jpeg` `.png` `.gif` `.bmp` `.tiff` `.svg`            |
| Applications | `.exe` `.msi` `.bat` `.cmd`                                  |
| Others       | Any file type not listed above                                |

## Requirements

- Windows PowerShell 5.1 or PowerShell 7+
- Read/write permissions on the target directory

## Setup

1. Clone or download this repository.
2. Open `File_Organization_Script.ps1` in a text editor.
3. Update the `$BasePath` variable to point to the folder you want organized:

   ```powershell
   $BasePath = "D:\Misc\Downloads"
   ```

## Usage

Run the script from a PowerShell terminal:

```powershell
.\File_Organization_Script.ps1
```

If script execution is disabled on your system, you may need to allow it for the current session:

```powershell
powershell -ExecutionPolicy Bypass -File .\File_Organization_Script.ps1
```

Or update your execution policy permanently (run as Administrator):

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## How It Works

1. Defines a hashtable of categories mapped to their associated file extensions.
2. Creates a subfolder for each category (plus `Others`) inside `$BasePath` if it doesn't already exist.
3. Iterates over every file in `$BasePath` (non-recursive — subfolders are not scanned).
4. Matches each file's extension against the category list and moves it into the corresponding subfolder.
5. Any file whose extension doesn't match a known category is moved to `Others`.
6. Logs each move to the console, then prints a completion message.

## Notes & Limitations

- The script only scans the top level of `$BasePath` — it does not recurse into subdirectories.
- If a file with the same name already exists in the destination folder, `Move-Item` will throw an error. Consider adding a `-Force` flag or duplicate-handling logic if this is a concern for your use case.
- Extension matching is case-insensitive.
- Customize the `$Categories` hashtable to add, remove, or rename categories and extensions as needed.
