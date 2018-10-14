#! /usr/bin/env bash
#
# printBanner.sh
# prints text in Banner form


#Functions
function printLineOne()
{
case "$1" in
    a|A) echo -n "##########" ;;
    b|B) echo -n "##########" ;;
    c|C) echo -n "##########" ;;
    d|D) echo -n "##########" ;;
    e|E) echo -n "##########" ;;
    f|F) echo -n "##########" ;;
    g|G) echo -n "##########" ;;
    h|H) echo -n "##########" ;;
    i|I) echo -n "##########" ;;
    j|J) echo -n "##########" ;;
    k|K) echo -n "##########" ;;
    l|L) echo -n "##########" ;;
    m|M) echo -n "##########" ;;
    n|N) echo -n "##########" ;;
    o|O) echo -n "##########" ;;
    p|P) echo -n "##########" ;;
    q|Q) echo -n "##########" ;;
    r|R) echo -n "##########" ;;
    s|S) echo -n "##########" ;;
    t|T) echo -n "##########" ;;
    u|U) echo -n "##########" ;;
    v|V) echo -n "##########" ;;
    w|W) echo -n "##########" ;;
    x|X) echo -n "##########" ;;
    y|Y) echo -n "##########" ;;
    z|Z) echo -n "##########" ;;
    ,|.) echo -n "##########" ;;
    _|-) echo -n "##########" ;;
    1|2) echo -n "##########" ;;
    3|4) echo -n "##########" ;;
    5|6) echo -n "##########" ;;
    7|8) echo -n "##########" ;;
    9|0) echo -n "##########" ;;
    !) echo -n "##########" ;;
    *) echo -n "##########" ;;
esac
}

function printLineTwo()
{
case "$1" in
    A) echo -n "     *    " ;;
    B) echo -n "   * *    " ;;
    C) echo -n "   ****   " ;;
    D) echo -n "   ****   " ;;
    E) echo -n "   ****   " ;;
    F) echo -n "   ****   " ;;
    G) echo -n "   ***    " ;;
    H) echo -n "   *   *  " ;;
    I) echo -n "   *****  " ;;
    J) echo -n "   *****  " ;;
    K) echo -n "   *   *  " ;;
    L) echo -n "   *      " ;;
    M) echo -n "   ** **  " ;;
    N) echo -n "  **    * " ;;
    O) echo -n "   ***    " ;;
    P) echo -n "   * *    " ;;
    Q) echo -n "   ***    " ;;
    R) echo -n "   ***    " ;;
    S) echo -n "   ***    " ;;
    T) echo -n "   *****  " ;;
    U) echo -n "   *   *  " ;;
    V) echo -n "   *   *  " ;;
    W) echo -n "  *     * " ;;
    X) echo -n "  *   *   " ;;
    Y) echo -n "   *   *  " ;;
    Z) echo -n " *******  " ;;
    .) echo -n "          " ;;
    -) echo -n "          " ;;
    a) echo -n "    ***   " ;;
    b) echo -n "   *      " ;;
    c) echo -n "          " ;;
    d) echo -n "       *  " ;;
    e) echo -n "          " ;;
    f) echo -n "    ***   " ;;
    g) echo -n "    ***   " ;;
    h) echo -n "   *      " ;;
    i) echo -n "     *    " ;;
    j) echo -n "          " ;;
    k) echo -n "   *      " ;;
    l) echo -n "   *      " ;;
    m) echo -n "          " ;;
    n) echo -n "          " ;;
    o) echo -n "          " ;;
    p) echo -n "          " ;;
    q) echo -n "          " ;;
    r) echo -n "          " ;;
    s) echo -n "   **     " ;;
    t) echo -n "          " ;;
    u) echo -n "          " ;;
    v) echo -n "          " ;;
    w) echo -n "          " ;;
    x) echo -n "          " ;;
    y) echo -n "          " ;;
    z) echo -n "          " ;;
    1) echo -n "     *    " ;;
    2) echo -n "    * *   " ;;
    3) echo -n "    * *   " ;;
    4) echo -n "  *   *   " ;;
    5) echo -n "   * * *  " ;;
    6) echo -n "    * *   " ;;
    7) echo -n "  * * * * " ;;
    8) echo -n "    * *   " ;;
    9) echo -n "    * *   " ;;
    0) echo -n "   * *    " ;;
    ,) echo -n "          " ;;
    _) echo -n "          " ;;
    !) echo -n "    *     " ;;
    *) echo -n "          " ;;
