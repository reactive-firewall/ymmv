#! /usr/bin/env bash
# Disclaimer of Warranties.
# A. YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT, TO THE EXTENT PERMITTED BY
#    APPLICABLE LAW, USE OF THIS SHELL SCRIPT AND ANY SERVICES PERFORMED
#    BY OR ACCESSED THROUGH THIS SHELL SCRIPT IS AT YOUR SOLE RISK AND
#    THAT THE ENTIRE RISK AS TO SATISFACTORY QUALITY, PERFORMANCE, ACCURACY AND
#    EFFORT IS WITH YOU.
#
# B. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THIS SHELL SCRIPT
#    AND SERVICES ARE PROVIDED "AS IS" AND “AS AVAILABLE”, WITH ALL FAULTS AND
#    WITHOUT WARRANTY OF ANY KIND, AND THE AUTHOR OF THIS SHELL SCRIPT'S LICENSORS
#    (COLLECTIVELY REFERRED TO AS "THE AUTHOR" FOR THE PURPOSES OF THIS DISCLAIMER)
#    HEREBY DISCLAIM ALL WARRANTIES AND CONDITIONS WITH RESPECT TO THIS SHELL SCRIPT
#    SOFTWARE AND SERVICES, EITHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
#    NOT LIMITED TO, THE IMPLIED WARRANTIES AND/OR CONDITIONS OF
#    MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A PARTICULAR PURPOSE,
#    ACCURACY, QUIET ENJOYMENT, AND NON-INFRINGEMENT OF THIRD PARTY RIGHTS.
#
# C. THE AUTHOR DOES NOT WARRANT AGAINST INTERFERENCE WITH YOUR ENJOYMENT OF THE
#    THE AUTHOR's SOFTWARE AND SERVICES, THAT THE FUNCTIONS CONTAINED IN, OR
#    SERVICES PERFORMED OR PROVIDED BY, THIS SHELL SCRIPT WILL MEET YOUR
#    REQUIREMENTS, THAT THE OPERATION OF THIS SHELL SCRIPT OR SERVICES WILL
#    BE UNINTERRUPTED OR ERROR-FREE, THAT ANY SERVICES WILL CONTINUE TO BE MADE
#    AVAILABLE, THAT THIS SHELL SCRIPT OR SERVICES WILL BE COMPATIBLE OR
#    WORK WITH ANY THIRD PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES,
#    OR THAT DEFECTS IN THIS SHELL SCRIPT OR SERVICES WILL BE CORRECTED.
#    INSTALLATION OF THIS THE AUTHOR SOFTWARE MAY AFFECT THE USABILITY OF THIRD
#    PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES.
#
# D. YOU FURTHER ACKNOWLEDGE THAT THIS SHELL SCRIPT AND SERVICES ARE NOT
#    INTENDED OR SUITABLE FOR USE IN SITUATIONS OR ENVIRONMENTS WHERE THE FAILURE
#    OR TIME DELAYS OF, OR ERRORS OR INACCURACIES IN, THE CONTENT, DATA OR
#    INFORMATION PROVIDED BY THIS SHELL SCRIPT OR SERVICES COULD LEAD TO
#    DEATH, PERSONAL INJURY, OR SEVERE PHYSICAL OR ENVIRONMENTAL DAMAGE,
#    INCLUDING WITHOUT LIMITATION THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
#    NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, LIFE SUPPORT OR
#    WEAPONS SYSTEMS.
#
# E. NO ORAL OR WRITTEN INFORMATION OR ADVICE GIVEN BY THE AUTHOR
#    SHALL CREATE A WARRANTY. SHOULD THIS SHELL SCRIPT OR SERVICES PROVE DEFECTIVE,
#    YOU ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
#
#    Limitation of Liability.
# F. TO THE EXTENT NOT PROHIBITED BY APPLICABLE LAW, IN NO EVENT SHALL THE AUTHOR
#    BE LIABLE FOR PERSONAL INJURY, OR ANY INCIDENTAL, SPECIAL, INDIRECT OR
#    CONSEQUENTIAL DAMAGES WHATSOEVER, INCLUDING, WITHOUT LIMITATION, DAMAGES
#    FOR LOSS OF PROFITS, CORRUPTION OR LOSS OF DATA, FAILURE TO TRANSMIT OR
#    RECEIVE ANY DATA OR INFORMATION, BUSINESS INTERRUPTION OR ANY OTHER
#    COMMERCIAL DAMAGES OR LOSSES, ARISING OUT OF OR RELATED TO YOUR USE OR
#    INABILITY TO USE THIS SHELL SCRIPT OR SERVICES OR ANY THIRD PARTY
#    SOFTWARE OR APPLICATIONS IN CONJUNCTION WITH THIS SHELL SCRIPT OR
#    SERVICES, HOWEVER CAUSED, REGARDLESS OF THE THEORY OF LIABILITY (CONTRACT,
#    TORT OR OTHERWISE) AND EVEN IF THE AUTHOR HAS BEEN ADVISED OF THE
#    POSSIBILITY OF SUCH DAMAGES. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION
#    OR LIMITATION OF LIABILITY FOR PERSONAL INJURY, OR OF INCIDENTAL OR
#    CONSEQUENTIAL DAMAGES, SO THIS LIMITATION MAY NOT APPLY TO YOU. In no event
#    shall THE AUTHOR's total liability to you for all damages (other than as may
#    be required by applicable law in cases involving personal injury) exceed
#    the amount of five dollars ($5.00). The foregoing limitations will apply
#    even if the above stated remedy fails of its essential purpose.
################################################################################
# printBanner.sh
# prints text in Banner form
hash echo || :;

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
