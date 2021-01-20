# PowershellCrypter
PowershellCrypter is a tool for bypassing AV by obfuscating scripts with the use of AES encryption.
Both encrypterAES.ps1 and decrypterAES.ps1 can be found as one-liner in the project
  - encrypterAES.ps1 must be executed from the Attacker machine,the output file must be uploaded by the Attacker somewhere to be subsequently downloaded from the target with decrypterAES.ps1
  - decrypterAES.ps1 must be executed from the Target machine

# Note
In the example we have used a Powershell script(.ps1) encrypted by encrypterAES.ps1 and executed by decrypterAES.ps1 with the expression IEX($backToPlainText). Anyway with some modification is possible to execute any payload that we want to deliver.
