function newPlayer()
  return {x=0,y=0,z=0,move=move,angle=0,FOV = 300,distanceFromCam = 20}
end




function move(dt)
  if love.keyboard.isDown("q") then
    player.z=player.z+(100*dt)*math.sin(player.angle)
    player.x=player.x+(100*dt)*math.cos(player.angle)
  end
  if love.keyboard.isDown("d") then
    player.z=player.z-(100*dt)*math.sin(player.angle)
    player.x=player.x-(100*dt)*math.cos(player.angle)
  end
  if love.keyboard.isDown("z") then
    player.z=player.z+(100*dt)*math.cos(player.angle)
    player.x=player.x-(100*dt)*math.sin(player.angle)
  end
  if love.keyboard.isDown("s") then
    player.z=player.z-(100*dt)*math.cos(player.angle)
    player.x=player.x+(100*dt)*math.sin(player.angle)
  end
  if love.keyboard.isDown("e") then
    player.y=player.y+100*dt
  end
  if love.keyboard.isDown("x") then
    player.y=player.y-100*dt
  end
  if love.keyboard.isDown("right") then
    player.angle=player.angle+1*dt
  end
  if love.keyboard.isDown("left") then
    player.angle=player.angle-1*dt
  end
end