esac
}

function printLineThree()
{
case "$1" in
    A) echo -n "   *   *  " ;;
    B) echo -n "   *   *  " ;;
    C) echo -n "   *      " ;;
    D) echo -n "   *   *  " ;;
    E) echo -n "   *      " ;;
    F) echo -n "   *      " ;;
    G) echo -n "  *       " ;;
    H) echo -n "   *   *  " ;;
    I) echo -n "     *    " ;;
    J) echo -n "     *    " ;;
    K) echo -n "   *  *   " ;;
    L) echo -n "   *      " ;;
    M) echo -n "  *  *  * " ;;
    N) echo -n "  * *   * " ;;
    O) echo -n "  *   *   " ;;
    P) echo -n "   *   *  " ;;
    Q) echo -n "  *   *   " ;;
    R) echo -n "   *  *   " ;;
    S) echo -n "  *       " ;;
    T) echo -n "     *    " ;;
    U) echo -n "   *   *  " ;;
    V) echo -n "   *   *  " ;;
    W) echo -n "  *     * " ;;
    X) echo -n "   * *    " ;;
    Y) echo -n "    * *   " ;;
    Z) echo -n "      *   " ;;
    .) echo -n "          " ;;
    -) echo -n "          " ;;
    a) echo -n "       *  " ;;
    b) echo -n "   *      " ;;
    c) echo -n "    **    " ;;
    d) echo -n "       *  " ;;
    e) echo -n "   * *    " ;;
    f) echo -n "   *      " ;;
    g) echo -n "   *   *  " ;;
    h) echo -n "   *      " ;;
    i) echo -n "          " ;;
    j) echo -n "     *    " ;;
    k) echo -n "   *  *   " ;;
    l) echo -n "   *      " ;;
    m) echo -n "   ** **  " ;;
    n) echo -n "   *      " ;;
    o) echo -n "   ***    " ;;
    p) echo -n "   ***    " ;;
    q) echo -n "   ***    " ;;
    r) echo -n "    **    " ;;
    s) echo -n "  *       " ;;
    t) echo -n "     *    " ;;
    u) echo -n "   *   *  " ;;
    v) echo -n "   *   *  " ;;
    w) echo -n "  *     * " ;;
    x) echo -n "  *   *   " ;;
    y) echo -n "   *   *  " ;;
    z) echo -n " *******  " ;;
    1) echo -n "   * *    " ;;
    2) echo -n "  *     * " ;;
    3) echo -n "        * " ;;
    4) echo -n "  *   *   " ;;
    5) echo -n "   *      " ;;
    6) echo -n "  *       " ;;
    7) echo -n "       *  " ;;
    8) echo -n "  *     * " ;;
    9) echo -n "   *   *  " ;;
    0) echo -n "  *   *   " ;;
    ,) echo -n "          " ;;
    _) echo -n "          " ;;
    !) echo -n "    *     " ;;
    *) echo -n "          " ;;
esac
}

