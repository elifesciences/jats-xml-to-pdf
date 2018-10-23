#!/bin/bash
set -e
input="$1"
output="$2"
echo "got $input and $output"
#saxonb-xslt -xsl:./JATSPreviewStylesheets-master/shells/saxon/jats-PMCcit-xslfo.xsl -s:"/mnt/$input" -o:"/mnt/$output"
java -jar /usr/share/java/saxon9he.jar -xsl:./JATSPreviewStylesheets-master/shells/saxon/jats-PMCcit-xslfo.xsl -s:"/mnt/$input" -o:"/mnt/$output"
