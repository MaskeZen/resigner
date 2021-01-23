There are two way of working,  
recursivly, and per-file.  

run <code>./multi.sh yourpath</code>,  
to recursive look for zip, jar, apk files inside <code>yourpath</code>.  

or run <code>./resign.sh yourfile</code>,  
to just do it for one file.  

<hr/>

<code>multi.sh</code> uses <code>find</code> and <code>parallel</code>,  
to run multiple executions of <code>resign.sh</code> in parallel,  
by default one for each CPU core available.  

each file will be backed-up to <code>&lowbar;original&lowbar;</code> prefix and its name.  

Note that for security reasons I do not provide a script to delete <code>&lowbar;original&ast;</code> files. 
but you can do it manually with:  
<code>##find "yourpath" -type f \( -name "&lowbar;original&lowbar;&ast;" \) -delete</code>.  

<hr/>

you will need 7zip, jdk, and gnu parallel,  
for some reason zipalign is not shipped with open-java so you need to install it as well.  
<code>sudo apt-get -y install p7zip openjdk-8-jdk parallel zipalign</code>.  
you also need to make sure java is well defined,  
here is an example of <code>/etc/environment</code>

<pre>
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin"

JAVA&lowbar;HOME="/usr/lib/jvm/java-8-openjdk-amd64"

JRE&lowbar;HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre"

JAVA&lowbar;TOOL&lowbar;OPTIONS="-Dfile.encoding=UTF8 -Duser.language=en"
</pre>

make sure to add the path to your jdk's <code>bin/</code>-folder at the end of <code>PATH</code>,  
you can use <code>locate jarsigner</code> to find out where it is install,  
for example in my case I've added <code>:/usr/lib/jvm/java-8-openjdk-amd64/bin</code> at the end of <code>PATH</code>,  
define <code>JAVA&lowbar;HOME</code> with just the jdk folder (without the <code>bin/</code>), <code>JRE&lowbar;HOME</code> (optional) with the jre folder it is usually a sub-folder of the jdk folder, and <code>JAVA&lowbar;TOOL&lowbar;OPTIONS</code> (optional) for extra arguments passed for each java program (useful).  

to edit your <code>/etc/environment</code> use your favorite text-editor in with superuser permissions for example <code>sudo gedit /etc/environment</code> (<code>sudo apt-get -y install gedit</code>).  

<hr/>

<del>known issues: for some reason the <code>-prune -name "&lowbar;original&lowbar;&ast;"</code> switch used in <code>find</code> does not work, so if you've ran the process again, the <code>&lowbar;original&lowbar;&ast;</code> files will be discovered and worked on as well, it means you can end up with a lot of files (<code>&lowbar;original&lowbar;&lowbar;original&lowbar;&ast;</code>), but you can still <code>find . -type f \( -name "&lowbar;original&lowbar;&ast;" \) -delete</code> somewhere in your path to remove all of those...</del>  

edit: I've re-edited the 'find' command, and it seems to work now, instead of -prune which seems to just apply for folders and their content, using <code>!</code> inside a new "matching group" seems to do it.  