function printLineFour()
{
case "$1" in
    A) echo -n "   *****  " ;;
    B) echo -n "   ****   " ;;
    C) echo -n "   *      " ;;
    D) echo -n "   *   *  " ;;
    E) echo -n "   ***    " ;;
    F) echo -n "   * *    " ;;
    G) echo -n "  *  ***  " ;;
    H) echo -n "   *****  " ;;
    I) echo -n "     *    " ;;
    J) echo -n "     *    " ;;
    K) echo -n "   **     " ;;
    L) echo -n "   *      " ;;
    M) echo -n "  *  *  * " ;;
    N) echo -n "  *  *  * " ;;
    O) echo -n "  *   *   " ;;
    P) echo -n "   ****   " ;;
    Q) echo -n "  *  **   " ;;
    R) echo -n "   ***    " ;;
    S) echo -n "    **    " ;;
    T) echo -n "     *    " ;;
    U) echo -n "   *   *  " ;;
    V) echo -n "   *   *  " ;;
    W) echo -n "  *  *  * " ;;
    X) echo -n "    *     " ;;
    Y) echo -n "     *    " ;;
    Z) echo -n "    *     " ;;
    .) echo -n "          " ;;
    -) echo -n " -------- " ;;
    a) echo -n "    ****  " ;;
    b) echo -n "   ****   " ;;
    c) echo -n "   *      " ;;
    d) echo -n "     * *  " ;;
    e) echo -n "  *****   " ;;
    f) echo -n "  ****    " ;;
    g) echo -n "    ***   " ;;
    h) echo -n "   ****   " ;;
    i) echo -n "     *    " ;;
    j) echo -n "     *    " ;;
    k) echo -n "   **     " ;;
    l) echo -n "   *      " ;;
    m) echo -n "  *  *  * " ;;
    n) echo -n "   ****   " ;;
    o) echo -n "  *   *   " ;;
    p) echo -n "   *  *   " ;;
    q) echo -n "  *   *   " ;;
    r) echo -n "   *  *   " ;;
    s) echo -n "    *     " ;;
    t) echo -n "   * * *  " ;;
    u) echo -n "   *   *  " ;;
    v) echo -n "   *   *  " ;;
    w) echo -n "  *  *  * " ;;
    x) echo -n "    *     " ;;
    y) echo -n "    * *   " ;;
    z) echo -n "     *    " ;;
    1) echo -n "     *    " ;;
    2) echo -n "      *   " ;;
    3) echo -n "      *   " ;;
    4) echo -n "  * * *   " ;;
    5) echo -n "   * *    " ;;
    6) echo -n "  * * *   " ;;
    7) echo -n "      *   " ;;
    8) echo -n "    * *   " ;;
    9) echo -n "     * *  " ;;
    0) echo -n "  *   *   " ;;
    ,) echo -n "   *      " ;;
    _) echo -n "          " ;;
    !) echo -n "    *     " ;;
    *) echo -n "          " ;;
esac
}

