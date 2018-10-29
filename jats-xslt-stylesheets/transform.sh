#!/bin/bash
set -e
input="$1"
output="$2"
# uses packaged saxon, v 9.1
#saxonb-xslt -xsl:./JATSPreviewStylesheets-master/shells/saxon/jats-PMCcit-xslfo.xsl -s:"/mnt/$input" -o:"/mnt/$output"

# uses latest stable saxon, v9.8
# doesn't work, requires Saxon-PE+
#java -jar /usr/share/java/saxon9he.jar -xsl:./JATSPreviewStylesheets-master/shells/saxon/jats-PMCcit-xslfo.xsl -s:"/mnt/$input" -o:"/mnt/$output"

# jats dtd spec required in same dir as article files to generate fo file
cp -R ./dtd/* /mnt/

# generate the .fo file with saxon + jats stylesheet
fofile="/mnt/out.fo"
java -jar /usr/share/java/saxon9he.jar -xsl:./JATSPreviewStylesheets-master/xslt/main/jats-xslfo.xsl -s:"/mnt/$input" -o:out.fo
xmllint out.fo --format > "$fofile" # not really necessary, the fo file is unreadable

# use Apache-FOP to generate pdf file
./fop-2.3/fop/fop -fo "$fofile" -pdf "/mnt/$output"
