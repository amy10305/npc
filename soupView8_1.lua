-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--배경
	local background = display.newImage("이미지/음식/재료/1차/당근/가스레인지.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--냄비
	local pot = display.newImage("이미지/음식/재료/1차/당근/7당근스프냄비.png")
	pot.x = display.contentWidth * 0.363
	pot.y = display.contentHeight * 0.4
	sceneGroup:insert(pot)

	--국자
	local ladle = display.newImageRect("이미지/음식/재료/1차/당근/국자_빈.png",526.5, 730.5)
	ladle.x = display.contentWidth *0.8
	ladle.y = display.contentHeight * 0.4
	sceneGroup:insert(ladle)

	--드래그 앤 드랍 이벤트
	ladle.id = "주걱"

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

						composer.removeScene( "soupView8_1" )
            			composer.setVariable("complete", true)
            			composer.gotoScene("soupView8_2",options)
				else
				end

				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
			display.getCurrentStage():setFocus(nil)
			event.target.isFocus = false
		end
	end

	ladle:addEventListener("touch", catch)
		
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
