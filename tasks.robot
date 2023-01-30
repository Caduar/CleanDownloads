*** Settings ***
Documentation       Template robot main suite.
Library    RPA.Desktop.OperatingSystem
Library    RPA.FileSystem
Library    String
Library    Collections

*** Variables ***
${DownloadsFolder_MAC}=           /Users/camiloandresduarterincon/Downloads
${DownloadsImages}=    ${DownloadsFolder_MAC}${/}Imagenes
${DownloadsPDFs}=    ${DownloadsFolder_MAC}${/}Documentos PDF
${DownloadsExceles}=    ${DownloadsFolder_MAC}${/}Documentos Excel
${DownloadsDocumentos}=    ${DownloadsFolder_MAC}${/}Documentos Word
${DownloadsMACPrograms}=    ${DownloadsFolder_MAC}${/}Programas Mac
${DownloadsWindowsPrograms}=    ${DownloadsFolder_MAC}${/}Programas Windows
${DownloadsVideos}=    ${DownloadsFolder_MAC}${/}Videos
${DownloadsOtros}=    ${DownloadsFolder_MAC}${/}Otros
*** Keywords ***
Capturar Usuario
    ${username}    Get Username
	${dir_exists_MAC}=    Does Directory Exist    ${DownloadsFolder_MAC}
    @{Imagenes}=    Create List    .psd    .png    .jpg    .jpeg    .heic
	@{PDFs}=    Create List    .pdf
	@{Excel}=    Create List    .xls    .xlsx    .xlsm
	@{Documentos}=    Create List    .doc    .docx    .odt    .txt    .pages
	@{MACPrograms}=    Create List    .dmg
	@{WindowsPrograms}=    Create List    .msi    .exe
	@{videos}=    Create List    .mp4    .mpg    .flv    .mov    .avi    .wmv    .flv
	@{otros}=    Create List    .zip    .7z    .rar    .iso    .avi    .lic
	IF    ${dir_exists_MAC}
	    ${files}=    List Files In Directory    ${DownloadsFolder_MAC}	
	    FOR    ${file}    IN    @{files}
		    ${extension}=    Get File Extension    ${file}
			${extension}=    Convert To Lower Case    ${extension}
			${name}=    Get File Name    ${file}
			IF  "${extension}"!="${EMPTY}"
				${Is_Image}=    Run Keyword If    '${extension}' in '''@{Imagenes}'''    Move File    ${file}    ${DownloadsImages}${/}${name}    overwrite=True
				${Is_PDF}=    Run Keyword If    '${extension}' in '''@{PDFs}'''    Move File    ${file}    ${DownloadsPDFs}${/}${name}    overwrite=True
				${Is_Excel}=    Run Keyword If    '${extension}' in '''@{Excel}'''    Move File    ${file}    ${DownloadsExceles}${/}${name}    overwrite=True
				${Is_Documento}=    Run Keyword If    '${extension}' in '''@{Documentos}'''    Move File    ${file}    ${DownloadsDocumentos}${/}${name}    overwrite=True
				${Is_MACProgram}=    Run Keyword If    '${extension}' in '''@{MACPrograms}'''    Move File    ${file}    ${DownloadsMACPrograms}${/}${name}    overwrite=True
				${Is_WindowProgram}=    Run Keyword If    '${extension}' in '''@{WindowsPrograms}'''    Move File    ${file}    ${DownloadsWindowsPrograms}${/}${name}    overwrite=True
				${Is_video}=    Run Keyword If    '${extension}' in '''@{videos}'''    Move File    ${file}    ${DownloadsVideos}${/}${name}    overwrite=True
				${Is_Otros}=    Run Keyword If    '${extension}' in '''@{otros}'''    Move File    ${file}    ${DownloadsOtros}${/}${name}    overwrite=True
			    Log    ${file}
			END
			
		END
	END
    

*** Tasks ***
Limpiar Carpeta
    Capturar Usuario
Minimal task
    Log    Done.
