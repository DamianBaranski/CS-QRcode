#!/bin/bash

module load matlab

screen -m -d matlab -nosplash -nodesktop -r "tests('qr_code.png','zigzag','standard');quit"
screen -m -d matlab -nosplash -nodesktop -r "tests('qr_code.png','zigzag','haar');quit"
screen -m -d matlab -nosplash -nodesktop -r "tests('qr_code.png','zigzag','welsh');quit"
screen -m -d matlab -nosplash -nodesktop -r "tests('qr_codeR.png','zigzag','standard');quit"
screen -m -d matlab -nosplash -nodesktop -r "tests('qr_codeR.png','zigzag','haar');quit"
screen -m -d matlab -nosplash -nodesktop -r "tests('qr_codeR.png','zigzag','welsh');quit"

screen -m -d matlab -nosplash -nodesktop -r "tests('qr_code.png','standard','standard');quit"
screen -m -d matlab -nosplash -nodesktop -r "tests('qr_code.png','standard','haar');quit"
screen -m -d matlab -nosplash -nodesktop -r "tests('qr_code.png','standard','welsh');quit"
screen -m -d matlab -nosplash -nodesktop -r "tests('qr_codeR.png','standard','standard');quit"
screen -m -d matlab -nosplash -nodesktop -r "tests('qr_codeR.png','standard','haar');quit"
screen -m -d matlab -nosplash -nodesktop -r "tests('qr_codeR.png','standard','welsh');quit"

