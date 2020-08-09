
#!/bin/bash 

export ENV LANG='en_US.UTF-8' 
export LANGUAGE='en_US:en' 
export LC_ALL='en_US.UTF-8'

FILES=*.json
for f in $FILES
do
  # extension="${f##*.}"
  # optional .extenstion reformat
  # filename="${f%.*}"
  echo "Generating $f UML Diagram... \n"
  `json-to-plantuml -f $f.json  | java -jar ./bin/plantuml.jar -DPLANTUML_LIMIT_SIZE=45093 -Xmx1024m -v -pipe > $f.png`
done

sleep 1

exit 0
