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
	local background = display.newImage("이미지/음식/요리테이블.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--그릇
	local pot = display.newImage("이미지/음식/재료/1차/당근/7당근스프냄비.png")
	pot.x = display.contentWidth /2
	pot.y = display.contentHeight * 0.6
	sceneGroup:insert(pot)

	--후추
	local pe = display.newImageRect("이미지/음식/재료/1차/후추.png",160.5, 308.8125)
	pe.x = display.contentWidth *0.8
	pe.y = display.contentHeight * 0.18
	sceneGroup:insert(pe)

	--소금
	local salt = display.newImageRect("이미지/음식/재료/1차/설탕.png",160.5, 308.8125)
	salt.x = display.contentWidth *0.2
	salt.y = display.contentHeight * 0.18
	sceneGroup:insert(salt)
	
	--설탕
	local sugar = display.newImageRect("이미지/음식/재료/1차/소금.png",160.5, 308.8125)
	sugar.x = display.contentWidth /2
	sugar.y = display.contentHeight * 0.15
	sceneGroup:insert(sugar)

	--조미료 넣기
	pe.id = "후추"
	sugar.id = "설탕"
	salt.id = "소금"

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

						composer.removeScene( "soupView9" )
            			composer.setVariable("complete", true)
            			composer.gotoScene("soupView10",options)
				else
				end

				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
			display.getCurrentStage():setFocus(nil)
			event.target.isFocus = false
		end
	end

	pe:addEventListener("touch", catch)
	sugar:addEventListener("touch", catch)
	salt:addEventListener("touch", catch)

		
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
