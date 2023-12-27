#!/usr/bin/env bash

# to list all currently registered UTIs run the following
    # /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -dump | awk '/claimed UTIs:/ {sub(/^claimed UTIs: */, "");gsub(/, /, "\n"); print}' | sort | uniq
    # OR           (not sure the difference)
    # /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -dump | grep 'uti:' | awk '{ print $2 }' | sort | uniq

# all application identifiers
    # /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -dump | ruby -e 'x={}; while line = gets do if line.start_with? "---" then printf("%-50s%s\n",x["name"],x["identifier"]) if x["name"]; x = {}; next end; key,value = line.chomp.split(":",2);x[key] = value end' | sort | less

# require duti to be installed
if ! [ -x "$(command -v duti)" ]; then
   >&2 echo 'Error: duti is not installed.'
  exit 1
fi

# duti -s bundle_id { uti | url_scheme | extension | MIME_type } [ role ]
# Roles:
#      all                application handles all roles for the given UTI.
#      viewer             application handles reading and displaying documents with the given UTI.
#      editor             application can manipulate and save the item. Implies viewer.
#      shell              application can execute the item.
#      none               application cannot open the item, but provides an icon for the given UTI.

# open all files with the markdown UTI with Typora
duti -s abnerworks.Typora net.daringfireball.markdown editor

# open all files with the markdown extension with Typora
duti -s abnerworks.Typora md editor