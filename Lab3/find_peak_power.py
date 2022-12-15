import os

yourpath = os.curdir + "/Lab3/mcpat-results"
txt_files = []
names = []
for root, dirs, files in os.walk(yourpath, topdown=False):  
    for name in files:
        if(name[len(name) - 3 : len(name) ]) == "txt":
            txt_files.append(os.path.join(root, name))
            names.append(name)
      
data = []
for file in txt_files:
    with open(file) as f:
            for line in f:
                if "Peak Power" in line:
                    data.append(line)


with open("peak_power.txt", "w+") as f1:
    index = 0
    for d, name in zip(data,names):
        f1.write(name + d) 
