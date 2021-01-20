# PowershellCrypter
PowershellCrypter is a tool for bypassing AV and obfuscating scripts and executables by employing AES encryption.
Both encrypterAES.ps1 and decrypterAES.ps1 can be found as one-liner in the project
  - encrypterAES.ps1 must be executed from the Attacker machine,the output file must be uploaded by the Attacker somewhere to be subsequently downloaded from the target with decrypterAES.ps1
  - decrypterAES.ps1 must be executed from the Target machine, the file than will be executed. 

In the example we have used a Powershell script(.ps1) executed by the decrypterAES.ps1 with the expression IEX($backToPlainText).
Anyway with some modification is possible to execute any payload that we want to deliver.
