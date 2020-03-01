#/bin/sh

jazzy \
    --min-acl internal \
    --no-hide-documentation-coverage \
    --theme apple \    
	--output ./docs \
    --documentation='./*.md'
