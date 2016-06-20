#!/bin/bash
tmp=`mktemp`
cat ${1}.h | egrep ^\#\|^\/\/ | grep -v endif > ${tmp}
echo "class "${2}"{" >> ${tmp}
#echo "public:" >> ${tmp}
cat ${1}.cpp | egrep ^[a-z]+ | sed -e "s|) {|);|g" -e 's|.+\:\:||g' -e 's|^void|\ \ \ \ void|g' -e 's|^boolean|\ \ \ \ boolean|g' -e 's|^uint|\ \ \ \ uint|g' -e 's|^float|\ \ \ \ float|g' -e 's|^static|\ \ \ \ static|g' >> ${tmp}
echo "};" >> ${tmp}
cat ${1}.h | grep endif >> ${tmp}
mv ${1}.h ${1}.h.bak
cp ${1}.cpp ${1}.cpp.bak
cat ${tmp} > ${1}.h
rm ${tmp}