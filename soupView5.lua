-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local c = 0
	
	--배경
	local background = display.newImage("이미지/음식/요리테이블.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--냄비
	local pot = display.newImage("이미지/음식/재료/1차/추가/빈볼.png")
	pot.x = display.contentWidth / 2
	pot.y = display.contentHeight * 0.6
	sceneGroup:insert(pot)

	--물
	local water = display.newImageRect("이미지/음식/재료/1차/물.png", 192.375,487.125)
	water.x = display.contentWidth *0.2
	water.y = display.contentHeight * 0.3
	sceneGroup:insert(water)

	--다진마늘
	local garlic = display.newImageRect("이미지/음식/재료/1차/다진마늘.png", 324.75, 245.625)
	garlic.x = display.contentWidth *0.8
	garlic.y = display.contentHeight * 0.3
	sceneGroup:insert(garlic)

	--드래그 앤 드랍 이벤트
	water.id = "물"
	garlic.id = "마늘"

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
						composer.removeScene( "soupView5" )
            			composer.setVariable("complete", true)
           				local options={
                			effect ="fade",
                			time=400
            				}
            			composer.gotoScene("soupView6",options)
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

		water:addEventListener("touch", catch)
		garlic:addEventListener("touch", catch)

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