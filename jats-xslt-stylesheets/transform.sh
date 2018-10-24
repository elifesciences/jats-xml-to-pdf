#!/bin/bash
set -e
input="$1"
output="$2"
echo "got $input and $output"
# uses packaged saxon, v 9.1
#saxonb-xslt -xsl:./JATSPreviewStylesheets-master/shells/saxon/jats-PMCcit-xslfo.xsl -s:"/mnt/$input" -o:"/mnt/$output"

# uses latest stable saxon, v9.8
# doesn't work, requires Saxon-PE+
#java -jar /usr/share/java/saxon9he.jar -xsl:./JATSPreviewStylesheets-master/shells/saxon/jats-PMCcit-xslfo.xsl -s:"/mnt/$input" -o:"/mnt/$output"

# generate the .fo file with saxon + jats stylesheet
java -jar /usr/share/java/saxon9he.jar -xsl:./JATSPreviewStylesheets-master/xslt/main/jats-xslfo.xsl -s:"/mnt/$input" -o:"out.fo"
# use Apache-FOP to generate pdf file
./fop-2.3/fop/fop -fo out.fo -pdf "/mnt/$output"
