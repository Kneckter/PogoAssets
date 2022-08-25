#!/bin/bash

#mkdir icons/moved

#for num in {1..28}; do
#    cp icons/pokemon_icon_201_$num.png uicons/201-f$num.png
#    mv icons/pokemon_icon_201_$num.png icons/moved/
#done

#cp icons/pokemon_icon_000_00.png uicons/0.png
#mv icons/pokemon_icon_000_00.png icons/moved/
#mv icons/pokemon_icon_000.png icons/moved/

#for num in {1..3}; do
#    cp icons/pokemon_icon_025_598_$num.png uicons/25-f598-c$num.png
#    mv icons/pokemon_icon_025_598_$num.png icons/moved/
#done

#mv icons/pokemon_icon*shiny* icons/moved/
#mv icons/pokemon_icon*undefined* icons/moved/

for ICON in $(ls icons/*.png); do
    NAME=""
    n=""
    evo=""
    cost=""
    zeros=""
    id=""
    rest=""
    form=""
    ec=""

    n="${ICON:19}"
    n="${n:0:-4}"
    zeros="${n:0:2}"
    if [ "$zeros" == '00' ]
    then
        n="${n:2}"
    fi
    zeros="${n:0:1}"
    if [ "$zeros" == '0' ]
    then
        n="${n:1}"
    fi
    #echo $n
    id="${n%_*}"
    id="${id%_*}"
    rest="${n#*_}"
    if [[ $rest =~ _ ]]; then
        form="${rest%_*}"
        ec="${rest#*_}"
        zeros="${ec:0:1}"
        if [ "$zeros" == '0' ]
        then
            ec="${ec:1}"
        fi
    else
        form=$rest
        ec=""
    fi
    
    if [ "$form" == '00' ]
    then
        form=""
    fi
    
    #echo "$id | $form | $ec | $rest"
    if [ "$ec" == '1' ] || [ "$ec" == '2' ] || [ "$ec" == '3' ]
    then
        evo=$ec
    else
        cost=$ec
    fi
    
    #put it together
    NAME=$id
    if [ "$evo" != '' ]
    then
        NAME=$NAME\_e$evo
    fi
    if [ "$form" != '' ]
    then
        NAME=$NAME\_f$form
    fi
    if [ "$cost" != '' ]
    then
        NAME=$NAME\_c$cost
    fi
    echo cp $ICON uicons/$NAME.png
    cp $ICON uicons/$NAME.png
done

#mv icons/moved/* icons/moved
#rm -rf icons/moved/
