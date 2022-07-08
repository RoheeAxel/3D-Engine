--objects={}
require("loader")
require("player")

function to2D(x,y,z)
  return {player.FOV*(x+player.x)/(z-player.z)+love.graphics.getWidth()/2,player.FOV*((y+player.y)/(z-player.z))+love.graphics.getHeight()/2}
end


function rotate2 (M, O, angle)
  xM, yM, x, y=0
  --angle= angle*math.pi / 180
  xM = M[1] + O.x
  yM = M[2] + O.y

  x = xM * math.cos (-angle) + yM * math.sin (-angle) + O.x
  y = - xM * math.sin (-angle) + yM * math.cos (-angle) + O.y
  tab={}
  tab[1]=x
  tab[2]=y
  return tab
end


function point()
  for i=1,#dots do
    love.graphics.points(to2D(dots[i].x,dots[i].y,dots[i].z)[1],to2D(dots[i].x,dots[i].y,dots[i].z)[2])
  end
end

function getColor(i)
  vecteurDirecteur={0,0,1}
  u=vecteurDirecteur[1]*faces[i].vn[1]+vecteurDirecteur[2]*faces[i].vn[2]+vecteurDirecteur[3]*faces[i].vn[3]
  u=1-math.abs(u)/4  
  love.graphics.setColor(faces[i].r*u*1+faces[i].e.r,faces[i].g*u*1+faces[i].e.g,faces[i].b*u*1+faces[i].e.b)
end

function sortFace()
  -- sort ascending by num1
  table.sort(faces, function(a,b) return a.Distance > b.Distance end)
end

function intersect(x1,y1,x2,y2,x3,y3,x4,y4)

    denom = (y4-y3)*(x2-x1) - (x4-x3)*(y2-y1)
    if denom == 0 then 
        return nil
    end
    ua = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / denom
    if ua < 0 or ua > 1 then 
        return nil
    end
    ub = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / denom
    if ub < 0 or ub > 1 then 
        return nil
    end
    x = x1 + ua * (x2-x1)
    y = y1 + ua * (y2-y1)
    return {x,y}
end

function count(face)
  counter=7
  if face.p4~=nil then
    counter=15  
    if face.p4.z-player.z>player.distanceFromCam then
      counter=counter-8
    end
  end
  if face.p1.z-player.z>player.distanceFromCam then
    counter=counter-4
  end
  if face.p2.z-player.z>player.distanceFromCam then
    counter=counter-2
  end
  if face.p3.z-player.z>player.distanceFromCam then
    counter=counter-1
  end
  return counter
end

function draw()
  for i=1,#faces do
    getColor(i)
    counter=0
    if counter==0 then
      if faces[i].p4~=nil then
        love.graphics.polygon("fill",to2D(faces[i].p1.x,faces[i].p1.y,faces[i].p1.z)[1],to2D(faces[i].p1.x,faces[i].p1.y,faces[i].p1.z)[2],to2D(faces[i].p2.x,faces[i].p2.y,faces[i].p2.z)[1],to2D(faces[i].p2.x,faces[i].p2.y,faces[i].p2.z)[2],to2D(faces[i].p3.x,faces[i].p3.y,faces[i].p3.z)[1],to2D(faces[i].p3.x,faces[i].p3.y,faces[i].p3.z)[2],to2D(faces[i].p4.x,faces[i].p4.y,faces[i].p4.z)[1],to2D(faces[i].p4.x,faces[i].p4.y,faces[i].p4.z)[2])
      else
        --love.graphics.polygon("fill",to2D(faces[i].p1.x,faces[i].p1.y,faces[i].p1.z)[1],to2D(faces[i].p1.x,faces[i].p1.y,faces[i].p1.z)[2],to2D(faces[i].p2.x,faces[i].p2.y,faces[i].p2.z)[1],to2D(faces[i].p2.x,faces[i].p2.y,faces[i].p2.z)[2],to2D(faces[i].p3.x,faces[i].p3.y,faces[i].p3.z)[1],to2D(faces[i].p3.x,faces[i].p3.y,faces[i].p3.z)[2])
      end
      midx=(faces[i].p1.x+faces[i].p2.x+faces[i].p3.x)/3
      midy=(faces[i].p1.y+faces[i].p2.y+faces[i].p3.y)/3
      midz=(faces[i].p1.z+faces[i].p2.z+faces[i].p3.z)/3
      faces[i].Distance=math.sqrt((midx)^2+(midy)^2+(midz)^2)
    end
  end
  sortFace()
end





function newObject(path)
  faces={}
  dots={}
  
  objLoader(path)
  print(#dots)
  return {points=dots,faces=faces,draw=draw}
end



three={}
three.newObject=newObject
three.newPlayer=newPlayer
three.draw=draw
return three
