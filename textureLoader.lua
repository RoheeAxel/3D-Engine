
function file_exists(file)
  print(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end
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

function texLoader(files)
  
  file = files
  lines = lines_from(file)
  ttabs={}
  
  for i =1,#lines do
    tab={string_split(lines[i], "%s+")}
    table.insert(ttabs,tab)
  end
  r=1
  g=1
  b=1
  for i=1,#ttabs do
    
    
    if ttabs[i][1][1]=="Kd" then
      r=ttabs[i][1][2]
      g=ttabs[i][1][3]
      b=ttabs[i][1][4]
      
    end
    if ttabs[i][1][1]=="Ke" then
      re=ttabs[i][1][2]
      ge=ttabs[i][1][3]
      be=ttabs[i][1][4]
      
    end
  
  end
  return {r=r,g=g,b=b,re=re,ge=ge,be=be}  
end