function printLineFive()
{
case "$1" in
    A) echo -n "   *   *  " ;;
    B) echo -n "   *   *  " ;;
    C) echo -n "   *      " ;;
    D) echo -n "   *   *  " ;;
    E) echo -n "   *      " ;;
    F) echo -n "   *      " ;;
    G) echo -n "  *   **  " ;;
    H) echo -n "   *   *  " ;;
    I) echo -n "     *    " ;;
    J) echo -n "  *  *    " ;;
    K) echo -n "   *  *   " ;;
    L) echo -n "   *      " ;;
    M) echo -n "  *     * " ;;
    N) echo -n "  *   * * " ;;
    O) echo -n "  *   *   " ;;
    P) echo -n "   *      " ;;
    Q) echo -n "  *   *   " ;;
    R) echo -n "   *  *   " ;;
    S) echo -n "      *   " ;;
    T) echo -n "     *    " ;;
    U) echo -n "   *   *  " ;;
    V) echo -n "    * *   " ;;
    W) echo -n "  *  *  * " ;;
    X) echo -n "   * *    " ;;
    Y) echo -n "     *    " ;;
    Z) echo -n "  *       " ;;
    .) echo -n "    **    " ;;
    -) echo -n "          " ;;
    a) echo -n "   *   *  " ;;
    b) echo -n "   *   *  " ;;
    c) echo -n "   *      " ;;
    d) echo -n "   *   *  " ;;
    e) echo -n "  *       " ;;
    f) echo -n "   *      " ;;
    g) echo -n "      *   " ;;
    h) echo -n "   *   *  " ;;
    i) echo -n "     *    " ;;
    j) echo -n "  *  *    " ;;
    k) echo -n "   * *    " ;;
    l) echo -n "   *      " ;;
    m) echo -n "  *  *  * " ;;
    n) echo -n "   *   *  " ;;
    o) echo -n "  *   *   " ;;
    p) echo -n "   **     " ;;
    q) echo -n "   ***    " ;;
    r) echo -n "   *      " ;;
    s) echo -n "      *   " ;;
    t) echo -n "     *    " ;;
    u) echo -n "   *   *  " ;;
    v) echo -n "    * *   " ;;
    w) echo -n "  *  *  * " ;;
    x) echo -n "    *     " ;;
    y) echo -n "     *    " ;;
    z) echo -n "   *      " ;;
    1) echo -n "     *    " ;;
    2) echo -n "    *     " ;;
    3) echo -n "        * " ;;
    4) echo -n "      *   " ;;
    5) echo -n "       *  " ;;
    6) echo -n "  *     * " ;;
    7) echo -n "     *    " ;;
    8) echo -n "  *     * " ;;
    9) echo -n "       *  " ;;
    0) echo -n "  *   *   " ;;
    ,) echo -n "   *      " ;;
    _) echo -n "          " ;;
    !) echo -n "          " ;;
    *) echo -n "          " ;;
esac
}

function printLineSix()
{
case "$1" in
    A) echo -n "   *   *  " ;;
    B) echo -n "   * *    " ;;
    C) echo -n "   ****   " ;;
    D) echo -n "   ****   " ;;
    E) echo -n "   ****   " ;;
    F) echo -n "   *      " ;;
    G) echo -n "   *** *  " ;;
    H) echo -n "   *   *  " ;;
    I) echo -n "   *****  " ;;
    J) echo -n "   **     " ;;
    K) echo -n "   *   *  " ;;
    L) echo -n "   ****   " ;;
    M) echo -n "  *     * " ;;
    N) echo -n "  *    ** " ;;
    O) echo -n "   ***    " ;;
    P) echo -n "   *      " ;;
    Q) echo -n "   *** *  " ;;
    R) echo -n "   *   *  " ;;
    S) echo -n "   ***    " ;;
    T) echo -n "     *    " ;;
    U) echo -n "    ***   " ;;
    V) echo -n "     *    " ;;
    W) echo -n "   ** **  " ;;
    X) echo -n "  *   *   " ;;
    Y) echo -n "     *    " ;;
    Z) echo -n " *******  " ;;
    .) echo -n "    **    " ;;
    -) echo -n "          " ;;
    a) echo -n "    *** * " ;;
    b) echo -n "   * *    " ;;
    c) echo -n "    **    " ;;
    d) echo -n "    *** * " ;;
    e) echo -n "   ***    " ;;
    f) echo -n "   *      " ;;
    g) echo -n "    **    " ;;
    h) echo -n "   *   *  " ;;
    i) echo -n "     *    " ;;
    j) echo -n "   **     " ;;
    k) echo -n "   *  *   " ;;
    l) echo -n "   *      " ;;
    m) echo -n "  *     * " ;;
    n) echo -n "   *   *  " ;;
    o) echo -n "   ***    " ;;
    p) echo -n "   *      " ;;
    q) echo -n "      * * " ;;
    r) echo -n "   *      " ;;
    s) echo -n "   **     " ;;
    t) echo -n "     *    " ;;
    u) echo -n "    ***   " ;;
    v) echo -n "     *    " ;;
    w) echo -n "   ** **  " ;;
    x) echo -n "  *   *   " ;;
    y) echo -n "     *    " ;;
    z) echo -n " *******  " ;;
    1) echo -n "   * * *  " ;;
    2) echo -n "  * * * * " ;;
    3) echo -n "    * *   " ;;
    4) echo -n "      *   " ;;
    5) echo -n "   * *    " ;;
    6) echo -n "    * *   " ;;
    7) echo -n "    *     " ;;
    8) echo -n "    * *   " ;;
    9) echo -n "       *  " ;;
    0) echo -n "   * *    " ;;
    ,) echo -n " **       " ;;
    _) echo -n " -------- " ;;
    !) echo -n "    *     " ;;
    *) echo -n "          " ;;
