require("textureLoader")

function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then
    print("This file doesn't exist.")
    return {} 
  end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

-- tests the functions above



function string_split(s, d)
	local t = {}
	local i = 0
	local f
	local match = '(.-)' .. d .. '()'
	
	if string.find(s, d) == nil then
		return {s}
	end
	
	for sub, j in string.gmatch(s, match) do
		i = i + 1
		t[i] = sub
		f = j
	end
	
	if i ~= 0 then
		t[i+1] = string.sub(s, f)
	end
	
	return t
end 
function objLoader(files,x,y,z,size,texfile)
  
  points={}
  file = files
  lines = lines_from(file)
  tabs={}
  for i =1,#lines do
    tab={string_split(lines[i], "%s+")}
    table.insert(tabs,tab)
  end
  
  for i=1,#tabs do
    if tabs[i][1][1]=="v" then
      
      dot={}
      dot.x=(tabs[i][1][2]*10*3)
      dot.z=(tabs[i][1][4]*10*3)+100
      
      dot.y=-(tabs[i][1][3]*10*3)
     
      table.insert(dots,dot)
      table.insert(points,dot)
    end
    if tabs[i][1][1]=="mtllib" then
      color=texLoader(tabs[i][1][2])
    end
    
    if tabs[i][1][1]=="f" then  
      face={}
      face.p1=dots[#dots-#points+tonumber(string_split(string.sub(tabs[i][1][2],1,-1), "/")[1])]
      face.p2=dots[#dots-#points+tonumber(string_split(string.sub(tabs[i][1][3],1,-1), "/")[1])]
      face.p3=dots[#dots-#points+tonumber(string_split(string.sub(tabs[i][1][4],1,-1), "/")[1])]
      if #tabs[i][1]==5 then
        face.p4=dots[#dots-#points+tonumber(string_split(string.sub(tabs[i][1][5],1,-1), "/")[1])]
      end
      face.zDistance=(face.p1.z+face.p2.z+face.p3.z)/3
      face.object=files
      face.r=color.r
      face.g=color.g
      face.b=color.b
      face.e={r=color.re,g=color.ge,b=color.be}

      p1=face.p1
      p2=face.p2
      p3=face.p3
      v1=math.sqrt((p2.x-p1.x)^2+(p2.y-p1.y)^2+(p2.z-p1.z)^2)
      v2=math.sqrt((p3.x-p1.x)^2+(p3.y-p1.y)^2+(p3.z-p1.z)^2)
      vd={{(p2.x-p1.x)/v1,(p2.y-p1.y)/v1,(p2.z-p1.z)/v1},{(p3.x-p1.x)/v2,(p3.y-p1.y)/v2,(p3.z-p1.z)/v2}}
      
      vn={vd[1][2]*vd[2][3]-vd[1][3]*vd[2][2],vd[1][3]*vd[2][1]-vd[1][1]*vd[2][3],vd[1][1]*vd[2][2]-vd[1][2]*vd[2][1]}
      
     
      face.vd=vd
      face.vn=vn
      table.insert(faces,face)
    end
    
  end
  --texLoader("cuube.mtl")
end
