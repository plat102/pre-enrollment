# 1. Import the **file `text.txt`** inside **`LinuxProject`** folder ****
cp ./text.txt ./LinuxProject/
# move:
# mv ./text.txt ./LinuxProject/

# 2. Display the contents of **`text.txt`** on the terminal.
cat ./LinuxProject/text.txt

# 3. Append the following text to **`text.txt`**:
#     Let's learn Linux.
echo -e "\nLet's learn Linux." >> ./LinuxProject/text.txt
    
# 4. Count the number of lines in **`text.txt`**.
# https://stackoverflow.com/questions/3137094/count-number-of-lines-in-a-non-binary-file-like-a-csv-or-a-txt-file-in-termina
wc -l ./LinuxProject/text.txt

# 5. Search for the word "Love" in **`text.txt`** and display the lines containing it.
grep "Love" ./LinuxProject/text.txt

# 6. Replace "Make" with "Do".
# https://www.geeksforgeeks.org/linux-unix/sed-command-in-linux-unix-with-examples/
sed -i 's/Make/Do/g' ./LinuxProject/text.txt

# 7. Display only the third word from each line in **`text.txt`**.
# https://www.geeksforgeeks.org/linux-unix/awk-command-unixlinux-examples/
awk 'NF=3' ./LinuxProject/text.txt

# 8. Count the number of words in each line.
awk '{ print NF }' ./LinuxProject/text.txt
