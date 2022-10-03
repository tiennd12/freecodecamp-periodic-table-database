# !/bin/bash

# regex
NUM_CHECK='^[0-9]+$'
SYMBOL_CHECK='^[A-Za-z]{1,2}$'
STRING_CHECK='[A-Z]|[a-z]'
# PSQL command
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"
# check if input is provided
if [[ -z $1 ]]
then 
echo "Please provide an element as an argument."
# check if input is a number
elif [[ $1 =~ $NUM_CHECK ]]
then
ELEMENT_INFO=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$1") 
# if not found
if [[ -z $ELEMENT_INFO ]]
then 
echo "I could not find that element in the database."
else
echo $ELEMENT_INFO | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
do 
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
done
fi
# check if input is a symbol
elif [[ $1 =~ $SYMBOL_CHECK ]]
then
ELEMENT_INFO=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'") 
# if not found
if [[ -z $ELEMENT_INFO ]]
then 
echo "I could not find that element in the database."
else
echo $ELEMENT_INFO | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
do 
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
done
fi
else
ELEMENT_INFO=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name='$1'") 
# if not found
if [[ -z $ELEMENT_INFO ]]
then 
echo "I could not find that element in the database."
else
echo $ELEMENT_INFO | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
do 
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
done
fi
fi
