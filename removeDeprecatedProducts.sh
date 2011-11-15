#!/bin/bash
# To use this script, simple type ./removeDeprecatedProducts BRANCH_NAME to remove
# all deprecated products from the specified branch.

# Sanity Check.  Makes sure a branch is specified.
if [ -z $1 ]
then
        echo "Please specify a branch"
        exit 1
fi

# Iterates through the output that shows deprecated items in a given branch.
i=0
for item in $(./repoutil --list-branch=${1} | grep Deprecated | cut -f1 -d ' ')
do
        deprecatedProducts[$i]=$item
        let i++
done

# Removes deprecated products
for product in "${deprecatedProducts[@]}"
do
        ./repoutil --remove-product=$product $1
        echo "Removed ${product}"
done
