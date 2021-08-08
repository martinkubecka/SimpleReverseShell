# Simple Reverse Shell Generator

## :shell: Basic Information

The goal of this script is to easily generate reverse shell payloads with additional options to start a listener and help with the shell stabilization.

>  A reverse shell is a type of shell session which is initiated from a remote machine. It means that the target is forced to execute code that connects back to our computer. On our own machine, we would set up a listener which would be used to receive the connection. 

<p align="center">
<img src="https://github.com/martinkubecka/Reverse-Shell-Generator/blob/main/images/rev-shell-infographic.png" alt="TCP reverse shell">
</p>

---
## :building_construction: Instalation

```
$ git clone https://github.com/martinkubecka/Reverse-Shell-Generator.git
$ cd Reverse-Shell-Generator/
$ chmod +x rev_shell_gen.sh
```

---
## :joystick: Usage 

```
Usage: rev_shell_gen.sh [-h|l|u] -i <LHOST> -p <LPORT> -t <PAYLOAD>

Simple Reverse Shell Generator

Available options:

  -h	Print this help and exit
  -i	The target address
  -p	The target port
  -t	The payload type : bash, python, java, php, perl, ruby, go
  -l	Start a netcat listener
  -u	List commands for a shell upgrade

Examples:

  rev_shell_gen.sh -i 10.0.0.1 -p 4242 -t python
  rev_shell_gen.sh -i 10.0.0.1 -p 4242 -t bash -l -u

```
### Examples

-  Generate bash reverse shell code.

<p align="center">
<img src="https://github.com/martinkubecka/Reverse-Shell-Generator/blob/main/images/example-bash.png" alt="Bash reverse shell">
</p>

- Generate python reverse shell code, start a listener on our machine and display shell stabilization helper.

<p align="center">
<img src="https://github.com/martinkubecka/Reverse-Shell-Generator/blob/main/images/example-all-flags.png" alt="All flags">
</p>

---
## :handshake: Acknowledgements

- [Payloads All The Things](https://github.com/swisskyrepo/PayloadsAllTheThings)
