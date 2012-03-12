Based on the excellent [Oh My Zsh](http://github.com/robbyrussel/oh-my-zsh), this repository is designed to provide some out-of-the box enhancements to running PowerShell.

Powershell *very* powerful for interacting with Windows devices.

_Goo Goo Ka Choob_. - Dylan

##Boot Strapping PowerShell
Yes, getting started with PowerShel can be a real problem.

First off, the default path apparently does not include PowerShell.
This can, of course, be an issue trying to run PowerShell scripts which are
terminated using the extension **.PS1**.

The [Wolf](http://blog.wolfplusplus.com/?p=251), provides a little help in his
blogpost about how to use a CMD file to bootstrap powershell.

There are four instances of PowerShell on my 64-bit Windows 7 installation.
1. C:\Windows\System32\WindowsPowerShell\v1.0
2. C:\Windows\SysWOW64\WindowsPowerShell\v1.0
3. C:\Windows\Winsxs\AMD64...
4. C:\Windows\Winsxs\wow64...

I use the one in SysWOW64. And in spite of the version numbers in the path, they
are both version 2.

* Check if _powershell.exe_ is in the path.
* Check if the found _powershell.exe_ is v2 or later
* Update the path to include the appropriate _powershell.exe_ executable
* Check _ExecutionPolicy_ and if it is defaulted to _Restricted_ set it to _RemoteSigned_

## Engage a new Profile