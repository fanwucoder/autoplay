
# -*- coding: utf-8 -*-
from lxml import etree

# a=etree.parse("ui.xml")
# data=a.xpath("//node[@text='main.lua']")[0]
# print(data.attrib.get("bounds"))

# b=etree.parse("ui1.xml")
# data=b.xpath("//node[@text='立即运行']")[0]
# print(data.attrib.get("bounds"))
a={
    "赫顿城":{
        "悬空":["矿脉","失落","龙族","幽暗","罪恶","天空","宫殿","冰火"],
             "暮光":["灼热", "幽寒", "黄昏","恶毒"],
               
    }
}
level={"普通","冒险","勇士","王者"}
all=[]
for k,v in a.items():
    for k1,v1 in v.items():
        for k2 in v1:
            for l in level:
                key="%s,%s,%s,%s,999,true"%(k,k1,k2,l)
                all.append(key)
print("-".join(all))