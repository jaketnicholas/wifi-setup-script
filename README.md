# wifi-setup-script
The UNH Linux Club Automatic Wi-Fi Setup Script... modified by myself in order
to work with the new secure network at UNH, eduroam!

Usage
=====

In order to run this script, you can either:

a) download it locally onto your machine; or

b) bootstrap it

In order for the script to work, you must download the certificates from
wifi.unh.edu (should do over UNH-Open, a phone hotspot or a separate computer
that you can transfer the files from).

Once you log in as a faculty/staff/student, it'll usually bring you to a page
to download a Cloudpath executable for Linux. If this executable says the OS is
"not supported for automatic configuration," well, that's what I wrote this
script because of! Click the "Show all operating systems" link below the 
Cloudpath download prompt, and select "Other Operating Systems." Now download
the certificates from steps 2 and 3 (as .cer and .p12 files respectively, which
should be their default when clicking on the buttons anyways). 

Place both of those certificates in the folder where the unh_wifi.sh shell 
script is located, then run it (NOTE: might need to run the command 
'chmod +x unh_wifi.sh' while in the shell script's directory in order to make
it runnable).

The rest of the setup should be done automatically by the shell script once you
enter your UNH username and password... it worked on my machine at least! 
(I use Linux Mint 19.3 btw)

If the script spits out an error or doesn't work, try downloading the cert from
step 1 of the wifi.unh.edu certificate page instead of 2. I haven't personally
tried that, but who knows, maybe it'll do the trick. Otherwise, feel free to
contact me via email! I'll try to get back to you if I'm not busy with whatever
job stuff I'll have on my plate come next year when I'm graduated.


Fork Author
=======

[Jake](mailto:jaketnicholas@gmail.com)

Original Authors
=======

[Adam](mailto:aleblanc501@outlook.com)  
[Ryan B](mailto:rwb1005@wildcats.unh.edu)  
[Ryan M](mailto:rm1085@wildcats.unh.edu)  
[Jeremy](mailto:jp18@wildcats.unh.edu)  
[Ethan](mailto:es2025@wildcats.unh.edu)  

