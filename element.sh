#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c" 

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  ELEMENT="$1"

  if [[ $ELEMENT =~ ^[0-9]+$ ]]

  then
    # Element Table
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ELEMENT")

    if [[ -z $ELEMENT_SYMBOL ]]
    then
      echo "I could not find that element in the database."
    else
    
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ELEMENT")

      # Properties Table
      PROPERTY_TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id)  WHERE atomic_number = $ELEMENT")
      PROPERTY_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ELEMENT")
      PROPERTY_MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ELEMENT")
      PROPERTY_BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ELEMENT")

      echo "The element with atomic number $(echo $ELEMENT | sed -r 's/^ *| *$//g') is $(echo $ELEMENT_NAME | sed -r 's/^ *| *$//g') ($(echo $ELEMENT_SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $PROPERTY_TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $PROPERTY_MASS | sed -r 's/^ *| *$//g') amu. $(echo $ELEMENT_NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $PROPERTY_MELTING | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $PROPERTY_BOILING | sed -r 's/^ *| *$//g') celsius."
    fi

  elif [[ $ELEMENT =~ ^[A-Za-z]{1,2}$ ]]
  then
    # Element Table
    ELEMENT_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = INITCAP('$ELEMENT')")

    if [[ -z $ELEMENT_NUMBER ]]
    then
      echo "I could not find that element in the database."
    else

      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ELEMENT_NUMBER")

      # Properties Table
      PROPERTY_TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number = $ELEMENT_NUMBER")
      PROPERTY_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ELEMENT_NUMBER")
      PROPERTY_MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ELEMENT_NUMBER")
      PROPERTY_BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ELEMENT_NUMBER")
      
      echo "The element with atomic number $(echo $ELEMENT_NUMBER | sed -r 's/^ *| *$//g') is $(echo $ELEMENT_NAME | sed -r 's/^ *| *$//g') ($(echo $ELEMENT | sed -r 's/^ *| *$//g')). It's a $(echo $PROPERTY_TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $PROPERTY_MASS | sed -r 's/^ *| *$//g') amu. $(echo $ELEMENT_NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $PROPERTY_MELTING | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $PROPERTY_BOILING | sed -r 's/^ *| *$//g') celsius."
    fi
  else
    # Elementstable
    ELEMENT_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = INITCAP('$ELEMENT')")

    if [[ -z $ELEMENT_NUMBER ]]
    then
      echo "I could not find that element in the database."
    else
    
      ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ELEMENT_NUMBER")

      # Properties Table
      PROPERTY_TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number = $ELEMENT_NUMBER")
      PROPERTY_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ELEMENT_NUMBER")
      PROPERTY_MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ELEMENT_NUMBER")
      PROPERTY_BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ELEMENT_NUMBER")
      
      echo "The element with atomic number $(echo $ELEMENT_NUMBER | sed -r 's/^ *| *$//g') is $(echo $ELEMENT | sed -r 's/^ *| *$//g') ($(echo $ELEMENT_SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $PROPERTY_TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $PROPERTY_MASS | sed -r 's/^ *| *$//g') amu. $(echo $ELEMENT | sed -r 's/^ *| *$//g') has a melting point of $(echo $PROPERTY_MELTING | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $PROPERTY_BOILING | sed -r 's/^ *| *$//g') celsius."
    
    fi
  fi
fi