esac
}
#start printing
echo ""

for SUFFIX in One Two Three Four Five Six One
do

echo -n "#"
for TEXT in "${@}"
do
INDEX=0
WORD_COUNT=$(\echo -n "${TEXT}" | grep -ao -E "[[:alnum:][:space:].,!_-]{1}" | grep --count -ao -E "[[:alnum:][:space:],.!_-]{1}" )
WORD=$(\echo -n "${TEXT}" | grep -ao -E "[[:alnum:][:space:].,!_-]{1}" )
WORD=$(\echo -n $WORD )
#eval WORD_COUNT=$(($WORD_COUNT+1))
while [[ ( ${INDEX} -le ${WORD_COUNT} ) ]]
do

eval INDEX=$(($INDEX+1))
if [[ ( ${INDEX} -le ${WORD_COUNT} ) ]] ; then
LETTER=$(\echo -n "${WORD}" | cut -d " " -f ${INDEX} )
#\echo -n "${INDEX}/${WORD_COUNT}=${LETTER}"
eval printLine${SUFFIX} "\${LETTER}"
wait;
fi

done

unset INDEX
unset WORD_COUNT
unset WORD
unset LETTER

eval printLine${SUFFIX} " "
done
echo "#"
done

echo ""

exit 0;
###########
#     *    
#   *   *  
#   *****  
#   *   *  
#   *   *  
###########

###########
#    ***   
#       *  
#    ****  
#   *   *  
#    *** * 
###########

###########
#   * *    
#   *   *  
#   ****   
#   *   *  
#   * *    
###########

###########
#   *      
#   *      
#   ****   
#   *   *  
#   * *    
###########

###########
#   ****    
#   *      
#   *      
#   *      
#   ****   
###########

###########
#          
#    **    
#   *      
#   *      
#    **    
###########

###########
#   ****   
#   *   *  
#   *   * 
#   *   *  
#   ****   
###########

###########
#       *  
#       *  
#     * *  
#   *   *  
#    *** * 
###########

###########
#   ****   
#   *      
#   ***    
#   *      
#   ****   
###########

###########
#          
#   * *    
#  *****   
#  *       
#   ***    
###########

###########
#   ****   
#   *      
#   ***  
#   *    
#   *      
###########

###########
#    ***   
#   *      
#  ****    
#   *    
#   *      
###########

###########
#   ***    
#  *       
#  *  ***  
#  *   **  
#   *** *  
###########

###########
#    ***    
#   *   *  
#    ***   
#      *  
#    **
###########

###########
#   *   *    
#   *   *  
#   *****  
#   *   *  
#   *   *  
###########

###########
#   *        
#   *      
#   ****   
#   *   *  
#   *   *  
###########

###########
#   *****    
#     *    
#     *    
#     *    
#   *****  
###########

###########
#     *      
#          
#     *    
#     *    
#     *    
###########

###########
#   *****    
#     *    
#     *    
#  *  *     
#   **     
###########

###########
#            
#     *    
#     *    
#  *  *     
#   **     
###########

###########
#   *   *    
#   *  *   
#   **     
#   *  *   
#   *   *  
###########

###########
#   *      
#   *  *   
#   **     
#   * *    
#   *  *   
###########

###########
#   *      
#   *    
#   *    
#   *    
#   ****   
###########

###########
#   *      
#   *    
#   *    
#   *    
#   *      
###########

