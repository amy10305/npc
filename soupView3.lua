-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--점수 판별
	if(j % 3 == 0 or j % 3 == 2)then
		rabbitpoint = rabbitpoint - 1
	end

	local c = 0
	
	--배경
	local background = display.newImage("이미지/음식/재료/1차/당근/가스레인지.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--냄비
	local pot = display.newImage("이미지/음식/재료/1차/당근/0번냄비.png")
	pot.x = display.contentWidth * 0.363
	pot.y = display.contentHeight * 0.4

	--불
	local fire = {}
	fire[1] = display.newImage("이미지/음식/재료/1차/당근/불_약불.png")
	fire[2] = display.newImage("이미지/음식/재료/1차/당근/불_중불.png")
	fire[3] = display.newImage("이미지/음식/재료/1차/당근/불_강불.png")

	fire[1].alpha=1

	for i=2,3 do
		fire[i].alpha=0
	end

	fire[1].y = display.contentHeight * 0.7
	fire[2].y = display.contentHeight * 0.65
	fire[3].y = display.contentHeight * 0.62

	for i=1,3 do
		fire[i].x = display.contentWidth * 0.363
		sceneGroup:insert(fire[i])
	end

	--손잡이
	local handle = {}
	handle[1] = display.newImage("이미지/음식/재료/1차/당근/손잡이_약불.png")
	handle[2] = display.newImage("이미지/음식/재료/1차/당근/손잡이_중불.png")
	handle[3] = display.newImage("이미지/음식/재료/1차/당근/손잡이_강불.png")

	handle[1].alpha = 1

	for i = 2, 3 do
		handle[i].alpha = 0
	end

	for i=1,3 do
		handle[i].x = display.contentWidth * 0.9
		handle[i].y = display.contentHeight * 0.85
		sceneGroup:insert(handle[i])
	end

	--다진마늘
	local butter = display.newImageRect("이미지/음식/재료/1차/버터.png", 368.25, 280.5)
	butter.x = display.contentWidth *0.2
	butter.y = display.contentHeight * 0.2
	sceneGroup:insert(butter)

	--당근
	local carrot = display.newImageRect("이미지/음식/재료/1차/당근썰기/당근_3단계.png", 626.25, 132)
	carrot.x = display.contentWidth *0.76
	carrot.y = display.contentHeight * 0.2
	sceneGroup:insert(carrot)

	--드래그 앤 드랍 이벤트
	carrot.id = "당근"
	butter.id = "버터"

	local function catch(event)
		if(event.phase == "began") then
			print(event.target.id.."드래그!")

			display.getCurrentStage():setFocus(event.target)
			event.target.isFocus = true
		elseif (event.phase == "moved") then
			if("event.target.isFocus") then

				event.target.x = event.xStart + event.xDelta
				event.target.y = event.yStart + event.yDelta
			end
		elseif(event.phase == "ended" or event.phase == "cancelled") then
			if(event.target.isFocus) then
				if( event.target.x < pot.x + 100 and event.target.x > pot.x - 100 and
				event.target.y < pot.y + 100 and event.target.y > pot.y - 100 )then
					display.remove(event.target)
					c = c + 1

					if(c == 2) then
						composer.removeScene( "soupView3" )
            			composer.setVariable("complete", true)
           				local options={
                			effect ="fade",
                			time=400
            				}
            			composer.gotoScene("soupView4",options)
					end
				else
				end

				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
			display.getCurrentStage():setFocus(nil)
			event.target.isFocus = false
		end
	end

		carrot:addEventListener("touch", catch)
		butter:addEventListener("touch", catch)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene