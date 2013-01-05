if did_filetype()       " filetype already set..
    finish              " ..don't do these checks
endif

if getline(1) =~ '^#!.*\<example\>'
    setfiletype mine
elseif getline(1) =~ '^#!.*\<george\>'
    setfiletype george
endif
