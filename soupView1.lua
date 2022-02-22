-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--테이블
	local background = display.newImage("이미지/음식/요리테이블.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)


	--당근

	local carrot = {}
	carrot[1] = display.newImage("이미지/음식/재료/1차/당근썰기/당근_1단계.png")
	carrot[2] = display.newImage("이미지/음식/재료/1차/당근썰기/당근_2단계.png")
	carrot[3] = display.newImage("이미지/음식/재료/1차/당근썰기/당근_3단계.png")

	carrot[1].alpha=1

	for i=2,3 do
		carrot[i].alpha=0
	end

	for i=1,3 do
		carrot[i].x = display.contentWidth /2
		carrot[i].y = display.contentHeight / 2
		sceneGroup:insert(carrot[i])
	end

	local j=1
    local function click(event)
        j=j+1
        if j>1 and j<=3 then
            carrot[j-1].alpha=0
            carrot[j].alpha=1
        end

        if j==4 then 
            composer.removeScene( "soupView1" )
            composer.setVariable("complete", true)
            local options={
                effect ="fade",
                time=400
            }
            composer.gotoScene("soupView2",options)
        end

    end
    background:addEventListener("tap",click)
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
