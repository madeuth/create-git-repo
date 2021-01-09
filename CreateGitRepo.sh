#!/bin/sh

#-----------------------------------Globals------------------------------------#
REPO=
NAME=
EMAIL=
HOST=
URL=

#----------------------------------Functions-----------------------------------#
display_command_error() {
    echo "Unknown parameter, please choose a correct option."
}

display_empty_error() {
    echo "Parameter cannot be empty!."
}

#-----------------------------------Program------------------------------------#

# Greetings
echo "Welcome!"

# Get repo name
while : ;
do
    echo -n "What should be the name of the repository? "
    read REPO
    if [ -z $REPO ]
    then
        display_empty_error
    else
        break
    fi
done

# Create local repo
mkdir $REPO
cd $REPO
echo "# $REPO" >> README.md
git init
git add README.md

# Get user name
while : ;
do
    echo -n "What is your git username? "
    read NAME
    if [ -z $NAME ]
    then
        display_empty_error
    else
        break
    fi
done

# Get user email
while : ;
do
    echo -n "What is your git email? "
    read EMAIL
    if [ -z $EMAIL ]
    then
        display_empty_error
    else
        break
    fi
done

# Save credentials
git config --local user.name $NAME
git config --local user.email $EMAIL

# Commit
git commit -m "first commit"
git branch -M main

# Get host
while : ;
do
    echo "What is your git host provider?"
    echo "1) GitHub 2) GiLab"
    read choice
    case $choice in
        1)
            HOST="github.com"
            break
            ;;
        2)
            HOST="gitlab.com"
            break
            ;;
        *)
            display_command_error
            ;;
    esac
done

# Build remote
while : ;
do
    echo "What mode would you like to use to push to remote?"
    echo "1) HTTPS 2) SSH"
    read choice
    case $choice in
        1)
            URL="https://$HOST/$NAME/$REPO.git"
            break
            ;;
        2)
            URL="git@$HOST:$NAME/$REPO.git"
            break
            ;;
        *)
            display_command_error
            ;;
    esac
done

# Add remote
git remote add origin $URL

# Push
git push -u origin main
echo "Successfully pushed to git repo!"

# Greetings
echo "Goodbye!"

exit
#-------------------------------------EOF--------------------------------------#