###########
#   ** **  
#  *  *  * 
#  *  *  *
#  *     * 
#  *     *
###########

###########
#          
#   ** **  
#  *  *  * 
#  *  *  *
#  *     * 
###########

###########
#  **    *  
#  * *   * 
#  *  *  * 
#  *   * * 
#  *    ** 
###########

###########
#            
#   *      
#   ****   
#   *   *  
#   *   *  
###########

###########
#   ***    
#  *   *   
#  *   *  
#  *   *   
#   ***    
###########

###########
#          
#   ***    
#  *   *   
#  *   *   
#   ***    
###########

###########
#   * *    
#   *   *  
#   ****   
#   *      
#   *    
###########

###########
#          
#   ***    
#   *  *   
#   **     
#   *      
###########

###########
#   ***    
#  *   *   
#  *  **   
#  *   *   
#   *** *  
###########

###########
#          
#   ***    
#  *   *   
#   ***    
#      * * 
###########

###########
#   ***     
#   *  *   
#   ***    
#   *  *   
#   *   *  
###########

###########
#          
#    **    
#   *  *   
#   *      
#   *      
###########

###########
#   ***    
#  *       
#    **    
#      *   
#   ***    
###########

###########
#   **     
#  *       
#    *     
#      *   
#   **     
###########

###########
#   *****    
#     *    
#     *    
#     *    
#     *    
###########

###########
#          
#     *    
#   * * *  
#     *    
#     *    
###########

###########
#   *   *  
#   *   *  
#   *   *  
#   *   *  
#    ***   
###########

###########
#          
#   *   *  
#   *   *  
#   *   *  
#    ***   
###########

###########
#   *   *  
#   *   *  
#   *   *  
#    * *   
#     *    
###########

###########
#          
#   *   *  
#   *   *  
#    * *   
#     *    
###########

###########
#  *     * 
#  *     * 
#  *  *  * 
#  *  *  * 
#   ** **  
###########

###########
#          
#  *     * 
#  *  *  * 
#  *  *  * 
#   ** **  
###########

###########
#  *   *    
#   * *    
#    *     
#   * *    
#  *   *   
###########

###########
#          
#  *   *   
#    *     
#    *     
#  *   *   
###########

###########
#   *   *    
#    * *   
#     *    
#     *    
#     *    
###########

###########
#          
#   *   *  
#    * *   
#     *    
#     *    
###########

###########
# *******   
#      *   
#    *     
#  *       
# *******  
###########

###########
#          
# *******   
#     *    
#   *      
# *******  
###########

###########
#     *    
#   * *    
#     *    
#     *    
#   * * *  
###########

###########
#    * *   
#  *     * 
#      *   
#    *     
#  * * * * 
###########

###########
#    * *   
#        * 
#      *   
#        * 
#    * *   
###########

###########
#  *   *   
#  *   *   
#  * * *   
#      *   
#      *   
###########

###########
#   * * *  
#   *      
#   * *    
#       *  
#   * *    
###########

###########
#    * *   
#  *       
#  * * *   
#  *     * 
#    * *   
###########

###########
#  * * * * 
#       *  
#      *   
#     *    
#    *     
###########

###########
#    * *   
#  *     * 
#    * *   
#  *     * 
#    * *   
###########

###########
#    * *    
#   *   *   
#     * *   
#       *  
#       *  
###########

###########
#   * *    
#  *   *   
#  *   *  
#  *   *   
#   * *    
###########

###########
#          
#          
#          
#    **        
#    **    
###########

###########
#          
#          
#            
#   *      
# **       
###########

###########
#          
#          
# -------- 
#          
#          
###########

###########
#          
#          
#          
#          
# -------- 
###########

###########
#    **    
#    **    
#          
#    **        
#    **    
###########

###########
#    *     
#    *     
#    *     
#              
#    *     
###########

###########
#          
#          
#          
#          
#          
###########
