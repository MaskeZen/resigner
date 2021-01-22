requires having 7z and jdk installed.  
<code>apt-get -y install p7zip openjdk-8-jdk</code>.  

you run <code>./resign.sh yourfile</code>  
the existing signature will be removed and a new one will be created.  

you can use <code>./resign.sh</code> with apk files, jar files and any zip compatible file.  

the existing file will be backed-up to <code>original_yourfile</code> before the changes,  
so you can alway revert to the file before changes were applied.  

<hr/>

<h3>How It Works?</h3>

<code>./resign.sh yourfile</code> will first run <code>./clear_signature.sh yourfile</code>, 
which will unzip the file into a folder, in the name of the file (without the extension),  
it will generate a <code>META-INF</code> folder if any does not exist yet,  
enter the <code>META-INF</code> folder and delete all of the *.RSA and *.SF files.  

it will then edit the <code>MANIFEST.MF</code> clearing all the lines that describes a checksum of the current files, it leaves-intact the lines that describes other stuff (such as main-module for Java).  

it then rename the original file <code>yourfile</code> into <code>original_yourfile</code>,  
zip all the files using 7zip (classic compatible zip format: ZipCrypto Deflate),  
and rename the archive same in the same name and extension of <code>yourfile</code>,  
and move it to the same folder as <code>yourfile</code> is.  

<code>resign.sh</code> will continue with one-time generation of a keystore with a self-signed certificate, it will create a very backward-compatible certificate - SHA1 2048bit,  
it will not use a time server, but the certificate will be valid for 10000 days.  
the warning regarding self-signed certificate or not using time server can be safely ignored.

next, <code>./sign.sh yourfile</code> will sign <code>yourfile</code> using the keystore and jarsigner,  

next <code>align.sh yourfile</code> will 4byte align the file using zipalign,  
this creates a temp. file named <code>yourfile_aligned</code>, but then it deletes <code>yourfile</code>, and renames <code>yourfile_aligned</code> to <code>yourfile</code>.  

note: using jarsigner requires to first sign and then align (this is different then apksigner, which requires you to first align the file and then sign it). aligning and then signing with jarsigner will break the 4byte aligning.

finally <code>./verify.sh yourfile</code> verify that the signature is ok.

<code>clear_signature.sh</code>, <code>generate_keystore.sh</code>, <code>sign.sh</code>, <code>align.sh</code>, and <code>verify.sh</code> are internally used by <code>resign.sh</code>.  
