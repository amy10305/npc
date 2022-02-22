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
	local pot = {} 
	pot[1] = display.newImage("이미지/음식/재료/1차/당근/3물+당근냄비.png")
	pot[2] = display.newImage("이미지/음식/재료/1차/당근/4물+당근냄비_그을린.png")

	pot[1].alpha = 1
	pot[2].alpha = 0

	for i = 1, 2 do
		pot[i].x = display.contentWidth * 0.363
		pot[i].y = display.contentHeight * 0.4
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

	j=1
    local function click(event)
        j=j+1

		pot[1].alpha = 0
		pot[2].alpha = 1

		if (j % 3 == 1)then
			fire[3].alpha = 0
			handle[3].alpha = 0
			fire[1].alpha = 1
			handle[1].alpha = 1
		elseif (j % 3 == 2)then
			fire[1].alpha = 0
			handle[1].alpha = 0
			fire[2].alpha = 1
			handle[2].alpha = 1
		elseif (j % 3 == 0) then
			fire[2].alpha = 0
			handle[2].alpha = 0
			fire[3].alpha = 1
			handle[3].alpha = 1
        end
    end
    background:addEventListener("tap",click)

	sceneGroup:insert(pot[1])
	sceneGroup:insert(pot[2])


	--타이머
	local limit = 10
	local showLimit = display.newText(limit, display.contentWidth * 0.9, display.contentHeight * 0.1)
	showLimit:setFillColor(0)
	showLimit.size = 80
	sceneGroup:insert(showLimit)

	local function timeAttack(event)
		limit = limit - 1
		showLimit.text = limit

		if(limit == 0)then
			composer.removeScene( "soupView6" )
            composer.setVariable("complete", true)
            local options={
                effect ="fade",
                time=400
            }
            composer.gotoScene("soupView7",options)
		end
	end

	timer.performWithDelay(1000, timeAttack, 0)

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
