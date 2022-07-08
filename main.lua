require("Object")

function love.load()
  player=three.newPlayer()
  dog=three.newObject("dog.obj")
  
end

function love.draw()
  dog.draw()
  love.graphics.points(player.x+400,player.z+300)
  love.graphics.points(dog.points[1].x+400,dog.points[1].z+300)
  love.graphics.points(dog.points[8].x+400,dog.points[1].z+300)
end

function love.update(dt)
  player.move(dt)
end