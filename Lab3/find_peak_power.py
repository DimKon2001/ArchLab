import os
from pathlib import Path
yourpath = os.curdir + "/Lab3/mcpat-results"
txt_files = []
names = []
for root, dirs, files in os.walk(yourpath, topdown=False):  
    for name in files:
        if(name[len(name) - 3 : len(name) ]) == "txt":
            
            names.append(name)

print([x.name for x in Path(yourpath).iterdir() if x.is_dir()])  


'''```
index = 0
        for name in files:
            if index == 5:
                index = 0
            if index != 0 :
                index += 1
                continue
            
            index += 1
            if(name[len(name) - 3 : len(name) ]) == "txt":
                print(root)
                txt_files.append(os.path.join(root, name))
                names.append(name)
                with open(os.path.join(root, name)) as f:
                    for line in f:
                        if "Peak Power" in line:
                            c = 1
                            #print(dirs)
                            #print(line)

'''

cases = []
txt_files = []
for x in Path(yourpath).iterdir():
    case_directory  = os.path.join(os.curdir,x)
    for test_case in Path(case_directory).iterdir():
        iter = 0
        for root, dirs, files in os.walk(test_case, topdown=True):  
            for name in files:
                if iter == 5:
                    iter = 0
                if iter != 0 :
                    iter += 1
                    continue
                iter += 1
                if(name[len(name) - 3 : len(name) ]) == "txt":
                    txt_files.append(os.path.join(root, name))
                    cases.append(test_case)
                    
        
    

for test_case , file in zip(cases, txt_files):
    print("\nFor case: ", test_case)
    print(file)
        

data = []
for file in txt_files:
    with open(file) as f:
            for line in f:
                if "Peak Power" in line:
                    data.append(line)

case = ["L2_A"]

with open("peak_power.txt", "w+") as f1:
    index = 0
    for test_case , d in zip(cases, data):
        index += 1
        f1.write(str(test_case) + d) 
        #if find(case[0])
